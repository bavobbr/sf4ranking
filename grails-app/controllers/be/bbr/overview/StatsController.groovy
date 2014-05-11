package be.bbr.overview

import be.bbr.sf4ranking.CharacterStats
import be.bbr.sf4ranking.CharacterType
import be.bbr.sf4ranking.GameCharacter
import be.bbr.sf4ranking.QueryService
import be.bbr.sf4ranking.Result
import be.bbr.sf4ranking.ScoringSystem
import be.bbr.sf4ranking.Version

/**
 * Do some datamining
 */
class StatsController
{

    QueryService queryService

    def index() {
        Version game = Version.fromString(params.game)
        log.info "got stats request for game $game"
        if (!game) game = Version.AE2012
        def cstats = CharacterStats.findAllByGame(game)
        log.info "returning ${cstats.size()} char stats"
        cstats.removeAll { it.characterType == CharacterType.UNKNOWN }
        return [results: cstats, game:game]
    }

    def analyze() {
        Version game = Version.fromString(params.game)
        def old = CharacterStats.findAllByGame(game)
        old*.delete()
        log.info "Listing all gamechars"
        def chars = GameCharacter.list()
        log.info "Grouping by game"
        def byTournamentVersion =  chars.groupBy { it.gameTeam.result.tournament.game }
        def ae = byTournamentVersion[game]
        log.info "Counting by char type"
        def byCharacterType = ae.countBy { it.characterType }
        Map<CharacterType, CharacterStats> statsmap = [:]
        log.info "Creating char stats objects"
        byCharacterType.each {
            CharacterStats cstats = new CharacterStats(characterType: it.key, totalTimesUsed: it.value, game: game)
            statsmap[it.key] = cstats
            cstats.totalUsagePercentage = (it.value / ae.size()) * 100
            log.info "Saving char stat ${cstats.game} ${cstats.characterType}"
            cstats.save()
        }
        log.info "Calculating scores"
        ae.each { GameCharacter gc ->
            CharacterStats stats = statsmap[gc.characterType]
            Result r = gc.gameTeam.result
            def score = ScoringSystem.getScore(r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
            stats.scoreAccumulated+=score
            stats.rankAccumulated+=33-r.place
        }
        log.info "Returning to view after calculating for ${ae.size()} stats"
        log.info "Checking top 100 usage"
        def byType = mainUsagetop100(game)
        byType.each { def k, v ->
            CharacterStats stats = statsmap[k]
            stats?.asMainInTop100 = v
        }
        log.info "Checking top 50 usage"
        byType = mainUsagetop50(game)
        byType.each { def k, v ->
            CharacterStats stats = statsmap[k]
            stats?.asMainInTop50 = v
        }
        log.info "Checking all main usage"
        byType = mainUsage(game)
        byType.each { def k, v ->
            CharacterStats stats = statsmap[k]
            stats?.asMain = v
        }
        log.info "Finding best players"
        Map charToPlayer = findBestPlayers(game)
        charToPlayer.each { k, v ->
            CharacterStats stats = statsmap[k]
            log.info "Assigning $v as best player for $k"
            stats?.player = v
        }
        statsmap.values()*.save(failOnError: true)
        redirect(controller:"stats", action: "index", params:[game:game])
    }

    private def mainUsagetop100(Version game) {
        def top100 = queryService.findPlayers(null, null, 100, 0, game)
        List<CharacterType> mains = top100.collect { it.findRanking(game).mainCharacters }.flatten()
        def byType = mains.countBy { it }
        log.info "Top100 details are ${byType}"
        return byType
    }

    private def mainUsagetop50(Version game) {
        def top100 = queryService.findPlayers(null, null, 50, 0, game)
        List<CharacterType> mains = top100.collect { it.findRanking(game).mainCharacters }.flatten()
        def byType = mains.countBy { it }
        log.info "Top50 details are ${byType}"
        return byType
    }

    private def mainUsage(Version game) {
        def all = queryService.findPlayers(null, null, 10000, 0, game)
        List<CharacterType> mains = all.collect { it.findRanking(game).mainCharacters }.flatten()
        def byType = mains.countBy { it }
        log.info "Top details are ${byType}"
        return byType
    }

    private def findBestPlayers(Version game) {
        Map charToPlayer = [:]
        CharacterType.values().findAll { it.game == game }.each { CharacterType ctype ->
            def best = queryService.findPlayers(ctype, null, 100, 0, game)
            def bestplayer = best? best.find { ctype in it.main(game) } : null
            charToPlayer[ctype] = bestplayer
        }
        return charToPlayer
    }
}
