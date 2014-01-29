package be.bbr.overview

import be.bbr.sf4ranking.*
import grails.converters.JSON

class RankingsController
{

    RankingService rankingService

    def index()
    {
        if (!params.offset) params.offset = 0
        if (!params.max) params.max = 30
        boolean filtered = (params.country && params.country != "any")? true : false
        def query = Player.where {
            if (params.country && params.country != "any") {
                countryCode == params.country as CountryCode
            }
        }
        List players = query.list(order: "desc", sort: 'score', offset:params.offset, max:params.max)
        def c = Player.createCriteria()
        def countries = c.list {
            projections {
                distinct "countryCode"
            }
        }
        def countrynames = countries.findResults() { it?.name() }
        countrynames.add(0, "any")
        [players: players, countries: countrynames, filtered: filtered, total: query.count()]
    }

    def player(Player player)
    {
        def rankings = []
        Set chars = [] as Set
        Result.findAllByPlayer(player).sort {a, b -> b.tournament.date<=>a.tournament.date}.each {
            def tid = it.tournament.id
            def tname = it.tournament.name
            def ttype = it.tournament.tournamentType.value
            def tchar = it.pcharacter.name().toLowerCase()
            def tdate = it.tournament.date?.format("MM-yyyy")
            def tscore = rankingService.getScore(it.place, it.tournament.tournamentType)
            def tplace = it.place
            def tvideos = it.tournament.videos
            rankings << [tid: tid, tname: tname, ttype: ttype, tscore: tscore, tplace: tplace, tchar: tchar, tdate: tdate, tvideos: tvideos]
            chars << it.pcharacter
        }
        log.info "Rendering player ${player}"
        [player: player, results: rankings, chars: chars]
    }

    def tournaments()
    {
        def query = Tournament.where {
            if (params.country && params.country != "any") countryCode == params.country as CountryCode
            if (params.version && params.version != "any") game == params.version as Version
            if (params.type && params.type != "any") tournamentType == params.type as TournamentType
        }
        List tournaments = query.list(order: "desc", sort: 'weight')
        def c = Tournament.createCriteria()
        def countries = c.list {
            projections {
                distinct "countryCode"
            }
        }
        countries = countries.collect { it.name() }
        countries.add(0, "any")
        def versions = Version.values().collect { it.name() }
        versions.add(0, "any")
        def types = TournamentType.values().collect { it.name() }
        types.add(0, "any")
        [tournaments: tournaments, countries: countries, versions: versions, types: types]
    }

    def tournament(Tournament tournament)
    {
        def details = []
        tournament.results.sort {a, b -> a.place<=>b.place}.each {
            def rplayer = it.player.name
            def rplayerid = it.player.id
            def rplace = it.place
            def rchar = it.pcharacter.value
            def rscore = rankingService.getScore(it.place, tournament.tournamentType)
            def rcountry = it.player.countryCode?.name()?.toLowerCase()
            details << [rplayer: rplayer, rplace: rplace, rscore: rscore, rplayerid: rplayerid, rchar: rchar, rcountry: rcountry]
            println details
        }
        log.info "Rendering tournament ${tournament}"
        return [tournament: tournament, details: details]
    }

    def autocompletePlayer()
    {
        def players = Player.findAllByCodenameLike("%${params.term.toUpperCase()}%")
        def content = players.collect {[id: it.id, label: it.name, value: it.name]}
        render(content as JSON)
    }

    def autocompleteTournament()
    {
        def tournaments = Tournament.findAllByCodenameLike("%${params.term.toUpperCase()}%")
        def content = tournaments.collect {[id: it.id, label: it.name, value: it.name]}
        render(content as JSON)
    }


}


