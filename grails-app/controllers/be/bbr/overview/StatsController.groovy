package be.bbr.overview

import be.bbr.sf4ranking.*
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
        cstats = cstats.sort { a, b -> b.totalTimesUsed <=> a.totalTimesUsed}
        //def usageSeries = usageSeries(game)
        //log.info "Usage series is ${usageSeries}"
        return [results: cstats, game: game]
    }

    def character() {
        Version game = Version.fromString(params.game)
        CharacterType charType = CharacterType.fromString(params.charname, Version.generalize(game))
        CharacterStats stats = CharacterStats.findByGameAndCharacterType(game, charType)
        log.info "Finding 5 best players for game $game"
        def best = queryService.findPlayers(charType, null, 100, 0, game)
        def bestMainplayers = best ? best.findAll {charType in it.main(game)} : null
        def bestSecondaryplayers = best ? best.findAll { !(charType in it.main(game)) } : null
        def best5m = bestMainplayers.take(5)
        def best5s = bestSecondaryplayers.take(5)
        def others = CharacterStats.findAllByGame(game)
        others.removeAll { it.characterType == CharacterType.UNKNOWN }
        def statnames = ["totalTimesUsed", "scoreAccumulated", "rankAccumulated", "totalUsagePercentage", "asMainInTop100", "asMainInTop50",
                         "asMain", "asSecondary", "decayedScoreAccumulated", "decayedScoreAccumulatedByTop100", "scoreAccumulatedByTop100",
                         "top1finishes", "top3finishes", "top8finishes", "top16finishes"]
        def relativeStats = [:]
        statnames.each { String stat ->
            def index = others.sort { a, b -> b."$stat" <=> a."$stat" }.findIndexOf { it.characterType == charType } + 1
            relativeStats[stat] = index
        }
        return [stats:stats, best5:best5m, best5secondaries: best5s, relativeStats:relativeStats, total: others.size()]
    }

    def analyze()
    {
        if (!SecurityUtils.subject.hasRole("Administrator")) {
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
        statsmap.values()*.save(failOnError: true)
        redirect(controller: "stats", action: "index", params: [game: game])
    }

    private List usageSeries(Version game) {
        def count = CharacterType.forGame(game).size()
        def top300 = queryService.findPlayers(null, null, 300, 0, game)
        List series = []
        Set usedChars = []
        top300.takeWhile { Player p ->
            usedChars << p.main(game)
            series << usedChars.size()
            return usedChars.size() < count
        }
        return series
    }

    private def listCharacters(Version game) {
        log.info "Listing all gamechars"
        def chars = GameCharacter.list()
        log.info "Grouping by game $game"
        def byTournamentVersion = chars.groupBy {it.gameTeam.result.tournament.game}
        return byTournamentVersion[game]
    }

    private void deleteOld(Version game) {
        def old = CharacterStats.findAllByGame(game)
        old*.delete()
    }

    private void calculateScores(List<CharacterStats> characters, Map statsmap)
    {
        log.info "Calculating scores"
        characters.each { GameCharacter gc ->
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
        characters.each { GameCharacter gc ->
            Result r = gc.gameTeam.result
            if (r.place == 1) {
                charhitstop1.addHit(gc.characterType)
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
        charhitstop1.each { k, v ->
            CharacterStats stats = statsmap[k]
            stats?.top1finishes = v
        }
        charhitstop3.each { k, v ->
            CharacterStats stats = statsmap[k]
            stats?.top3finishes = v
        }
        charhitstop8.each { k, v ->
            CharacterStats stats = statsmap[k]
            stats?.top8finishes = v
        }
        charhitstop16.each { k, v ->
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
            def score = ScoringSystem.getDecayedScore(r.tournament.date, r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
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
        top100.each { Player p ->
            p.results.findAll{ it.tournament.game == game }.each { Result r ->
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

    private void decayedScoreByTop100(Version game, Map statsmap)
    {
        log.info "Checking top 100 decayed scores"
        def top100 = queryService.findPlayers(null, null, 100, 0, game)
        top100.each { Player p ->
            p.results.findAll{ it.tournament.game == game }.each { Result r ->
                def score = ScoringSystem.getDecayedScore(r.tournament.date, r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
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
            Set<CharacterType> allUsed = it.results.findAll { it.tournament.game == game }.collect { it.characterTeams.collect { it.pchars.characterType }.flatten() }.flatten()
            Set<CharacterType> secondaries = allUsed.minus(mains)
            secondaries.each { charhits.addHit(it) }
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
