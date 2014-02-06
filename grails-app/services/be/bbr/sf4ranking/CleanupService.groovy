package be.bbr.sf4ranking

import grails.transaction.Transactional
import groovy.json.JsonSlurper

@Transactional
class CleanupService
{
    RankingService rankingService

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

    def fixPlayerRankings() {
        Tournament.list().each { Tournament t ->
            t.results.each { Result r ->
                r.place = rankingService.getRank(r.place, t.tournamentFormat)
                r.save()
            }
            log.info "Fixed ranks of tournament $t"
            t.save()
        }
    }


}
