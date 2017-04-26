package be.bbr.overview

import be.bbr.sf4ranking.DataService
import be.bbr.sf4ranking.Player
import be.bbr.sf4ranking.Query
import be.bbr.sf4ranking.QueryService
import be.bbr.sf4ranking.Result
import be.bbr.sf4ranking.ScoringSystem
import be.bbr.sf4ranking.Tournament
import be.bbr.sf4ranking.Version
import grails.converters.JSON
import grails.converters.XML
import grails.plugin.cache.Cacheable

/**
 */
class ApiController {

    DataService dataService
    QueryService queryService


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
            Query logQuery = new Query(date: new Date(), name: params.toQueryString(), source: request.getRemoteAddr())
            logQuery.save(failOnError: false)
            log.info "Processing search for type $type with query $query"
            if (type.equalsIgnoreCase("player")) {
                def results = []
                if (!fuzzy) {
                    results = dataService.findMatches(query)
                }
                else {
                    log.info "Processing fuzzy query $query"
                    def players = dataService.findMatches(query)
                    def alikes = dataService.findAlike(query, 10)
                    results = players+alikes
                    results = results.sort {a, b -> Result.countByPlayer(b) <=> Result.countByPlayer(a)}

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
        Query logQuery = new Query(date: new Date(), name: params.toQueryString(), source: request.getRemoteAddr())
        logQuery.save(failOnError: false)
        def id = params.int("name")
        def player = Player.get(id)
        render (playerToMap(player) as JSON)
    }

    def playerByName() {
        Query logQuery = new Query(date: new Date(), name: params.toQueryString(), source: request.getRemoteAddr())
        logQuery.save(failOnError: false)
        String id = params.name
        def player = Player.findByCodename(id.toUpperCase())
        render (playerToMap(player) as JSON)
    }

    def tournamentById() {
        Query logQuery = new Query(date: new Date(), name: params.toQueryString(), source: request.getRemoteAddr())
        logQuery.save(failOnError: false)
        def id = params.int("name")
        def tournament = Tournament.get(id)
        render (tournamentToMap(tournament, true) as JSON)
    }

    def tournamentByName() {
        Query logQuery = new Query(date: new Date(), name: params.toQueryString(), source: request.getRemoteAddr())
        logQuery.save(failOnError: false)
        String id = params.name
        def tournament = Tournament.findByCodename(id.toUpperCase())
        render (tournamentToMap(tournament, true) as JSON)
    }

    def tournamentByGame() {
        Query logQuery = new Query(date: new Date(), name: params.toQueryString(), source: request.getRemoteAddr())
        logQuery.save(failOnError: false)
        String id = params.game
        Version game = Version.fromString(id)
        if (!game) render "invalid game: $id"
        else {
            def tournaments = Tournament.findAllByGame(id.toUpperCase()).sort { it.weight }.reverse()
            def tourneys = tournaments.collect { tournamentToMap(it, false) }
            render(tourneys as JSON)
        }
    }

    @Cacheable('top')
    def top() {
        println "Rendering top with params $params"
        Version game = Version.fromString(params.game)?: Version.SF5
        Integer size = params.getInt("size", 10) > 100? 100 : params.getInt("size", 10)
        Integer offset = params.getInt("offset", 0)
        boolean isCpt = params.getBoolean("cpt", false)
        def players = []
        if (!isCpt) {
            players = queryService.findPlayers(null, null, size, offset, game, false)
        }
        else {
            players = queryService.findCptPlayers().take(size)
        }
        def topplayers = players.collect { p ->
            [name: p.name,
             fullname: p.realname,
             country: p.countryCode?.name()?.toLowerCase(),
             rank: p.rank(game),
             id: p.id,
             score: p.score(game),
             totalscore: p.totalScore(game),
             character: p.main(game)?.collect { it.name() }
            ]
        }
        withFormat {
            html(players: topplayers, game: game)
            json { render topplayers as JSON }
            xml { render topplayers as XML }
        }
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
                         game          : it.tournament.game.name(),
                         place         : it.place,
                         score         : ScoringSystem.getScore(it.place, it.tournament.tournamentType),
                         date          : it.tournament.date,
                         type          : it.tournament.tournamentType.name(),
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

    private Map tournamentToMap(Tournament tournament, boolean results) {
        if (!tournament) return [:]
        else {
            def tournamentMap = [
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
                    weight    : tournament.weight,
            ]
            if (results) {
                tournamentMap["results"] = tournament.results.collect {
                    [player     : it.player.id,
                     playername : it.player.name,
                     place      : it.place,
                     score      : ScoringSystem.getScore(it.place, it.tournament.tournamentType),
                     cptScore   : it.tournament.cptTournament?.getScore(it.place)?: 0,
                     rank       : it.player.rank(it.tournament.game),
                     characters : it.characterTeams.collect {
                         it.pchars.collect {
                             it.characterType.name()
                         }
                     }
                    ]
                }
            }
            return tournamentMap
        }
    }
}
