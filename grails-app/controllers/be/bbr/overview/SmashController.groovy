package be.bbr.overview

import be.bbr.sf4ranking.SmashService
import be.bbr.sf4ranking.Version
import be.bbr.sf4ranking.smash.SmashAttendee
import grails.converters.JSON
import grails.converters.XML

class SmashController {

    SmashService smashService

    def index() {}

    def analyze() {
        Version game = Version.fromString(params.game)?: Version.SF5
        String tournamentParam = params.get("tournament")
        String eventParam = params.get("event")
        String mappings = params.get("mappings")

        def smashTournament = smashService.analyze(game, eventParam, tournamentParam, mappings)
        if (!smashTournament) {
            log.warn("No tournament data found for $tournamentParam")
            flash.message = "Could not get tournament data of $tournamentParam"
            def topplayers = []
            withFormat {
                html(tournament: null, game: game)
                json { render topplayers as JSON }
                xml { render topplayers as XML }
            }
        }
        else {

            def topplayers = smashTournament.seeding.players.withIndex().collect { p, idx ->
                [name         : p.name,
                 fullname     : p.realname,
                 weight       : p.skill(game),
                 country      : p.countryCode?.name()?.toLowerCase(),
                 rank         : p.rank(game),
                 id           : p.id,
                 score        : p.score(game),
                 alltimescore : p.totalScore(game),
                 trendingscore: p.trendingScore(game),
                 cptRank      : p.cptGlobal()?.rank,
                 seed         : idx + 1
                ]
            }
            withFormat {
                html(tournament: smashTournament, game: game)
                json { render topplayers as JSON }
                xml { render topplayers as XML }
            }


            Map<String, List<SmashAttendee>> groupByEvent = [:]
            def attendees = smashTournament.attendees

            def groupByCountry = attendees.groupBy { it.country }
            def sortByCountry = attendees.countBy { it.country }.sort { a, b -> b.value <=> a.value }


            println "[PLAYERS PER COUNTRY]"
            groupByCountry.sort { a, b -> b.value.size() <=> a.value.size() }.each {
                println "$it.key: ${it.value.collect { it.gamertag ?: it.name }.join(", ")}"
            }

            attendees.each { attendee ->
                attendee.events.each { event ->
                    if (!(event.name =~ /Ladder/)) {
                        if (!groupByEvent.containsKey(event.name)) groupByEvent[event.name] = []
                        groupByEvent[event.name] << attendee
                    }
                }
            }

            [tournament    : smashTournament, game: game, numPlayers: attendees.size(),
             numRegistrations: attendees.sum { it.events.size() }, numGames: groupByEvent.size(),
             countByCountry: sortByCountry, groupByCountry: groupByCountry, seeds: smashTournament.seeding.players]
        }
    }

}
