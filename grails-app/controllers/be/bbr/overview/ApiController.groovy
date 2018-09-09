package be.bbr.overview

import be.bbr.sf4ranking.DataService
import be.bbr.sf4ranking.Player
import be.bbr.sf4ranking.Query
import be.bbr.sf4ranking.QueryService
import be.bbr.sf4ranking.RankingType
import be.bbr.sf4ranking.Region
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
        def id = params.int("name")
        log.info "API looking for player id $id"
        def player = Player.get(id)
        render (playerToMap(player) as JSON)
    }

    def playerByName() {
        String id = params.name
        log.info "API looking for player name id $id"
        def player = Player.findByCodename(id.toUpperCase())
        render (playerToMap(player) as JSON)
    }

    def playerBySmashId() {
        String id = params.smashId
        log.info "API looking for player smash id $id"
        def player = Player.findBySmashId(id)
        render (playerToMap(player) as JSON)
    }

    def tournamentById() {
        def id = params.int("name")
        log.info "API looking for tournament id $id"
        def tournament = Tournament.get(id)
        render (tournamentToMap(tournament, true) as JSON)
    }

    def tournamentByName() {
        String id = params.name
        log.info "API looking for tournament name $id"
        def tournament = Tournament.findByCodename(id.toUpperCase())
        render (tournamentToMap(tournament, true) as JSON)
    }

    def tournamentByGame() {
        String id = params.game
        log.info "API looking for tournament game $id"
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
            players = queryService.findPlayers(null, null, size, offset, game, RankingType.ACTUAL)
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
             twitter: p.twitter,
             smashId: p.smashId,
             maxoplataId: p.maxoplataId,
             onlineId: p.onlineId,
             totalscore: p.totalScore(game),
             trendingscore: p.trendingScore(game),
             cptScore: p.cptScore(),
             cptScorePrev: p.cptGlobal()?.prevScore,
             cptRank: p.cptGlobal()?.rank,
             cptRankPrev: p.cptGlobal()?.prevRank,
             cptNaScore: p.cptScore(Region.NA),
             cptNaRank: p.findCptRanking(Region.NA)?.rank,
             cptLaScore: p.cptScore(Region.LA),
             cptLaRank: p.findCptRanking(Region.LA)?.rank,
             cptAoScore: p.cptScore(Region.AO),
             cptAoRank: p.findCptRanking(Region.AO)?.rank,
             cptEuScore: p.cptScore(Region.EU),
             cptEuRank: p.findCptRanking(Region.EU)?.rank,
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
                    smashId : player.smashId,
                    maxoplataId: player.maxoplataId,
                    onlineId: player.onlineId,
                    alias   : player.alias,
                    mainGame: player.mainGame?.name(),
                    teams   : player.teams.collect { it.name },
                    cptScore: player.cptScore(),
                    cptRank : player.cptGlobal()?.rank,
                    cptNaScore: player.cptScore(Region.NA),
                    cptNaRank: player.findCptRanking(Region.NA)?.rank,
                    cptLaScore: player.cptScore(Region.LA),
                    cptLaRank: player.findCptRanking(Region.LA)?.rank,
                    cptAoScore: player.cptScore(Region.AO),
                    cptAoRank: player.findCptRanking(Region.AO)?.rank,
                    cptEuScore: player.cptScore(Region.EU),
                    cptEuRank: player.findCptRanking(Region.EU)?.rank,
                    rankings: player.rankings.collectEntries {
                        [it.game?.name(),
                         [
                                 rank         : it.rank,
                                 trendingRank : it.trendingRank,
                                 alltimeRank  : it.totalRank,
                                 weight       : it.skill,
                                 score        : it.score,
                                 totalscore   : it.totalScore,
                                 trendingscore: it.trendingScore,
                                 main         : it.mainCharacters.collect { it.name() }
                         ]
                        ]
                    },
                    results : player.results.collect {
                        [tournament    : it.tournament.id,
                         tournamentname: it.tournament.name,
                         game          : it.tournament.game.name(),
                         place         : it.place,
                         score         : ScoringSystem.getScore(it.place, it.tournament.tournamentType),
                         legacyScore   : ScoringSystem.getLegacyScore(it.place, it.tournament.weight, it.tournament.tournamentFormat),
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
                    region    : tournament.region?.name(),
                    coverage  : tournament.coverage,
                    game      : tournament.game?.name(),
                    cpt       : tournament.cptTournament?.name(),
                    finished  : tournament.finished,
                    weighting : tournament.weightingType?.name(),
                    classifier: tournament.tournamentType?.name(),
                    bracket   : tournament.tournamentFormat?.name(),
                    weight    : tournament.weight,
                    event     : tournament.event?.name,
                    creator   : tournament.creator,
            ]
            if (results) {
                tournamentMap["results"] = tournament.results.collect {
                    [player     : it.player.id,
                     playername : it.player.name,
                     place      : it.place,
                     score      : ScoringSystem.getScore(it.place, it.tournament.tournamentType),
                     legacyScore: ScoringSystem.getLegacyScore(it.place, it.tournament.weight, it.tournament.tournamentFormat),
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
