package be.bbr.overview

import be.bbr.sf4ranking.DataService
import be.bbr.sf4ranking.Player
import be.bbr.sf4ranking.Result
import be.bbr.sf4ranking.Tournament
import grails.converters.JSON

/**
 */
class ApiController {

    DataService dataService

    /**
     * Manual data import and manipulation
     */
    def index() {

    }

    def search() {
        String type = params.type
        boolean fuzzy = params.boolean("fuzzy", false)
        if (!type) render("No search type provided")
        String query = params.query?.trim()
        if (!query) render("No query provided")
        if (query.size() >= 2)
        {
            log.info "Processing search for type $type with query $query"
            if (type.equalsIgnoreCase("player")) {
                def results
                if (!fuzzy) {
                    results = dataService.findMatches(query)
                }
                else {
                    log.info "Processing fuzzy query $query"
                    def players = dataService.findMatches(query)
                    def alikes = dataService.findAlikes(query)
                    results = players+alikes
                }
                def content = results.collect {
                    def numResults = Result.countByPlayer(it)
                    [id: it.id, country: it.countryCode?.name, name: it.name, realname: it.realname, twitter: it.twitter, results: numResults]
                }
                render(content as JSON)
            }
            else if (type.equalsIgnoreCase("tournament")) {
                def tournaments = Tournament.findAllByCodenameLike("%${query.toUpperCase()}%")
                def content = tournaments.collect {[id: it.id, label: it.toString(), value: it.name]}
                render(content as JSON)
            }
            else {
                render("Query type '${type}' is not supported. Provide either 'player' or 'tournament")
            }
        }
    }

    def playerById() {
        def id = params.int("name")
        def player = Player.get(id)
        render (playerToMap(player) as JSON)
    }

    def playerByName() {
        String id = params.name
        def player = Player.findByCodename(id.toUpperCase())
        render (playerToMap(player) as JSON)
    }

    def tournamentById() {
        def id = params.int("name")
        def tournament = Tournament.get(id)
        render (tournamentToMap(tournament) as JSON)
    }

    def tournamentByName() {
        String id = params.name
        def tournament = Tournament.findByCodename(id.toUpperCase())
        render (tournamentToMap(tournament) as JSON)
    }

    private Map playerToMap(Player player) {
        if (!player) return [:]
        else {
            return [
                    id      : player.id,
                    name    : player.name,
                    country : player.countryCode?.name(),
                    realname: player.realname,
                    twitter : player.twitter,
                    mainGame: player.mainGame?.name(),
                    teams   : player.teams.collect { it.name },
                    rankings: player.rankings.collectEntries {
                        [it.game?.name(),
                         [
                                 rank      : it.rank,
                                 score     : it.score,
                                 totalscore: it.totalScore,
                                 main      : it.mainCharacters.collect { it.name() }
                         ]
                        ]
                    },
                    results : player.results.collect {
                        [tournament    : it.tournament.id,
                         tournamentname: it.tournament.name,
                         place         : it.place,
                         characters    : it.characterTeams.collect {
                             it.pchars.collect {
                                 it.characterType.name()
                             }
                         }
                        ]
                    }
            ]
        }
    }

    private Map tournamentToMap(Tournament tournament) {
        if (!tournament) return [:]
        else {
            return [
                    id        : tournament.id,
                    name      : tournament.name,
                    date      : tournament.date,
                    country   : tournament.countryCode?.name(),
                    coverage  : tournament.coverage,
                    game      : tournament.game?.name(),
                    cpt       : tournament.cptTournament?.name(),
                    finished  : tournament.finished,
                    weighting : tournament.weightingType.name(),
                    classifier: tournament.tournamentType.name(),
                    bracket   : tournament.tournamentFormat.name(),
                    results   : tournament.results.collect {
                        [player    : it.player.id,
                         playername: it.player.name,
                         place     : it.place,
                         characters: it.characterTeams.collect {
                             it.pchars.collect {
                                 it.characterType.name()
                             }
                         }
                        ]
                    }
            ]
        }
    }
}
