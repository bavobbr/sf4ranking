package be.bbr.overview

import be.bbr.sf4ranking.CharacterStats
import be.bbr.sf4ranking.CharacterType
import be.bbr.sf4ranking.GameCharacter
import be.bbr.sf4ranking.Result
import be.bbr.sf4ranking.ScoringSystem
import be.bbr.sf4ranking.Version

/**
 * Do some datamining
 */
class StatsController
{

    def index() {
        Version game = Version.fromString(params.game)
        log.info "got stats request for game $game"
        if (!game) game = Version.AE2012
        def cstats = CharacterStats.findAllByGame(game)
        log.info "returning ${cstats.size()} char stats"
        return [results: cstats]
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
            CharacterStats cstats = new CharacterStats(characterType: it.key, timesUsed: it.value, game: game)
            statsmap[it.key] = cstats
            cstats.usagePercentage = (it.value / ae.size()) * 100
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
        redirect(controller:"stats", action: "index", params:[game:game])
    }
}
