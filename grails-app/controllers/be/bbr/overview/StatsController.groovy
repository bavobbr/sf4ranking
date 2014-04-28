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
        log.info "Listing all gamechars"
        def chars = GameCharacter.list()
        log.info "Grouping by game"
        def byTournamentVersion =  chars.groupBy { it.gameTeam.result.tournament.game }
        def ae = byTournamentVersion[Version.AE2012]
        log.info "Counting by char type"
        def byCharacterType = ae.countBy { it.characterType }
        Map<CharacterType, CharacterStats> statsmap = [:]
        byCharacterType.each {
            CharacterStats cstats = new CharacterStats(characterType: it.key, timesUsed: it.value)
            statsmap[it.key] = cstats
            cstats.usagePercentage = (it.value / ae.size()) * 100
        }
        ae.each { GameCharacter gc ->
            CharacterStats stats = statsmap[gc.characterType]
            Result r = gc.gameTeam.result
            def score = ScoringSystem.getScore(r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
            stats.scoreAccumulated+=score
            stats.rankAccumulated+=33-r.place
        }
        return [results: statsmap.values()]

    }
}
