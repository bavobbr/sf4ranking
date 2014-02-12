package be.bbr.sf4ranking

import grails.transaction.Transactional
import groovy.json.JsonSlurper

/**
 * This is mainly used to upgrade old data
 */
@Transactional
class CleanupService
{

    /**
     * Assumes that almost all tournaments are double-bracket except for some known tournaments
     * Should not be needed if tournaments are filled in correctly with format
     */
    def fixTournamentFormats() {
        Tournament.list().each {
            it.tournamentFormat = TournamentFormat.DOUBLE_BRACKET
            it.save()
            log.info "Setting $it.name as double"
        }
        Tournament.findAllByCodenameLike("%TOPANGA%").each {
            it.tournamentFormat = TournamentFormat.LEAGUE
            it.save()
            log.info "Setting $it.name as league"
        }
        Tournament.findAllByCodenameLike("%CAPCOM CUP TGS%").each {
            it.tournamentFormat = TournamentFormat.SINGLE_BRACKET
            it.save()
            log.info "Setting $it.name as single"
        }
    }

    /**
     * Fixes rank in tournaments for players on equal spots
     * Should not be needed if tournaments are entered with correct format
     */
    def fixPlayerRankings() {
        Tournament.list().each { Tournament t ->
            t.results.each { Result r ->
                r.place = ScoringSystem.getRank(r.place, t.tournamentFormat)
                r.save()
            }
            log.info "Fixed ranks of tournament $t"
            t.save()
        }
    }

    /**
     * Drops ghost users that are not ranked anywhere
     */
    def dropUnrankedPlayers()
    {
        def players = Player.withCriteria { isEmpty("results") }
        players.each { log.info "dropping player $it" }
        return players.size()
    }
}
