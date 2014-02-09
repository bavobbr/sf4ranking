package be.bbr.overview

import be.bbr.sf4ranking.*
import grails.converters.JSON

class RankingsController
{

    RankingService rankingService

    def index()
    {
        def poffset = params.offset?.toInteger() ?: 0
        def pmax = params.max?.toInteger() ?: 50
        def pcountry = (!params.country || params.country =~ "any") ? null : CountryCode.fromString(params.country as String)
        def pchar = (!params.pchar || params.pchar =~ "any") ? null : CharacterType.fromString(params.pchar as String)
        boolean filtered = pchar || pcountry
        def players
        def playercount
        /**
         * We have to differentiate between character search and not, because Hibernate has trouble paginating on
         * queries that use associations
         * This query queries all and filters in the controller, which is bad but also a rare call
         */
        if (pchar)
        {
            def pquery = Player.where {
                if (pcountry) countryCode == pcountry
                results.pcharacter == pchar
            }
            def allPlayers = pquery.list(order: 'asc', sort: 'rank')
            players = pagedList(allPlayers, poffset, pmax)
            playercount = allPlayers.size()
        }
        /**
         * without associatiosn there is no issue to use real pagination
         */
        else
        {
            def pquery = Player.where {
                if (pcountry) countryCode == pcountry
            }
            players = pquery.list(order: 'asc', sort: 'rank', max: pmax, offset: poffset)
            playercount = players.totalCount
        }
        // list known countries for the filter box
        def countries = Player.createCriteria().list {
            projections {
                distinct "countryCode"
            }
        }
        def countrynames = countries.findResults() {it?.name()}
        // list all characters for the filter box
        def charnames = CharacterType.values().collect {it.name()}
        // add a search all for each type
        countrynames.add(0, "any country")
        charnames.add(0, "any character")
        def lastUpdateMessage = Configuration.first().lastUpdateMessage
        [players: players, countries: countrynames, charnames: charnames, filtered: filtered,
         total: playercount, poffset: poffset, fchar: pchar, fcountry: pcountry, updateMessage: lastUpdateMessage]
    }

    def player(Player player)
    {
        def rankings = []
        Set chars = [] as Set
        Result.findAllByPlayer(player).sort {a, b -> b.tournament.date <=> a.tournament.date}.each {
            def tid = it.tournament.id
            def tname = it.tournament.name
            def ttype = it.tournament.tournamentType?.value
            def tchar = it.pcharacter.name().toLowerCase()
            def tcharname = it.pcharacter?.value
            def tdate = it.tournament.date?.format("yyyy-MM-dd")
            def tscore = it.tournament.tournamentType? ScoringSystem.getScore(it.place, it.tournament.tournamentType) : -1
            def tplace = it.place
            def tvideos = it.tournament.videos
            rankings <<
            [tid: tid, tname: tname, ttype: ttype, tscore: tscore, tplace: tplace, tchar: tchar, tcharname: tcharname, tdate: tdate, tvideos: tvideos]
            chars << it.pcharacter
        }
        log.info "Rendering player ${player}"
        [player: player, results: rankings, chars: chars]
    }

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

    def tournament(Tournament tournament)
    {
        def details = []
        tournament.results.sort {a, b -> a.place <=> b.place}.each {
            def rplayer = it.player.name
            def rplayerid = it.player.id
            def rplace = it.place
            def rchar = it.pcharacter?.name()?.toLowerCase()
            def rcharname = it.pcharacter?.value
            def rscore = tournament.tournamentType ? ScoringSystem.getScore(it.place, tournament.tournamentType) : -1
            def rcountry = it.player.countryCode?.name()?.toLowerCase()
            def rcountryname = it.player.countryCode?.name
            details <<
            [rplayer: rplayer, rplace: rplace, rscore: rscore, rplayerid: rplayerid, rchar: rchar, rcharname: rcharname, rcountry: rcountry, rcountryname: rcountryname]
            println details
        }
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

    /**
     * Safe way to get a sublist
     */
    private List pagedList(List list, int offset, int max)
    {
        int start = Math.min(list.size(), offset)
        int end = Math.min(list.size(), offset + max)
        return list.subList(start, end)
    }


}


