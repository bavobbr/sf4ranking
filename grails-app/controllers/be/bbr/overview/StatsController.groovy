package be.bbr.overview

import be.bbr.sf4ranking.*
import org.apache.commons.math.stat.descriptive.SummaryStatistics
import org.apache.shiro.SecurityUtils

/**
 * Do some datamining
 */
class StatsController
{

    QueryService queryService

    def index()
    {
        Version game = Version.fromString(params.game)
        log.info "got stats request for game $game"
        if (!game) game = Version.AE2012
        def cstats = CharacterStats.findAllByGame(game)
        log.info "returning ${cstats.size()} char stats"
        cstats.removeAll {it.characterType == CharacterType.UNKNOWN}
        cstats = cstats.sort {a, b -> b.totalTimesUsed <=> a.totalTimesUsed}
        Map<Version, GameStats> statsmap = [:]
        if (game in [Version.VANILLA, Version.SUPER, Version.AE, Version.AE2012]) {
            def vanillaStats = GameStats.findByGame(Version.VANILLA) ?: new GameStats(game: Version.VANILLA)
            def superStats = GameStats.findByGame(Version.SUPER) ?: new GameStats(game: Version.SUPER)
            def aeStats = GameStats.findByGame(Version.AE) ?: new GameStats(game: Version.AE)
            def ae2012Stats = GameStats.findByGame(Version.AE2012) ?: new GameStats(game: Version.AE2012)
            statsmap[vanillaStats.game] = vanillaStats
            statsmap[superStats.game] = superStats
            statsmap[aeStats.game] = aeStats
            statsmap[ae2012Stats.game] = ae2012Stats
        }
        else {
            def gs = GameStats.findByGame(game) ?: new GameStats(game: game)
            statsmap[gs.game] = gs
        }
        return [results: cstats, game: game, gamestats: statsmap]
    }

    def character()
    {
        Version game = Version.fromString(params.game)
        CharacterType charType = CharacterType.fromString(params.charname, Version.generalize(game))
        CharacterStats stats = CharacterStats.findByGameAndCharacterType(game, charType)
        log.info "Finding 5 best players for game $game"
        def best = queryService.findPlayers(charType, null, 100, 0, game)
        def bestMainplayers = best ? best.findAll {charType in it.main(game)} : null
        def bestSecondaryplayers = best ? best.findAll {!(charType in it.main(game))} : null
        def best5m = bestMainplayers.take(5)
        def best5s = bestSecondaryplayers.take(5)
        def others = CharacterStats.findAllByGame(game)
        others.removeAll {it.characterType == CharacterType.UNKNOWN}
        def statnames = ["totalTimesUsed", "scoreAccumulated", "rankAccumulated", "totalUsagePercentage", "asMainInTop100", "asMainInTop50",
                "asMain", "asSecondary", "decayedScoreAccumulated", "decayedScoreAccumulatedByTop100", "scoreAccumulatedByTop100",
                "top1finishes", "top3finishes", "top8finishes", "top16finishes", "meanTop5Score", "meanTop5Usage"]
        def relativeStats = [:]
        statnames.each {String stat ->
            def index = others.sort {a, b -> b."$stat" <=> a."$stat"}.findIndexOf {it.characterType == charType} + 1
            relativeStats[stat] = index
        }
        def reversestatnames = ["spreadTop5Score", "standardDeviationTop5Score", "spreadTop5Usage", "standardDeviationTop5Usage"]
        reversestatnames.each {String stat ->
            def index = others.sort {a, b -> a."$stat" <=> b."$stat"}.findIndexOf {it.characterType == charType} + 1
            relativeStats[stat] = index
        }
        return [stats: stats, best5: best5m, best5secondaries: best5s, relativeStats: relativeStats, total: others.size()]
    }

    def analyze()
    {
        if (!SecurityUtils.subject.hasRole("Administrator"))
        {
            render(status: 503, text: 'You need permission')
        }
        Version game = Version.fromString(params.game)
        deleteOld(game)
        def characters = listCharacters(game)
        Map<CharacterType, CharacterStats> statsmap = [:]
        log.info "Counting by char type"
        def byCharacterType = characters.countBy {it.characterType}
        log.info "Creating char stats objects"
        byCharacterType.each {
            CharacterStats cstats = new CharacterStats(characterType: it.key, game: game)
            cstats.totalUsagePercentage = (it.value / characters.size()) * 100
            cstats.totalTimesUsed = it.value
            statsmap[it.key] = cstats
        }
        calculateScores(characters, statsmap)
        mainUsagetop100(game, statsmap)
        mainUsagetop50(game, statsmap)
        mainUsage(game, statsmap)
        secondaryUsage(game, statsmap)
        findBestPlayers(game, statsmap)
        scoreByTop100(game, statsmap)
        decayedScore(characters, statsmap)
        decayedScoreByTop100(game, statsmap)
        topfinishes(characters, statsmap)
        statsForBest5(game, statsmap)
        statsmap.values()*.save(failOnError: true)
        generateGameStats(game)
        statisticsForGamestats(game)
        redirect(controller: "stats", action: "index", params: [game: game])
    }

    private List usageSeries(Version game)
    {
        def count = CharacterType.count(game)
        def top500 = queryService.findPlayers(null, null, 500, 0, game)
        List series = []
        Set usedChars = []
        def processed = top500.takeWhile {Player p ->
            p.main(game).each {def main ->
                if (main != CharacterType.UNKNOWN)
                {
                    usedChars << main
                }
                series << usedChars.size()
            }
            return usedChars.size() < count
        }
        log.info "Processed till ${processed?.last()} items ${processed.size()}"
        return series
    }

    private def listCharacters(Version game)
    {
        log.info "Listing all gamechars"
        def chars = GameCharacter.list()
        log.info "Grouping by game $game"
        def byTournamentVersion = chars.groupBy {it.gameTeam.result.tournament.game}
        return byTournamentVersion[game]
    }

    private void deleteOld(Version game)
    {
        def old = CharacterStats.findAllByGame(game)
        def oldstats = GameStats.findAllByGame(game)
        old*.delete()
        oldstats*.delete()
    }

    private GameStats generateGameStats(Version game)
    {
        def usageSeries = usageSeries(game)
        log.info "Usage series is ${usageSeries}"
        GameStats gs = new GameStats(game: game)
        if (usageSeries)
        {
            gs.usageSeries = usageSeries.join(",")
            def val50 = usageSeries.get(Math.min(49, usageSeries.size() - 1))
            def val100 = usageSeries.get(Math.min(99, usageSeries.size() - 1))
            def total = CharacterType.count(game)
            log.info "Expecting a total of $total chars in game $game"
            gs.percentageInTop50 = val50 / total * 100
            gs.percentageInTop100 = val100 / total * 100
            def countAt25 = (total * 0.25) as Integer
            def countAt50 = (total * 0.5) as Integer
            def countAt75 = (total * 0.75) as Integer
            def countAt100 = total
            gs.rankOfCharAt25Percent = usageSeries.findIndexOf {it >= countAt25}
            gs.rankOfCharAt50Percent = usageSeries.findIndexOf {it >= countAt50}
            gs.rankOfCharAt75Percent = usageSeries.findIndexOf {it >= countAt75}
            gs.rankOfCharAt100Percent = usageSeries.findIndexOf {it >= countAt100}
        }
        log.info "Saving gamestats"
        gs.save(failOnError: true)
        log.info "Saved gamestats"
        return gs
    }

    private void statisticsForGamestats(Version game) {
        GameStats gs = GameStats.findByGame(game)
        SummaryStatistics scorestats = new SummaryStatistics()
        SummaryStatistics mainstats = new SummaryStatistics()
        SummaryStatistics usagestats = new SummaryStatistics()
        SummaryStatistics usagepercentstats = new SummaryStatistics()
        def allChars = CharacterStats.findAllByGame(game)
        allChars.each {
            scorestats.addValue(it.scoreAccumulated)
            mainstats.addValue(it.asMain)
            usagestats.addValue(it.totalTimesUsed)
            usagepercentstats.addValue(it.totalUsagePercentage)
            log.info "Added samples $it.scoreAccumulated and ${it.asMain} to stats"
        }
        gs.meanOnScore = scorestats.mean
        gs.varianceOnScore = scorestats.variance
        gs.standardDeviationOnScore = scorestats.standardDeviation
        gs.meanOnMain = mainstats.mean
        gs.varianceOnMain = mainstats.variance
        gs.standardDeviationOnMain = mainstats.standardDeviation
        gs.meanOnUsage = usagestats.mean
        gs.standardDeviationOnUsage = usagestats.standardDeviation
        gs.meanOnUsagePercent = usagepercentstats.mean
        gs.standardDeviationOnUsagePercent = usagepercentstats.standardDeviation
        gs.sampleSize = mainstats.n
        gs.save(failOnError: true)
    }

    private void calculateScores(List<CharacterStats> characters, Map statsmap)
    {
        log.info "Calculating scores"
        characters.each {GameCharacter gc ->
            CharacterStats stats = statsmap[gc.characterType]
            Result r = gc.gameTeam.result
            def score = ScoringSystem.getScore(r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
            stats.scoreAccumulated += score
            stats.rankAccumulated += 33 - r.place
        }
    }

    private void topfinishes(List<CharacterStats> characters, Map statsmap)
    {
        log.info "Top finishes"
        HitMap<CharacterType> charhitstop1 = new HitMap<>()
        HitMap<CharacterType> charhitstop3 = new HitMap<>()
        HitMap<CharacterType> charhitstop8 = new HitMap<>()
        HitMap<CharacterType> charhitstop16 = new HitMap<>()
        characters.each {GameCharacter gc ->
            Result r = gc.gameTeam.result
            if (r.place == 1)
            {
                charhitstop1.addHit(gc.characterType)
            }
            if (r.place <= 3)
            {
                charhitstop3.addHit(gc.characterType)
            }
            if (r.place <= 8)
            {
                charhitstop8.addHit(gc.characterType)
            }
            if (r.place <= 16)
            {
                charhitstop16.addHit(gc.characterType)
            }
        }
        charhitstop1.each {k, v ->
            CharacterStats stats = statsmap[k]
            stats?.top1finishes = v
        }
        charhitstop3.each {k, v ->
            CharacterStats stats = statsmap[k]
            stats?.top3finishes = v
        }
        charhitstop8.each {k, v ->
            CharacterStats stats = statsmap[k]
            stats?.top8finishes = v
        }
        charhitstop16.each {k, v ->
            CharacterStats stats = statsmap[k]
            stats?.top16finishes = v
        }
    }


    private void decayedScore(List<CharacterStats> characters, Map statsmap)
    {
        log.info "Calculating scores"
        characters.each {GameCharacter gc ->
            CharacterStats stats = statsmap[gc.characterType]
            Result r = gc.gameTeam.result
            def score = ScoringSystem.
                    getDecayedScore(r.tournament.date, r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
            stats.decayedScoreAccumulated += score
        }
    }

    private void mainUsagetop100(Version game, Map statsmap)
    {
        log.info "Checking top 100 usage"
        def top100 = queryService.findPlayers(null, null, 100, 0, game)
        List<CharacterType> mains = top100.collect {it.findRanking(game).mainCharacters}.flatten()
        def byType = mains.countBy {it}
        log.info "Top100 details are ${byType}"
        byType.each {def k, v ->
            CharacterStats stats = statsmap[k]
            stats?.asMainInTop100 = v
        }
    }

    private void scoreByTop100(Version game, Map statsmap)
    {
        log.info "Checking top 100 scores"
        def top100 = queryService.findPlayers(null, null, 100, 0, game)
        top100.each {Player p ->
            p.results.findAll {it.tournament.game == game}.each {Result r ->
                def score = ScoringSystem.getScore(r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
                r.characterTeams.each {
                    it.pchars.each {
                        CharacterStats cstats = statsmap[it.characterType]
                        cstats.scoreAccumulatedByTop100 += score
                    }
                }
            }
        }
    }

    private void statsForBest5(Version game, Map statsmap)
    {
        log.info "doing stats top 5 players"
        CharacterType.forGame(game).each { CharacterType charType ->
            def best = queryService.findPlayers(charType, null, 100, 0, game)
            def top5 = best ? best.findAll {charType in it.main(game)} : null
            SummaryStatistics charScoreStats = new SummaryStatistics()
            SummaryStatistics charUsageStats = new SummaryStatistics()
            top5.each {Player p ->
                charScoreStats.addValue(p.score(game))
                def timesUsed = p.results.count { charType in (it.characterTeams.collect{ it.pchars.characterType}.flatten() )}
                charUsageStats.addValue(timesUsed)
            }
            CharacterStats stats = statsmap[charType]
            stats?.meanTop5Score = charScoreStats.mean
            stats?.standardDeviationTop5Score = charScoreStats.standardDeviation
            stats?.meanTop5Usage = charUsageStats.mean
            stats?.standardDeviationTop5Usage = charUsageStats.standardDeviation
            stats?.spreadTop5Score = charScoreStats.max - charScoreStats.min
            stats?.spreadTop5Usage = charUsageStats.max - charUsageStats.min
            log.info "Added top5 stats for char $charType"
        }
    }

    private void decayedScoreByTop100(Version game, Map statsmap)
    {
        log.info "Checking top 100 decayed scores"
        def top100 = queryService.findPlayers(null, null, 100, 0, game)
        top100.each {Player p ->
            p.results.findAll {it.tournament.game == game}.each {Result r ->
                def score = ScoringSystem.
                        getDecayedScore(r.tournament.date, r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
                r.characterTeams.each {
                    it.pchars.each {
                        CharacterStats cstats = statsmap[it.characterType]
                        cstats.decayedScoreAccumulatedByTop100 += score
                    }
                }
            }
        }
    }

    private def mainUsagetop50(Version game, Map statsmap)
    {
        log.info "Checking top 50 usage"
        def top100 = queryService.findPlayers(null, null, 50, 0, game)
        List<CharacterType> mains = top100.collect {it.findRanking(game).mainCharacters}.flatten()
        def byType = mains.countBy {it}
        log.info "Top50 details are ${byType}"
        byType.each {def k, v ->
            CharacterStats stats = statsmap[k]
            stats?.asMainInTop50 = v
        }
    }

    private def mainUsage(Version game, Map statsmap)
    {
        log.info "Checking all main usage"
        def all = queryService.findPlayers(null, null, 10000, 0, game)
        List<CharacterType> mains = all.collect {it.findRanking(game)?.mainCharacters}.flatten()
        def byType = mains.countBy {it}
        log.info "Top details are ${byType}"
        byType.each {def k, v ->
            CharacterStats stats = statsmap[k]
            stats?.asMain = v
        }
    }

    private def secondaryUsage(Version game, Map statsmap)
    {
        log.info "Checking all secondary usage"
        def all = queryService.findPlayers(null, null, 10000, 0, game)
        HitMap<CharacterType> charhits = new HitMap<>()
        all.each {
            Set<CharacterType> mains = it.findRanking(game)?.mainCharacters
            Set<CharacterType> allUsed = it.results.findAll {it.tournament.game == game}.
                    collect {it.characterTeams.collect {it.pchars.characterType}.flatten()}.flatten()
            Set<CharacterType> secondaries = allUsed.minus(mains)
            secondaries.each {charhits.addHit(it)}
        }
        log.info "Secondaries are ${charhits}"
        charhits.each {def k, v ->
            CharacterStats stats = statsmap[k]
            stats?.asSecondary = v
        }
    }

    private def findBestPlayers(Version game, Map statsmap)
    {
        log.info "Finding best players for game $game"
        Map charToPlayer = [:]
        CharacterType.values().findAll {it.game == Version.generalize(game)}.each {CharacterType ctype ->
            def best = queryService.findPlayers(ctype, null, 100, 0, game)
            def bestplayer = best ? best.find {ctype in it.main(game)} : null
            charToPlayer[ctype] = bestplayer
        }
        charToPlayer.each {k, v ->
            CharacterStats stats = statsmap[k]
            log.info "Assigning $v as best player for $k"
            stats?.player = v
        }
    }
}
