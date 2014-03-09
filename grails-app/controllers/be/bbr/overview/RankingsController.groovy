package be.bbr.overview

import be.bbr.sf4ranking.*
import grails.converters.JSON

/**
 * The controller that is public to users and shows the stats of Player, Tournament as well as overall
 */
class RankingsController
{

    QueryService queryService

    /**
     * The index page is also the page with all the rankings
     * We need to find out which paghe it is on and which filters apply before doing a query
     * At the end we also fill the filter boxes with data relevant for that type of query
     * @return
     */
    def index()
    {
        def poffset = params.offset?.toInteger() ?: 0
        def pmax = params.max?.toInteger() ?: 50
        def pcountry = (!params.country || params.country =~ "any") ? null : CountryCode.fromString(params.country as String)
        def pchar = (!params.pchar || params.pchar =~ "any") ? null : CharacterType.fromString(params.pchar as String)
        def filtered = pchar || pcountry

        def players = queryService.findPlayers(pchar, pcountry, pmax, poffset, Version.AE2012)
        def playercount = queryService.countPlayers(pchar, pcountry, Version.AE2012)
        log.info "getAll gave ${players.size()} players out of ${playercount}"

        def countrynames = queryService.getActiveCountryNames()
        // list all characters for the filter box
        def charnames = CharacterType.values().collect {it.name()}
        // add a search all for each type
        countrynames.add(0, "any country")
        charnames.add(0, "any character")
        def lastUpdateMessage = Configuration.first().lastUpdateMessage
        [players: players, countries: countrynames, charnames: charnames, filtered: filtered,
                total: playercount, poffset: poffset, fchar: pchar, fcountry: pcountry, updateMessage: lastUpdateMessage]
    }

    /**
     * Look up a player and prepare data for the view
     */
    def player(Player player)
    {
        def rankings = []
        def old = []
        Set chars = [] as Set
        Result.findAllByPlayer(player).sort {a, b -> b.tournament.date <=> a.tournament.date}.each {
            def tid = it.tournament.id
            def tname = it.tournament.name
            def ttype = it.tournament.tournamentType?.value
            def tchars = it.pchars.sort { a, b -> a.main <=> b.main }.collect { it.characterType }
            def tdate = it.tournament.date?.format("yyyy-MM-dd")
            def tscore = it.tournament.tournamentType ? ScoringSystem.getScore(it.place, it.tournament.tournamentType, it.tournament.tournamentFormat) : -1
            def tplace = it.place
            if (it.tournament.tournamentFormat == TournamentFormat.EXHIBITION) {
                tplace = it.place == 1? "Win" : "Lose"
            }
            def tvideos = it.tournament.videos
            def data = [tid: tid, tname: tname, ttype: ttype, tscore: tscore, tplace: tplace, tchars: tchars, tdate: tdate, tvideos: tvideos, resultid: it.id]
            if (it.tournament.ranked)
            {
                rankings << data
            }
            else
            {
                old << data
            }
            chars.addAll(it.pchars*.characterType)
        }
        log.info "Rendering player ${player}"
        render view: "player", model: [player: player, results: rankings, oldresults: old, chars: chars]
    }

    def playerByName()
    {
        Player p = Player.findByCodename(params.name.toUpperCase())
        return player(p)
    }

    /**
     * Look up all tournament and fill relevant data for the filters
     */
    def tournaments()
    {
        def query = Tournament.where {
            if (params.country && !(params.country =~ "any")) countryCode == CountryCode.fromString(params.country)
            if (params.version && !(params.version =~ "any")) game == params.version as Version
            if (params.type && !(params.type =~ "any")) tournamentType == params.type as TournamentType
        }
        List tournaments = query.list(order: "desc", sort: 'weight')
        def c = Tournament.createCriteria()
        def countries = c.list {
            projections {
                distinct "countryCode"
            }
        }
        countries = countries.collect {it.name()}
        countries.add(0, "any country")
        def versions = Version.values().collect {it.name()}
        versions.add(0, "any version")
        def types = TournamentType.values().collect {it.name()}
        types.add(0, "any type")
        [tournaments: tournaments, countries: countries, versions: versions, types: types]
    }

    /**
     * Look up a Tournament and prepare data for the view
     */
    def tournament(Tournament tournament)
    {
        def details = []
        tournament.results.sort {a, b -> a.place <=> b.place}.each {
            def rplayer = it.player.name
            def rplayerid = it.player.id
            def rplace = it.place
            if (tournament.tournamentFormat == TournamentFormat.EXHIBITION) {
                rplace = it.place == 1? "Win" : "Lose"
            }
            def rchars = it.pchars.collect { it.characterType }
            def rscore = tournament.tournamentType ?
                         ScoringSystem.getScore(it.place, tournament.tournamentType, it.tournament.tournamentFormat) : -1
            def rcountry = it.player.countryCode?.name()?.toLowerCase()
            def rcountryname = it.player.countryCode?.name
            details <<
            [rplayer: rplayer, rplace: rplace, rscore: rscore, rplayerid: rplayerid, rchars: rchars, rcountry: rcountry, rcountryname: rcountryname, resultid: it.id]
        }
        render view: 'tournament', model: [tournament: tournament, details: details]
    }

    def tournamentByName()
    {
        Tournament t = Tournament.findByCodename(params.name.toUpperCase())
        return tournament(t)
    }

    /**
     * Look up all Teams
     */
    def teams()
    {
        List teams = Team.list(order: "desc", sort: 'name')
        teams.each {team ->
            def players = Player.where {teams {id == team.id}}.list()
            // the score is the sum of all players and all games they play in
            def score = players.sum {it.overallScore()}
            team.metaClass.getTeamScore << {score}
            team.metaClass.getTeamSize << {players.size()}
        }
        [teams: teams]
    }

    /**
     * Look up a Tournament and prepare data for the view
     */
    def team(Team team)
    {
        def players = Player.where {teams {id == team.id}}.list()
        log.info "found ${players.size()}"
        render view: 'team', model: [team: team, players: players]
    }

    def teamByName()
    {
        Team t = Team.findByCodename(params.name.toUpperCase())
        return team(t)
    }

    /**
     * Endpoint for the AJAX search on players
     */
    def autocompletePlayer()
    {
        def players = Player.findAllByCodenameLike("%${params.term.toUpperCase()}%")
        def content = players.collect {[id: it.id, label: it.name, value: it.name]}
        render(content as JSON)
    }

    /**
     * Endpoint for the AJAX search on tournaments
     */
    def autocompleteTournament()
    {
        def tournaments = Tournament.findAllByCodenameLike("%${params.term.toUpperCase()}%")
        def content = tournaments.collect {[id: it.id, label: it.name, value: it.name]}
        render(content as JSON)
    }

}


