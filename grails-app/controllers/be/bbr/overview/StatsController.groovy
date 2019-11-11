package be.bbr.overview

import be.bbr.sf4ranking.*
import grails.plugin.cache.Cacheable
import org.apache.commons.math.stat.descriptive.SummaryStatistics
import org.apache.shiro.SecurityUtils
import org.joda.time.DateTime

/**
 * Do some datamining
 */
class StatsController
{

    QueryService queryService
    MaxoplataService maxoplataService

    def index()
    {
        Version game = Version.fromString(params.game)
        log.info "got stats request for game $game"
        if (!game) game = Version.SF5
        def cstats = CharacterStats.findAllByGame(game)
        log.info "returning ${cstats.size()} char stats"
        cstats.removeAll {it.characterType == CharacterType.UNKNOWN}
        cstats = cstats.sort {a, b -> a.decayedRank <=> b.decayedRank}
        Map<Version, GameStats> statsmap = [:]
        if (game in [Version.VANILLA, Version.SUPER, Version.AE, Version.AE2012, Version.USF4]) {
            def vanillaStats = GameStats.findByGame(Version.VANILLA) ?: new GameStats(game: Version.VANILLA)
            vanillaStats.metaClass.players << { PlayerRanking.countByGame(Version.VANILLA) }
            vanillaStats.metaClass.mainTotal << {
                def charstats = CharacterStats.findAllByGame(Version.VANILLA)
                charstats.sum { CharacterStats cs -> cs.asMain }
            }
            vanillaStats.metaClass.usageTotal << {
                def charstats = CharacterStats.findAllByGame(Version.VANILLA)
                charstats.sum { CharacterStats cs -> cs.totalTimesUsed }
            }
            def superStats = GameStats.findByGame(Version.SUPER) ?: new GameStats(game: Version.SUPER)
            superStats.metaClass.players << { PlayerRanking.countByGame(Version.SUPER) }
            superStats.metaClass.mainTotal << {
                def charstats = CharacterStats.findAllByGame(Version.SUPER)
                charstats.sum { CharacterStats cs -> cs.asMain }
            }
            superStats.metaClass.usageTotal << {
                def charstats = CharacterStats.findAllByGame(Version.SUPER)
                charstats.sum { CharacterStats cs -> cs.totalTimesUsed }
            }
            def aeStats = GameStats.findByGame(Version.AE) ?: new GameStats(game: Version.AE)
            aeStats.metaClass.players << { PlayerRanking.countByGame(Version.AE) }
            aeStats.metaClass.mainTotal << {
                def charstats = CharacterStats.findAllByGame(Version.AE)
                charstats.sum { CharacterStats cs -> cs.asMain }
            }
            aeStats.metaClass.usageTotal << {
                def charstats = CharacterStats.findAllByGame(Version.AE)
                charstats.sum { CharacterStats cs -> cs.totalTimesUsed }
            }

            def ae2012Stats = GameStats.findByGame(Version.AE2012) ?: new GameStats(game: Version.AE2012)
            ae2012Stats.metaClass.players << { PlayerRanking.countByGame(Version.AE2012) }
            ae2012Stats.metaClass.mainTotal << {
                def charstats = CharacterStats.findAllByGame(Version.AE2012)
                charstats.sum { CharacterStats cs -> cs.asMain }
            }
            ae2012Stats.metaClass.usageTotal << {
                def charstats = CharacterStats.findAllByGame(Version.AE2012)
                charstats.sum { CharacterStats cs -> cs.totalTimesUsed }
            }

            def usf4Stats = GameStats.findByGame(Version.USF4) ?: new GameStats(game: Version.USF4)
            usf4Stats.metaClass.players << { PlayerRanking.countByGame(Version.USF4) }
            usf4Stats.metaClass.mainTotal << {
                def charstats = CharacterStats.findAllByGame(Version.USF4)
                charstats.sum { CharacterStats cs -> cs.asMain }
            }
            usf4Stats.metaClass.usageTotal << {
                def charstats = CharacterStats.findAllByGame(Version.USF4)
                charstats.sum { CharacterStats cs -> cs.totalTimesUsed }
            }

            statsmap[vanillaStats.game] = vanillaStats
            statsmap[superStats.game] = superStats
            statsmap[aeStats.game] = aeStats
            statsmap[ae2012Stats.game] = ae2012Stats
            statsmap[usf4Stats.game] = usf4Stats
        }
        else {
            def gs = GameStats.findByGame(game) ?: new GameStats(game: game)
            gs.metaClass.players << { PlayerRanking.countByGame(game) }
            gs.metaClass.mainTotal << {
                def charstats = CharacterStats.findAllByGame(game)
                charstats.sum { CharacterStats cs -> cs.asMain }
            }
            gs.metaClass.usageTotal << {
                def charstats = CharacterStats.findAllByGame(game)
                charstats.sum { CharacterStats cs -> cs.totalTimesUsed }
            }
            statsmap[gs.game] = gs
        }
        return [results: cstats, game: game, gamestats: statsmap]
    }

    @Cacheable("charstats")
    def character()
    {
        log.info("Rendering char stats for params $params")
        Version game = Version.fromString(params.game)
        log.info("Game is $game")
        CharacterType charType = CharacterType.fromString(params.charname, Version.generalize(game))
        log.info("Char is is $charType")
        Map<Version, CharacterStats> games = [:]
        if (game in [Version.USF4, Version.AE2012, Version.AE, Version.SUPER, Version.VANILLA]) {
            games[Version.VANILLA.value] = CharacterStats.findByGameAndCharacterType(Version.VANILLA, charType)
            games[Version.SUPER.value] = CharacterStats.findByGameAndCharacterType(Version.SUPER, charType)
            games[Version.AE.value] = CharacterStats.findByGameAndCharacterType(Version.AE, charType)
            games[Version.AE2012.value] = CharacterStats.findByGameAndCharacterType(Version.AE2012, charType)
            games[Version.USF4.value] = CharacterStats.findByGameAndCharacterType(Version.USF4, charType)
        }
        else {
            games[game.value] = CharacterStats.findByGameAndCharacterType(game, charType)
        }
        log.info "Finding 5 best players for game $game and char $charType"
        def best = queryService.findPlayers(charType, null, 100, 0, game)
        log.info "Finding 5 best trending players for game $game and char $charType"
        def bestTrending = queryService.findPlayers(charType, null, 100, 0, game, RankingType.TRENDING)
        def bestMainplayers = best ? best.findAll {charType in it.main(game)} : []
        def bestTrendingplayers = bestTrending ? bestTrending.findAll {charType in it.main(game)} : []
        log.info "Finding 5 best secondary players for game $game and char $charType"
        def bestSecondaryplayers = best ? best.findAll {
            !(charType in it.main(game))
        } : []
        def best5m = bestMainplayers.take(5)
        def best5t = bestTrendingplayers.take(5)
        def best5s = bestSecondaryplayers.take(5)
        log.info "Finding stats for game $game and char $charType"
        def others = CharacterStats.findAllByGame(game)
        others.removeAll {it.characterType == CharacterType.UNKNOWN}
        def statnames = ["totalTimesUsed", "scoreAccumulated", "rankAccumulated", "totalUsagePercentage", "asMainInTop100", "asMainInTop50",
                "asMain", "asSecondary", "decayedScoreAccumulated", "decayedScoreAccumulatedByTop100", "trendingScoreAccumulated", "trendingScoreAccumulatedByTop100", "scoreAccumulatedByTop100",
                "top1finishesTrending", "top1finishes", "top3finishes", "top8finishes", "top16finishes", "meanTop5Score", "meanTop5Usage"]
        def relativeStats = [:]
        statnames.each {String stat ->
            def index = others.sort {a, b -> b."$stat" <=> a."$stat"}.findIndexOf {it.characterType == charType} + 1
            relativeStats[stat] = index
        }
        def reversestatnames = ["spreadTop5Score", "standardDeviationTop5Score", "spreadTop5Usage", "standardDeviationTop5Usage", "trendingRank", "decayedRank", "alltimeRank"]
        reversestatnames.each {String stat ->
            def index = others.sort {a, b -> a."$stat" <=> b."$stat"}.findIndexOf {it.characterType == charType} + 1
            relativeStats[stat] = index
        }
        log.info "Finding ranking results for game $game and char $charType"
        def characters = GameCharacter.findAllByCharacterType(charType)
        println "Found ${characters.size()} GameCharacters for $charType"
        def teams = characters.collect { it.gameTeam }
        println "Found ${teams.size()} GameTeam for $charType"
        def results = teams.collect { it.result }
        println "Found ${results.size()} Result for $charType"

        def top1 = results.count { it.place <= 1 }
        def top3 = results.count { it.place <= 3 }
        def top8 = results.count { it.place <= 8 }
        def top16 = results.count { it.place <= 16 }
        def total = results.size()
        println "total is ${results.size()}"
        def totalTournamentsUsed = results.unique(false) { it.tournamentId }.size()
        println "total is ${results.size()}"

        def totalTournaments = Tournament.countByGame(game)
        Integer usedPercentage = totalTournamentsUsed / totalTournaments * 100

        def tournamentWins = results.findAll { it.place == 1 && it.tournament.tournamentType != TournamentType.LOCAL}
        tournamentWins.sort { ScoringSystem.getScore(it.place, it.tournament.tournamentType, it.tournament.tournamentFormat) }.reverse(true)
        def tournamentAll = results.findAll { it.tournament.tournamentType != TournamentType.LOCAL}
        tournamentAll.sort { ScoringSystem.getScore(it.place, it.tournament.tournamentType, it.tournament.tournamentFormat) }.reverse(true)
        log.info "Returning data for game $game and char $charType"

        return [stats: games[game.value],
                best5: best5m,
                best5trending: best5t,
                best5secondaries: best5s,
                relativeStats: relativeStats,
                total: others.size(),
                games: games,
                top1: top1, top3: top3, top8: top8, top16: top16,
                totalResults: total,
                totalTournamentsUsed: totalTournamentsUsed,
                usedPercentage: usedPercentage,
                tournamentWins: tournamentWins,
                tournamentAll: tournamentAll,
                characterType: charType,
                game: game
        ]
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
        findBestTrendingPlayers(game, statsmap)
        scoreByTop100(game, statsmap)
        decayedScore(characters, statsmap)
        decayedScoreByTop100(game, statsmap)
        trendingScore(characters, statsmap, game)
        trendingScoreByTop100(game, statsmap)
        topfinishes(characters, statsmap)
        rankings(statsmap)
        statsmap.values().each {
            log.info "Saving stats for ${it.characterType}: ${it}"
            it.save(failOnError: true)
        }
        statsForBest5(game, statsmap)
        statsmap.values().each {
            log.info "Saving stats for ${it.characterType}: ${it}"
            it.save(failOnError: true)
        }
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
        if (processed) {
            log.info "Processed till ${processed?.last()} items ${processed.size()}"
        }
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
            def score = ScoringSystem.getLegacyScore(r.place, r.tournament.weight, r.tournament.tournamentFormat)
            stats.scoreAccumulated += score
            stats.rankAccumulated += 33 - r.place
        }
    }

    private void topfinishes(List<CharacterStats> characters, Map statsmap)
    {
        log.info "Top finishes"
        HitMap<CharacterType> charhitstop1recent = new HitMap<>()
        HitMap<CharacterType> charhitstop1 = new HitMap<>()
        HitMap<CharacterType> charhitstop3 = new HitMap<>()
        HitMap<CharacterType> charhitstop8 = new HitMap<>()
        HitMap<CharacterType> charhitstop16 = new HitMap<>()
        def window = new DateTime().minusMonths(6)
        characters.each {GameCharacter gc ->
            Result r = gc.gameTeam.result
            if (r.tournament.tournamentType != TournamentType.LOCAL) {
                if (r.place == 1) {
                    charhitstop1.addHit(gc.characterType)
                    if (r.tournament.date?.after(window.toDate())) {
                        charhitstop1recent.addHit(gc.characterType)
                    }
                }
                if (r.place <= 3) {
                    charhitstop3.addHit(gc.characterType)
                }
                if (r.place <= 8) {
                    charhitstop8.addHit(gc.characterType)
                }
                if (r.place <= 16) {
                    charhitstop16.addHit(gc.characterType)
                }
            }
        }
        charhitstop1recent.each {k, v ->
            CharacterStats stats = statsmap[k]
            stats?.top1finishesTrending = v
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
        characters.each { GameCharacter gc ->
            CharacterStats stats = statsmap[gc.characterType]
            Result r = gc.gameTeam.result
            def date = r.tournament.game.end?.toDate()?: new Date()
            def score = ScoringSystem.
                    getDecayedScore(r.tournament.date, date, r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
            stats.decayedScoreAccumulated += score
        }
    }

    private void trendingScore(List<CharacterStats> characters, Map statsmap, Version game)
    {
        log.info "Calculating trending scores"
        def last = queryService.lastTournament(game)
        DateTime window = new DateTime(last.date.time).minusMonths(6)
        characters.each { GameCharacter gc ->
            CharacterStats stats = statsmap[gc.characterType]
            Result r = gc.gameTeam.result
            def end = r.tournament.game.end?.toDate()?: new Date()
            if (window.isBefore(r.tournament.date.time)) {
                def score = ScoringSystem.getDecayedScore(r.tournament.date, end, r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
                stats.trendingScoreAccumulated += score
            }
        }
    }

    private void mainUsagetop100(Version game, Map statsmap)
    {
        log.info "Checking top 100 usage"
        def top100 = queryService.findPlayers(null, null, 100, 0, game)
        log.info "top 100 size is ${top100.size()}"
        top100.retainAll { it.findRanking(game) != null }
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
            log.info "Looking for best 5 of $charType"
            def best = queryService.findPlayers(charType, null, 100, 0, game)
            log.info "Found ${best.size()} for $charType"
            def top5 = best ? best.findAll {charType in it.main(game)} : null
            log.info "Found top5 $top5"
            SummaryStatistics charScoreStats = new SummaryStatistics()
            SummaryStatistics charUsageStats = new SummaryStatistics()
            top5.each {Player p ->
                charScoreStats.addValue(p.score(game))
                def timesUsed = p.results.count { charType in (it.characterTeams.collect{ it.pchars.characterType}.flatten() )}
                log.info "Adding ${timesUsed} times used for char $charType by player ${p.name}"
                charUsageStats.addValue(timesUsed)
            }
            if (top5) {
                (5-top5.size()).times { charUsageStats.addValue(0) }
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
                def end = r.tournament.game.end?.toDate()?: new Date()
                def score = ScoringSystem.
                        getDecayedScore(r.tournament.date, end, r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
                r.characterTeams.each {
                    it.pchars.each {
                        CharacterStats cstats = statsmap[it.characterType]
                        cstats.decayedScoreAccumulatedByTop100 += score
                    }
                }
            }
        }
    }

    private void trendingScoreByTop100(Version game, Map statsmap)
    {
        DateTime window = new DateTime(queryService.lastTournament(game).date.time).minusMonths(6)
        log.info "Checking top 100 decayed scores"
        def top100 = queryService.findPlayers(null, null, 100, 0, game)
        top100.each {Player p ->
            p.results.findAll {it.tournament.game == game}.each {Result r ->
                def end = r.tournament.game.end?.toDate()?: new Date()
                if (window.isBefore(r.tournament.date.time)) {
                    def score = ScoringSystem.getDecayedScore(r.tournament.date, end, r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
                    r.characterTeams.each {
                        it.pchars.each {
                            CharacterStats cstats = statsmap[it.characterType]
                            cstats.trendingScoreAccumulatedByTop100 += score
                        }
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

    private def findBestTrendingPlayers(Version game, Map statsmap)
    {
        log.info "Finding best trending players for game $game"
        Map charToPlayer = [:]
        CharacterType.values().findAll {it.game == Version.generalize(game)}.each {CharacterType ctype ->
            def best = queryService.findPlayers(ctype, null, 100, 0, game, RankingType.TRENDING)
            def bestplayer = best ? best.find {ctype in it.main(game)} : null
            charToPlayer[ctype] = bestplayer
        }
        charToPlayer.each {k, v ->
            CharacterStats stats = statsmap[k]
            log.info "Assigning $v as best trending player for $k"
            stats?.trendingPlayer = v
        }
    }

    private void rankings(LinkedHashMap<CharacterType, CharacterStats> characterTypeCharacterStats) {
        characterTypeCharacterStats.values().sort { it.scoreAccumulated }.reverse().eachWithIndex { def stat, def idx ->
            stat.alltimeRank = idx+1
        }
        characterTypeCharacterStats.values().sort { it.decayedScoreAccumulated }.reverse().eachWithIndex { def stat, def idx ->
            stat.decayedRank = idx+1
        }
        characterTypeCharacterStats.values().sort { it.trendingScoreAccumulated }.reverse().eachWithIndex { def stat, def idx ->
            stat.trendingRank = idx+1
        }
    }

    def compare()
    {
        def p1 = params.p1? Player.get(params.p1) : null
        def p2 = params.p2? Player.get(params.p2) : null
        println "Setting up for compare of $p1 vs $p2"
        [p1: p1, p2: p2]
    }

    def compareResults()
    {
        def p1 = Player.findByCodename(params.p1.toUpperCase())
        def p2 = Player.findByCodename(params.p2.toUpperCase())
        if (!p1 || !p2) {
            render(text: "Player data not found for parmeter data $params", contentType: "text/plain", encoding: "UTF-8")
            return null
        }
        List<Comparison> comparisons = []
        def head2headTable = [:]
        if (p1.maxoplataId && p2.maxoplataId) {
            head2headTable = maxoplataService.comparePlayers(p1, p2)
            print head2headTable
        }
        Version.values().each { game ->
            def p1Rank = p1.rankings.find { it.game == game }
            def p2Rank = p2.rankings.find { it.game == game }
            if (p1Rank && p2Rank) {
                println "comparing between ranks $p1Rank and $p2Rank"
                def p1Tournaments = p1.results.findAll { it.tournament.game == game}.collect { it.tournament }
                def p2Tournaments = p2.results.findAll { it.tournament.game == game}.collect { it.tournament }

                Comparison comparison = new Comparison(game: game.value)
                comparison.listingsP1 = p1Tournaments.size()
                comparison.listingsP2 = p2Tournaments.size()
                comparison.listingsDiff = comparison.listingsP1 - comparison.listingsP2
                comparison.listingsResult = comparison.calculate(comparison.listingsP1, comparison.listingsP2)

                def commonTournaments = p1Tournaments.findAll { it.results.any { it.player.name == p2.name } }
                comparison.outrankP1 = commonTournaments.count {
                    def p1Result = it.results.find { it.player == p1 }
                    def p2Result = it.results.find { it.player == p2 }
                    return p1Result.place < p2Result.place
                }
                comparison.outrankP2 = commonTournaments.count {
                    def p1Result = it.results.find { it.player == p1 }
                    def p2Result = it.results.find { it.player == p2 }
                    return p2Result.place < p1Result.place
                }
                comparison.outrankDiff = comparison.outrankP1 - comparison.outrankP2
                comparison.outrankResult = comparison.calculate(comparison.outrankP1, comparison.outrankP2)

                def gameresults = head2headTable[game]
                if (!gameresults) {
                    gameresults = [p1: 0, p2: 0]
                }
                comparison.head2headP1 = gameresults.p1
                comparison.head2headP2 = gameresults.p2
                comparison.head2headDiff = comparison.head2headP1 - comparison.head2headP2
                comparison.head2headResult = comparison.calculate(comparison.head2headP1, comparison.head2headP2)

                comparison.scoreP1 = p1Rank.score
                comparison.scoreP2 = p2Rank.score
                comparison.scoreDiff = comparison.scoreP1 - comparison.scoreP2
                comparison.scoreResult = comparison.calculate(comparison.scoreP1, comparison.scoreP2)

                comparison.totalscoreP1 = p1Rank.totalScore
                comparison.totalscoreP2 = p2Rank.totalScore
                comparison.totalscoreDiff = comparison.totalscoreP1 - comparison.totalscoreP2
                comparison.totalscoreResult = comparison.calculate(comparison.totalscoreP1, comparison.totalscoreP2)

                comparison.trendingscoreP1 = p1Rank.trendingScore
                comparison.trendingscoreP2 = p2Rank.trendingScore
                comparison.trendingscoreDiff = comparison.trendingscoreP1 - comparison.trendingscoreP2
                comparison.trendingscoreResult = comparison.calculate(comparison.trendingscoreP1, comparison.trendingscoreP2)

                comparison.rankP1 = p1Rank.rank
                comparison.rankP2 = p2Rank.rank
                comparison.rankDiff = comparison.rankP2 - comparison.rankP1
                comparison.rankResult = comparison.calculate(comparison.rankP2, comparison.rankP1)

                comparison.tournamentWinsP1 = p1Tournaments
                        .findAll { it.tournamentType != TournamentType.LOCAL  && it.finished }
                        .count {
                            it.results
                            .sort { a,b -> a.place <=> b.place }
                            .first().player == p1
                        }
                comparison.tournamentWinsP2 = p2Tournaments
                        .findAll { it.tournamentType != TournamentType.LOCAL && it.finished }
                        .count {
                                    it.results
                                    .sort { a,b -> a.place <=> b.place }
                                    .first().player == p2
                        }
                comparison.tournamentWinsDiff = comparison.tournamentWinsP1 - comparison.tournamentWinsP2
                comparison.tournamentWinsResults = comparison.calculate(comparison.tournamentWinsP1, comparison.tournamentWinsP2)

                comparisons << comparison
            }
        }
        def p1Exclusive = p1.rankings.findAll { !(it.game in p2.rankings.game) }.collect { it.game }
        def p2Exclusive = p2.rankings.findAll { !(it.game in p1.rankings.game) }.collect { it.game }

        [p1: p1, p2: p2, games: comparisons, p1Exclusive: p1Exclusive, p2Exclusive: p2Exclusive]
    }


    class Comparison {
        enum ComparisonResult { WIN, LOSE, DRAW }

        private ComparisonResult calculate(Integer p1, Integer p2) {
            if (p1 > p2) return ComparisonResult.WIN
            else  {
                if (p1 < p2) return ComparisonResult.LOSE
                else return ComparisonResult.DRAW
            }
        }

        public String css(ComparisonResult result) {
            switch (result) {
                case ComparisonResult.WIN: return "success"
                case ComparisonResult.LOSE: return "danger"
                case ComparisonResult.DRAW: return "warning"
                default: return ""
            }
        }

        String game

        Integer listingsP1
        Integer listingsP2
        Integer listingsDiff
        ComparisonResult listingsResult

        Integer outrankP1
        Integer outrankP2
        Integer outrankDiff
        ComparisonResult outrankResult

        Integer head2headP1
        Integer head2headP2
        Integer head2headDiff
        ComparisonResult head2headResult

        Integer rankP1
        Integer rankP2
        Integer rankDiff
        ComparisonResult rankResult

        Integer scoreP1
        Integer scoreP2
        Integer scoreDiff
        ComparisonResult scoreResult

        Integer totalscoreP1
        Integer totalscoreP2
        Integer totalscoreDiff
        ComparisonResult totalscoreResult

        Integer trendingscoreP1
        Integer trendingscoreP2
        Integer trendingscoreDiff
        ComparisonResult trendingscoreResult

        Integer tournamentWinsP1
        Integer tournamentWinsP2
        Integer tournamentWinsDiff
        ComparisonResult tournamentWinsResults

    }

}
