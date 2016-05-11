package be.bbr.overview

import be.bbr.sf4ranking.*
import grails.converters.JSON
import grails.plugin.searchable.SearchableService
import org.apache.shiro.SecurityUtils

/**
 * The controller that is public to users and shows the stats of Player, Tournament as well as overall
 */
class RankingsController
{

    QueryService queryService
    SearchableService searchableService
    DataService dataService

    /**
     * The index page is also the page with all the rankings
     * We need to find out which paghe it is on and which filters apply before doing a query
     * At the end we also fill the filter boxes with data relevant for that type of query
     * @return
     */
    def index()
    {
        def players = queryService.findPlayers(null, null, 10, 0, Version.AE2012)
        def umvc3players = queryService.findPlayers(null, null, 10, 0, Version.UMVC3)
        def kiplayers = queryService.findPlayers(null, null, 10, 0, Version.KI)
        def sgplayers = queryService.findPlayers(null, null, 10, 0, Version.SKULLGIRLS)
        def igauplayers = queryService.findPlayers(null, null, 10, 0, Version.IGAU)
        def usf4players = queryService.findPlayers(null, null, 10, 0, Version.USF4)
        def bbcpplayers = queryService.findPlayers(null, null, 10, 0, Version.BBCP)
        def mkxplayers = queryService.findPlayers(null, null, 10, 0, Version.MKX)
        def sf5players = queryService.findPlayers(null, null, 10, 0, Version.SF5)
        def lastUpdateMessage = Configuration.first().lastUpdateMessage
        def last10Tournaments = Tournament.list(order: "desc", sort: "date", max: 10)
        def last10players = Player.list(order: "desc", sort: "id", max: 10)
        [players: players, sf5players: sf5players, kiplayers: kiplayers, sgplayers: sgplayers, umvc3players: umvc3players, igauplayers: igauplayers, usf4players: usf4players, bbcpplayers: bbcpplayers, mkxplayers: mkxplayers, updateMessage: lastUpdateMessage, lastTournaments: last10Tournaments, lastPlayers: last10players]
    }

    def rank()
    {
        def pgame = Version.fromString(params.id) ?: Version.AE2012
        def palltime = params.alltime?.toBoolean()?: false
        def poffset = params.offset?.toInteger() ?: 0
        def pmax = params.max?.toInteger() ?: 50
        def pcountry = (!params.country || params.country =~ "any") ? null : CountryCode.fromString(params.country as String)
        def pchar = (!params.pchar || params.pchar =~ "any") ? null :
                    CharacterType.fromString(params.pchar as String, Version.generalize(pgame))
        def pfiltermain = params.filtermain == "on" ? true : false
        def filtered = pchar || pcountry
        log.info "Ranking for game $pgame offset $poffset max $pmax country $pcountry char $pchar filtered $filtered $pfiltermain"

        def players = queryService.findPlayers(pchar, pcountry, pmax, poffset, pgame, palltime)
        if (pfiltermain)
        {
            players.retainAll {pchar in it.rankings.find {it.game == pgame}?.mainCharacters}
        }
        def playercount = queryService.countPlayers(pchar, pcountry, pgame)
        log.info "getAll gave ${players.size()} players out of ${playercount}"

        def countrynames = queryService.getActiveCountryNames()
        countrynames.sort(true)
        // list all characters for the filter box
        def charnames = CharacterType.values().findAll {it.game == Version.generalize(pgame)}.collect {it.value}
        charnames.sort(true)
        // add a search all for each type
        countrynames.add(0, "any country")
        charnames.add(0, "any character")
        def lastUpdateMessage = Configuration.first().lastUpdateMessage
        def snapshot = null
        def lastTournament = queryService.lastTournament(pgame)
        println "Last tournament : $lastTournament"
        if (lastTournament) {
            def now = lastTournament?.date?.toCalendar()
            def yearAgo = GregorianCalendar.instance
            yearAgo.set(GregorianCalendar.YEAR, now.get(GregorianCalendar.YEAR) - 2)
            if (players && !players.isEmpty()) {
                snapshot = players?.first()?.snapshot(pgame)
                players.each {
                    def numResults = queryService.countPlayerResults(it, pgame)
                    def numResultsYear = queryService.countPlayerResultsAfter(it, pgame, yearAgo.time)
                    it.metaClass.numResults << { numResults }
                    it.metaClass.numResultsYear << { numResultsYear }
                }
            }
        }
        log.info "returning ${players.size()} players for game $pgame"
        [players: players, countries: countrynames, charnames: charnames, filtered: filtered,
         total: playercount, poffset: poffset, fchar: pchar, fcountry: pcountry, ffiltermain: pfiltermain,
         updateMessage: lastUpdateMessage, game: pgame, snapshot: snapshot, alltime: palltime]
    }

    def cpt_2015() {}
    def cptStats_2015() {}
    def cptCharacterStats_2015() {}

    def cpt()
    {
        def pgame = Version.SF5
        log.info "CPT Ranking for game $pgame $params.pcountry $params.pchar"
        def players = queryService.findCptPlayers()
        def playercount = players.size()
        log.info "getAll gave ${players.size()} players out of ${playercount}"
        def config = Configuration.first()
        def lastUpdateMessage = config.lastUpdateMessage
        def lastUpdate = config.lastCptSnapshot
        if (players && !players.isEmpty())
        {
            players.eachWithIndex { Player p, Integer idx ->
                p.metaClass.scoreQualified << { false }
                p.metaClass.scoreQualifiedNA << { false }
                p.metaClass.scoreQualifiedAO << { false }
                p.metaClass.scoreQualifiedLA << { false }
                p.metaClass.scoreQualifiedEU << { false }
                p.metaClass.rankDiff << {
                    if (p.prevCptRank == null || p.prevCptRank == 0) {
                        return null
                    }
                    else return p.prevCptRank-p.cptRank
                }
                p.metaClass.rankDiffClass << {
                    if (p.prevCptRank == null || p.prevCptRank == 0) {
                        return "warning"
                    }
                    else if (p.prevCptRank-p.cptRank == 0) {
                        return ""
                    }
                    else if (p.prevCptRank-p.cptRank < 0) {
                        return "danger"
                    }
                    else return "success"
                }
            }
        }
        def unqualifiedPlayers = players.findAll { !it.cptQualified }
        def qualifiedByScore = []
        unqualifiedPlayers.take(8).each {
            it.metaClass.scoreQualified = {true}
            qualifiedByScore << it
        }
        log.info "returning ${players.size()} players for game $pgame"


        def playersNA = queryService.findCptPlayers(Region.NA)
        playersNA.each { it.metaClass.scoreQualifiedNA = {false} }
        def unqualifiedPlayersNA = playersNA.findAll {  p ->
            return !p.cptRegionalQualified && !qualifiedByScore.any { it.name == p.name }
        }
        unqualifiedPlayersNA.take(2).each {
            it.metaClass.scoreQualifiedNA = {true}
        }
        def playersLA = queryService.findCptPlayers(Region.LA)
        playersLA.each { it.metaClass.scoreQualifiedLA = {false} }
        def unqualifiedPlayersLA = playersLA.findAll {  p ->
            return !p.cptRegionalQualified && !qualifiedByScore.any { it.name == p.name }
        }
        unqualifiedPlayersLA.take(2).each {
            it.metaClass.scoreQualifiedLA = {true}
        }
        def playersAO = queryService.findCptPlayers(Region.AO)
        playersAO.each { it.metaClass.scoreQualifiedAO = {false} }
        def unqualifiedPlayersAO = playersAO.findAll {  p ->
            return !p.cptRegionalQualified && !qualifiedByScore.any { it.name == p.name }
        }
        unqualifiedPlayersAO.take(2).each {
            it.metaClass.scoreQualifiedAO = {true}
        }
        def playersEU = queryService.findCptPlayers(Region.EU)
        playersEU.each { it.metaClass.scoreQualifiedEU = {false} }
        def unqualifiedPlayersEU = playersEU.findAll {  p ->
            return !p.cptRegionalQualified && !qualifiedByScore.any { it.name == p.name }
        }
        unqualifiedPlayersEU.take(2).each {
            println "setting $it as qualified"
            it.metaClass.scoreQualifiedEU = {true}
        }

        def openSpots = 8 + players.count { it.cptQualified }

        [players: players.take(50),
         total: playercount,
         updateMessage: lastUpdateMessage,
         game: pgame,
         lastUpdate: lastUpdate,
         playersNA: playersNA.take(30),
         playersLA: playersLA.take(30),
         playersAO: playersAO.take(30),
         playersEU: playersEU.take(30),
         openSpots: openSpots
        ]
    }

    def cptStats() {
        def comingTournaments = Tournament.where {
            game == Version.SF5 &&
            cptTournament != null &&
            cptTournament != CptTournament.NONE &&
            finished == false
        }.list()
        def maxTotal = comingTournaments.sum { Tournament t -> t.cptTournament.getScore(1) }

        def directPlaces = comingTournaments.count { Tournament t -> t.cptTournament in [CptTournament.PREMIER, CptTournament.PREMIER_SCORELESS, CptTournament.EVO, CptTournament.REGIONAL_FINAL]  }
        def pastTournaments = Tournament.where {
            game == Version.SF5 &&
            cptTournament != null &&
            cptTournament != CptTournament.NONE &&
            finished == true
        }.list()
        def regionalQualifyingHistory = []
        pastTournaments.sort { it.date }.each { t ->
            t.metaClass.qualified << {
                if (t.cptTournament in [CptTournament.PREMIER_SCORELESS, CptTournament.PREMIER, CptTournament.EVO, CptTournament.REGIONAL_FINAL]) {
                    return t.results?.sort { it.place }?.first()?.player?.name
                }
                else if (t.cptTournament == CptTournament.RANKING) {
                    def qp = t.results.sort { it.place }.findResult {
                        if (!regionalQualifyingHistory.contains(it.player)) {
                            regionalQualifyingHistory << it.player
                            return it.player.name
                        } else return null
                    }
                    return qp + " (RF)"
                }
                else return ""
            }
        }
        def pastMaxTotal = pastTournaments.sum { Tournament t -> t.cptTournament.getScore(1) }
        def pastDirectPlaces = pastTournaments.count { Tournament t -> t.cptTournament in [CptTournament.PREMIER, CptTournament.PREMIER_SCORELESS, CptTournament.EVO, CptTournament.REGIONAL_FINAL]  }

        def players = queryService.findCptPlayers()
        def qualifiedPlayers = players.findAll { it.cptQualified }
        def unqualifiedPlayers = players.findAll { !it.cptQualified }
        def qualifiedByScore = unqualifiedPlayers.take(8)
        qualifiedPlayers.addAll(qualifiedByScore)

        def regions = [Region.AO, Region.EU, Region.LA, Region.NA]
        regions.each { region ->
            def regionalPlayers = queryService.findCptPlayers(region)
            def unqualifiedPlayersRegional = regionalPlayers.findAll { p ->
                return !p.cptQualified && !qualifiedByScore.any { it.name == p.name }
            }
            qualifiedPlayers.addAll(unqualifiedPlayersRegional.take(2))
        }

        qualifiedPlayers.sort { it.cptScore }
        def byCountry = players.groupBy { it.countryCode }
        def byCountry32 = qualifiedPlayers.groupBy { it.countryCode }

        [coming: comingTournaments, played: pastTournaments, byCountry: byCountry, byCountry32: byCountry32, maxTotal: maxTotal, directPlaces: directPlaces, pastMaxTotal: pastMaxTotal, pastDirectPlaces: pastDirectPlaces]
    }

    def cptCharacterStats() {
        def players = queryService.findCptPlayers()
        def qualifiedPlayers = players.findAll { it.cptQualified }
        def qualifiedPlayersRegionalFinal = players.findAll { it.cptRegionalQualified }
        def unqualifiedPlayers = players.findAll { !it.cptQualified }
        def qualifiedByScore = unqualifiedPlayers.take(8)
        List<Player> players32 = []
        players32.addAll(qualifiedByScore)

        def regions = [Region.AO, Region.EU, Region.LA, Region.NA]
        def qualifiedRegionally = []
        regions.each { region ->
            def regionalPlayers = queryService.findCptPlayers(region)
            def unqualifiedPlayersRegional = regionalPlayers.findAll { p ->
                return !qualifiedByScore.any { it.name == p.name } && !p.cptQualified
            }
            qualifiedRegionally.addAll(unqualifiedPlayersRegional.take(2))
            players32.addAll(unqualifiedPlayersRegional.take(2))
        }
        def byMainCharacter32 = players32.groupBy { it.findRanking(Version.SF5).mainCharacters?.first() }
        def secondarySeenTop32 = [:]
        players32.each { def player ->
            List<GameCharacter> characters = []
            player.results.findAll { it.tournament.game == Version.SF5  && it.tournament.cptTournament != CptTournament.NONE }.each {
                it.characterTeams.each {
                    characters.addAll(it.pchars)
                    it.pchars.each {
                        if (secondarySeenTop32.containsKey(it.characterType)) {
                            secondarySeenTop32[it.characterType] << player
                        } else secondarySeenTop32[it.characterType] = [player] as HashSet
                    }
                }
            }
            Map<GameCharacter, Integer> byChar = characters.countBy { it.characterType }
            def byCharSorted = byChar.sort { a,b -> b.value <=> a.value}
            player.metaClass.usedCharacters << { byCharSorted }
        }
        def pastTournaments = Tournament.where {
            game == Version.SF5
            cptTournament != null
            cptTournament != CptTournament.NONE
            finished == true
        }.list()
        def charList = []
        pastTournaments.each {
            it.results.each {
                it.characterTeams.each {
                    it.pchars.each {
                        charList << it.characterType
                    }
                }
            }
        }
        def charToCount = charList.countBy { it }
        def notInTop32 = CharacterType.values().findAll {
            it.game == Version.SF5 && !byMainCharacter32.keySet().contains(it)
        }*.value
        def notInTop32All = CharacterType.values().findAll {
            it.game == Version.SF5 && !secondarySeenTop32.keySet().contains(it)
        }*.value
        players32 = players32.sort { it.usedCharacters().size() }.reverse()


        [byMainCharacter32: byMainCharacter32, charToCount: charToCount, notIn: notInTop32, notInAll: notInTop32All,
         secondary32: secondarySeenTop32, players32: players32,
         qualified: qualifiedPlayers, qualifiedGlobal: qualifiedByScore, qualifiedRegional: qualifiedRegionally, qualifiedPlayersRegionalFinal: qualifiedPlayersRegionalFinal]
    }

    /**
     * Look up a player and prepare data for the view
     */
    def player(Player player)
    {
        Map rankings = Version.values().collectEntries([:]) {[it, []]}
        Set chars = [] as Set
        Result.findAllByPlayer(player).sort {a, b -> b.tournament.date <=> a.tournament.date}.each {
            def tid = it.tournament.id
            def tname = it.tournament.name
            def ttype = it.tournament.tournamentType?.value
            def tteams = it.characterTeams
            def tdate = it.tournament.date?.format("yyyy-MM-dd")
            def tscore = it.tournament.tournamentType ? ScoringSystem.
                    getScore(it.place, it.tournament.tournamentType, it.tournament.tournamentFormat) : -1
            def tbasescore = it.tournament.tournamentType ?
                             ScoringSystem.getLegacyScore(it.place, it.tournament.weight, it.tournament.tournamentFormat) : -1
            def tplace = it.place
            def tcpt = it.tournament.cptTournament?.getScore(it.place)?: 0
            if (it.tournament.tournamentFormat == TournamentFormat.EXHIBITION)
            {
                tplace = it.place == 1 ? "Win" : "Lose"
            }
            def tvideos = it.tournament.videos
            def data = [tid: tid, tname: tname, ttype: ttype, tscore: tscore, tbasescore: tbasescore, tplace: tplace, tteams: tteams, tdate: tdate, tvideos: tvideos, resultid: it.id, tcpt: tcpt]
            rankings[it.tournament.game] << data
/*            if (Version.generalize(it.tournament.game) == Version.AE2012) {
                chars.addAll(it.characterTeams.collect.pchars*.characterType)
            }*/
        }
        log.info "Rendering player ${player}"
        rankings = rankings.findAll {k, v -> v.size() > 0}
        def lastUpdateMessage = Configuration.first().lastUpdateMessage
        render view: "player", model: [player: player, results: rankings, chars: chars, updateMessage: lastUpdateMessage]
    }

    def playerByName()
    {
        log.info "Resolving player byname $params.name"
        String uppername = params.name.toUpperCase()
        uppername = uppername.replace("%20", " ") // bugfix of url encoding. Breaks some possible names but better than nothing
        log.info "Resolving after fix player byname $uppername"
        Player p = Player.findByCodename(uppername)
        return player(p)
    }

    /**
     * Look up all tournament and fill relevant data for the filters
     */
    def tournaments()
    {
        def fgame = Version.fromString(params.id)
        def query = Tournament.where {
            if (params.country && !(params.country =~ "any")) countryCode == CountryCode.fromString(params.country)
            if (fgame) game == fgame
            if (params.type && !(params.type =~ "any")) tournamentType == params.type as TournamentType
        }
        List tournaments = query.list(order: "desc", sort: 'date')
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
        def lastUpdateMessage = Configuration.first().lastUpdateMessage

        [tournaments: tournaments, countries: countries, versions: versions, types: types, game: fgame, updateMessage: lastUpdateMessage]
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
            if (tournament.tournamentFormat == TournamentFormat.EXHIBITION)
            {
                rplace = it.place == 1 ? "Win" : "Lose"
            }
            def tteams = it.characterTeams
            def rscore = tournament.tournamentType ?
                         ScoringSystem.getScore(it.place, tournament.tournamentType, it.tournament.tournamentFormat) : -1
            def rcountry = it.player.countryCode?.name()?.toLowerCase()
            def rcountryname = it.player.countryCode?.name
            def pskill = null
            def prankingid = null
            if (SecurityUtils.subject.hasRoles(["Administrator", "Moderator"]))
            {
                pskill = it.player.skill(tournament.game)
                prankingid = it.player.rankings.find {it.game == tournament.game}?.id
            }
            details <<
            [rplayer: rplayer, rplace: rplace, rscore: rscore, rplayerid: rplayerid, tteams: tteams, rcountry: rcountry,
                    rcountryname: rcountryname, resultid: it.id, pskill: pskill, prankingid: prankingid]
        }
        def lastUpdateMessage = Configuration.first().lastUpdateMessage

        render view: 'tournament', model: [tournament: tournament, details: details, updateMessage: lastUpdateMessage]
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
        def lastUpdateMessage = Configuration.first().lastUpdateMessage

        [teams: teams, updateMessage: lastUpdateMessage]
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
        if (params.term?.trim()?.size() >= 2)
        {
            log.info "Processing query $params.term?"
            def players = dataService.findMatches(params.term?.trim())
            players.each {
                log.info "match: ${it}"
            }
            def sorted = players.sort {a, b -> Result.countByPlayer(b) <=> Result.countByPlayer(a)}
            def content = sorted.collect {[id: it.id, label: it.toString(), value: it.name]}
            render(content as JSON)
        }
    }

    /**
     * Endpoint for the AJAX search on tournaments
     */
    def autocompleteTournament()
    {
        def tournaments = Tournament.findAllByCodenameLike("%${params.term.toUpperCase()}%")
        def content = tournaments.collect {[id: it.id, label: it.toString(), value: it.name]}
        render(content as JSON)
    }

    def search()
    {
        def player = params.player
        def alikes = []
        def sorted = []
        if (player?.size() > 1)
        {
            def query = player?.trim()
            log.info "Processing query $query"
            def players = dataService.findMatches(query)
            sorted = players.sort {a, b -> Result.countByPlayer(b) <=> Result.countByPlayer(a) }
            alikes = dataService.findAlikes(player)
        }
        else
        {
            flash.message = "Query string too short"
        }
        [players: sorted, alikes: alikes, query: player]
    }

}