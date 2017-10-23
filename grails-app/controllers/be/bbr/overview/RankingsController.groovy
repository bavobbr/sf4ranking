package be.bbr.overview

import be.bbr.sf4ranking.*
import grails.converters.JSON
import grails.plugin.cache.Cacheable
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
    RankingService rankingService

    /**
     * The index page is also the page with all the rankings
     * We need to find out which paghe it is on and which filters apply before doing a query
     * At the end we also fill the filter boxes with data relevant for that type of query
     * @return
     */
    @Cacheable("index")
    def index()
    {
        def aeplayers = queryService.findPlayers(null, null, 10, 0, Version.AE2012)
        def umvc3players = queryService.findPlayers(null, null, 10, 0, Version.UMVC3)
        def kiplayers = queryService.findPlayers(null, null, 10, 0, Version.KI)
        def sgplayers = queryService.findPlayers(null, null, 10, 0, Version.SKULLGIRLS)
        def igauplayers = queryService.findPlayers(null, null, 10, 0, Version.IGAU)
        def usf4players = queryService.findPlayers(null, null, 10, 0, Version.USF4)
        def bbcpplayers = queryService.findPlayers(null, null, 10, 0, Version.BBCP)
        def mkxplayers = queryService.findPlayers(null, null, 10, 0, Version.MKX)
        def sf5players = queryService.findPlayers(null, null, 10, 0, Version.SF5)
        def t7players = queryService.findPlayers(null, null, 10, 0, Version.T7)
        def inj2players = queryService.findPlayers(null, null, 10, 0, Version.INJUSTICE2)
        def ggplayers = queryService.findPlayers(null, null, 10, 0, Version.GGXRD)
        def lastUpdateMessage = Configuration.first().lastUpdateMessage
        def last10Tournaments = queryService.lastTournaments(null, 10)
        def last10players = Player.list(order: "desc", sort: "id", max: 10)

        def cstats = CharacterStats.findAllByGame(Version.SF5)
        log.info "returning ${cstats.size()} char stats"
        cstats.removeAll {it.characterType == CharacterType.UNKNOWN}
        cstats = cstats.sort {a, b -> b.trendingScoreAccumulated <=> a.trendingScoreAccumulated}.take(10)

        [aeplayers: aeplayers, ggplayers: ggplayers, inj2players: inj2players, t7players: t7players, sf5players: sf5players, kiplayers: kiplayers, sgplayers: sgplayers, umvc3players: umvc3players, igauplayers: igauplayers, usf4players: usf4players, bbcpplayers: bbcpplayers, mkxplayers: mkxplayers, updateMessage: lastUpdateMessage, lastTournaments: last10Tournaments, lastPlayers: last10players, topsf5chars: cstats]
    }

    def rank()
    {
        def pgame = Version.fromString(params.id) ?: Version.AE2012
        def palltime = RankingType.fromString(params.rankingType) ?: RankingType.ACTUAL
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
            def yearAgo = lastTournament?.date?.minus(365+182)
            if (players && !players.isEmpty()) {
                snapshot = players?.first()?.snapshot(pgame)
                players.each {
                    def numResults = queryService.countPlayerResults(it, pgame)
                    def numResultsYear = queryService.countPlayerResultsAfter(it, pgame, yearAgo)
                    it.metaClass.numResults << { numResults }
                    it.metaClass.numResultsYear << { Math.min(numResultsYear,12) }
                }
            }
        }
        log.info "returning ${players.size()} players for game $pgame"
        [players: players, countries: countrynames, charnames: charnames, filtered: filtered,
         total: playercount, poffset: poffset, fchar: pchar, fcountry: pcountry, ffiltermain: pfiltermain,
         updateMessage: lastUpdateMessage, game: pgame, snapshot: snapshot, rankingType: palltime]
    }

    def cpt_2015() {}
    def cptStats_2015() {}
    def cptCharacterStats_2015() {}

    def cpt_2016() {}
    def cptStats_2016() {}
    def cptCharacterStats_2016() {}

    @Cacheable('cpt')
    def cpt()
    {
        def pgame = Version.SF5
        log.info "CPT Ranking for game $pgame $params.pcountry $params.pchar"

        def config = Configuration.first()
        def lastUpdateMessage = config.lastUpdateMessage
        def lastUpdate = config.lastCptSnapshot

        def players = queryService.findCptPlayers()
        def playercount = players.size()

        log.info "returning ${players.size()} players for game $pgame"

        def playersNA = queryService.findCptPlayers(Region.NA)
        def playersLA = queryService.findCptPlayers(Region.LA)
        def playersAO = queryService.findCptPlayers(Region.AO)
        def playersEU = queryService.findCptPlayers(Region.EU)

        Map<Region, List<Player>> regionalPlayers = [:]
        regionalPlayers[Region.AO] = playersAO.take(30)
        regionalPlayers[Region.LA] = playersLA.take(30)
        regionalPlayers[Region.EU] = playersEU.take(30)
        regionalPlayers[Region.NA] = playersNA.take(30)

        [players: players.take(50),
         total: playercount,
         updateMessage: lastUpdateMessage,
         game: pgame,
         lastUpdate: lastUpdate,
         regionalPlayers: regionalPlayers,
        ]
    }

    @Cacheable('cptStats')
    def cptStats() {
        def comingTournaments = queryService.upcomingCptTournaments().sort { it.date }
        def maxTotal = comingTournaments.sum { Tournament t -> t.cptTournament.getScore(1) }
        def maxTotalNA = comingTournaments.findAll { it.region == Region.NA}.sum { Tournament t -> t.cptTournament.getScore(1) }
        def maxTotalLA = comingTournaments.findAll { it.region == Region.LA}.sum { Tournament t -> t.cptTournament.getScore(1) }
        def maxTotalEU = comingTournaments.findAll { it.region == Region.EU}.sum { Tournament t -> t.cptTournament.getScore(1) }
        def maxTotalAO = comingTournaments.findAll { it.region == Region.AO}.sum { Tournament t -> t.cptTournament.getScore(1) }

        def regional = comingTournaments.findAll { it.cptTournament in [CptTournament.RANKING, CptTournament.ONLINE_EVENT] }
        def maxRegionTotalNA = regional.findAll { it.region == Region.NA}.sum { Tournament t -> t.cptTournament.getScore(1) }
        def maxRegionTotalLA = regional.findAll { it.region == Region.LA}.sum { Tournament t -> t.cptTournament.getScore(1) }
        def maxRegionTotalEU = regional.findAll { it.region == Region.EU}.sum { Tournament t -> t.cptTournament.getScore(1) }
        def maxRegionTotalAO = regional.findAll { it.region == Region.AO}.sum { Tournament t -> t.cptTournament.getScore(1) }

        def evoPlaces = comingTournaments.count { Tournament t ->
            t.cptTournament in [CptTournament.EVO]
        }

        def onlinePlaces = comingTournaments.count { Tournament t ->
            t.cptTournament in [CptTournament.ONLINE_EVENT]
        }

        def premierPlaces = comingTournaments.count { Tournament t ->
            t.cptTournament in [CptTournament.PREMIER, CptTournament.PREMIER_SCORELESS, CptTournament.REGIONAL_FINAL]
        }
        def rankingTournaments = comingTournaments.count { Tournament t ->
            t.cptTournament in [CptTournament.RANKING]
        }
        def pointTournaments = comingTournaments.count { Tournament t ->
            t.cptTournament in [CptTournament.RANKING, CptTournament.ONLINE_EVENT, CptTournament.EVO, CptTournament.PREMIER, CptTournament.REGIONAL_FINAL]
        }
        def pastTournaments = queryService.pastCptTournaments()
        Map<Region, List<Player>> regionalQualifyingHistories = [:]
        Region.values().each { regionalQualifyingHistories[it] = [] }
        pastTournaments.sort { it.date }.each { t ->
            t.metaClass.qualified << {
                log.info("... CPT stats on tournament ${t.name} with state ${t.finished} and results ${t.results.size()}")
                if (t.cptTournament in [CptTournament.PREMIER_SCORELESS, CptTournament.PREMIER, CptTournament.EVO, CptTournament.REGIONAL_FINAL]) {
                    return t.results?.sort { it.place }?.first()?.player?.name
                }
                else if (t.cptTournament == CptTournament.RANKING || t.cptTournament == CptTournament.ONLINE_EVENT) {
                    return t.results?.sort { it.place }?.first()?.player?.name
                }
                else return ""
            }
        }
        def pastMaxTotal = pastTournaments.sum { Tournament t -> t.cptTournament.getScore(1) }
        def pastDirectPlaces = pastTournaments.count { Tournament t -> t.cptTournament in [CptTournament.PREMIER, CptTournament.PREMIER_SCORELESS, CptTournament.EVO, CptTournament.REGIONAL_FINAL]  }

        def players = queryService.findCptPlayers()
        def directQualifiedPlayers = players.findAll { it.cptGlobal().qualified }
        Set<Player> qualifiedPlayers = players.findAll { it.cptGlobal().qualified }.toSet()

        def qualifiedByScore = players.findAll { it.cptGlobal().qualifiedByScore }
        qualifiedPlayers.addAll(qualifiedByScore)

        qualifiedPlayers.sort { it.cptGlobal()?.score }
        def byCountry = players.groupBy { it.countryCode }
        def byCountry32 = qualifiedPlayers.groupBy { it.countryCode }
        def byRegion32 = qualifiedPlayers.groupBy { it.countryCode.region }
        def unknownTotal = 32 - directQualifiedPlayers.size()

        [coming: comingTournaments,
         played: pastTournaments,
         byCountry: byCountry,
         byCountry32: byCountry32,
         byRegion32: byRegion32,
         maxTotal: maxTotal,
         unknownTotal: unknownTotal,
         premierTournament: premierPlaces,
         evoTournament: evoPlaces,
         onlineTournament: onlinePlaces,
         pastMaxTotal: pastMaxTotal,
         pastDirectPlaces: pastDirectPlaces,
         rankingCount: rankingTournaments,
         pointCount: pointTournaments,
         maxTotalLA: maxTotalLA,
         maxTotalNA: maxTotalNA,
         maxTotalAO: maxTotalAO,
         maxTotalEU: maxTotalEU,
         maxRegionTotalLA: maxRegionTotalLA?: 0,
         maxRegionTotalNA: maxRegionTotalNA?: 0,
         maxRegionTotalAO: maxRegionTotalAO?: 0,
         maxRegionTotalEU: maxRegionTotalEU?: 0,
        ]
    }

    @Cacheable('cptChars')
    def cptCharacterStats() {
        def players = queryService.findCptPlayers()
        def qualifiedPlayers = players.findAll { it.cptGlobal().qualified }
        def qualifiedPlayersRegionalFinal = players.findAll { it.cptRankings.any { it.region in Region.locals() && it.qualifiedByScore } }

        def qualifiedByScore = players.findAll { it.cptGlobal().qualifiedByScore }
        Set<Player> players32 = []
        players32.addAll(qualifiedByScore)
        players32.addAll(qualifiedPlayers)

        Map<Region, List<Player>> regionalPlayers = [:]
        regionalPlayers[Region.AO] = players.findAll { it.cptRankings.any { it.qualifiedByScore && it.region == Region.AO} }
        regionalPlayers[Region.LA] = players.findAll { it.cptRankings.any { it.qualifiedByScore && it.region == Region.LA} }
        regionalPlayers[Region.NA] = players.findAll { it.cptRankings.any { it.qualifiedByScore && it.region == Region.NA} }
        regionalPlayers[Region.EU] = players.findAll { it.cptRankings.any { it.qualifiedByScore && it.region == Region.EU} }

        def byMainCharacter32 = players32.groupBy { it.findRanking(Version.SF5).mainCharacters?.first() }
        def secondarySeenTop32 = [:]
        players32.each { def player ->
            println "processing player $player.name"
            List<GameCharacter> characters = []
            player.results.findAll { it.tournament.game == Version.SF5  && it.tournament.cptTournament != CptTournament.NONE }.each {
                println "   processing result $it.tournament.name"
                it.characterTeams.each {
                    characters.addAll(it.pchars)
                    println "      added characters: $it.pchars"
                    it.pchars.each {
                        println "         added $player for $it.characterType"
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
        def pastTournaments = queryService.pastCptTournaments()
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


        [byMainCharacter32: byMainCharacter32,
         charToCount: charToCount,
         notIn: notInTop32,
         notInAll: notInTop32All,
         secondary32: secondarySeenTop32,
         players32: players32,
         qualified: qualifiedPlayers,
         qualifiedGlobal: qualifiedByScore,
         qualifiedPlayersRegionalFinal: qualifiedPlayersRegionalFinal,
         regionalPlayers: regionalPlayers
        ]
    }

    /**
     * Look up a player and prepare data for the view
     */
    def player(Player player)
    {
        Map rankings = Version.values().collectEntries([:]) {[it, []]}
        Set chars = [] as Set
        Integer totalResults = 0
        Result.findAllByPlayer(player).sort {a, b -> b.tournament.date <=> a.tournament.date}.each {
            totalResults++
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
        def topGames = player.rankings.findAll { it.score > 0 && it.rank < 100 }.collect { it.game }
        def allGames = player.rankings.findAll { it.score > 0 && it.rank < 500 }.collect { it.game }
        def lastUpdateMessage = Configuration.first().lastUpdateMessage
        render view: "player", model: [player: player, results: rankings, chars: chars, updateMessage: lastUpdateMessage, topGames: topGames, allGames: allGames, totalResults: totalResults]
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
        def fgame = Version.fromString(params.id)?: Version.SF5
        log.info("Listing all tournaments of $fgame")
        def query = Tournament.where {
            if (params.country && !(params.country =~ "any")) countryCode == CountryCode.fromString(params.country)
            if (fgame) game == fgame
            if (params.type && !(params.type =~ "any")) tournamentType == params.type as TournamentType
        }
        List tournaments = query.list(order: "desc", sort: 'date')
        log.info("Found ${tournaments.size()} tournaments of $fgame")
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
            def rlabel = it.player.labelFor(tournament.game)
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
            [rplayer: rplayer, rlabel: rlabel, rplace: rplace, rscore: rscore, rplayerid: rplayerid, tteams: tteams, rcountry: rcountry,
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

    def events() {
        List events = Event.list(order: "desc", sort: "date")
        def lastUpdateMessage = Configuration.first().lastUpdateMessage
        [events: events, updateMessage: lastUpdateMessage]

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

    def event(Event event)
    {
        log.info "found ${event.name}"
        render view: 'event', model: [event: event]
    }

    def teamByName()
    {
        Team t = Team.findByCodename(params.name.toUpperCase())
        return team(t)
    }

    def eventByName()
    {
        Event t = Event.findByCodename(params.name.toUpperCase())
        return event(t)
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
            def content = players.collect {[id: it.id, label: it.toString(), value: it.name]}
            render(content as JSON)
        }
    }

    /**
     * Endpoint for the AJAX search on tournaments
     */
    def autocompleteTournament()
    {
        def tournaments = Tournament.findAllByCodenameLike("%${params.term.toUpperCase()}%")
        def content = tournaments.collect {
            if (it.event != null) {
                [id: it.event.id, label: it.event.name+ " (${it.countryCode}) [event]", value: it.event.name, type: "event"]
            }
            else {
                [id: it.id, label: it.name + " (${it.countryCode})", value: it.name, type: "tournament"]
            }
        }
        content = content.unique { it["id"] }
        render(content as JSON)
    }

    def search()
    {
        String player = params.player
        def alikes = []
        def players = []
        if (player?.size() > 1)
        {
            def query = player?.trim()
            query = query.tokenize("|").last()
            query = query.tokenize("'").last()
            query = query.tokenize("-").last()
            query = query.tokenize(".").last()
            query = query.tokenize("_").last()
            if (query.size() <= 1) {
                flash.message = "Query string too short"
            }
            else {
                log.info "Processing query $query"
                players = dataService.findMatches(query)
                alikes = dataService.findAlike(player, 10)
            }
        }
        else
        {
            flash.message = "Query string too short"
        }
        [players: players, alikes: alikes, query: player]
    }

    def searchTournament()
    {
        String tournamentName = params.tournament
        Set<Tournament> tournaments = []
        Set<Event> events = []
        if (tournamentName?.size() > 1)
        {
            def query = tournamentName?.trim()
            query = query.tokenize("|").last()
            query = query.tokenize("'").last()
            query = query.tokenize("-").last()
            query = query.tokenize(".").last()
            query = query.tokenize("_").last()
            if (query.size() <= 1) {
                flash.message = "Query string too short"
            }
            else {
                log.info "Processing query $query"
                tournaments = dataService.findTournamentMatches(query)
                events = dataService.findEventMatches(query)
            }
        }
        else
        {
            flash.message = "Query string too short"
        }
        [tournaments: tournaments, events: events, query: tournamentName]
    }

    public static String cptSummary(Player p) {
        def global = p.findCptRanking(Region.GLOBAL)
        def la = p.findCptRanking(Region.LA)
        def na = p.findCptRanking(Region.NA)
        def ao = p.findCptRanking(Region.AO)
        def eu = p.findCptRanking(Region.EU)
        StringBuffer result = new StringBuffer("Qualifications: <ul>")
        if (global?.qualified) {
            result.append("<li>Qualified directly in global board")
        }
        if (global?.qualifiedByScore) result.append("<li>Qualified by score in global board: ${global.score} pts / rank: ${global.rank}")
        if (la?.qualifiedByScore) result.append("<li>Qualified for regionals in LA region")
        if (na?.qualifiedByScore) result.append("<li>Qualified for regionals in NA region")
        if (ao?.qualifiedByScore) result.append("<li>Qualified for regionals in AO region")
        if (eu?.qualifiedByScore) result.append("<li>Qualified for regionals in EU region")
        result.append("</ul>")
        result.append("<ul>")
        if (global?.score > 0) result.append("<li>Global rank is ${global.rank} and score is ${global.score} pts")
        if (la?.score > 0) result.append("<li>LA rank is ${la.rank} and score is ${la.score} pts")
        if (na?.score > 0) result.append("<li>NA rank is ${na.rank} and score is ${na.score} pts")
        if (ao?.score > 0) result.append("<li>AO rank is ${ao.rank} and score is ${ao.score} pts")
        if (eu?.score > 0) result.append("<li>EU rank is ${eu.rank} and score is ${eu.score} pts")
        result.append("</ul>")
        return result.toString()
    }

    public static String cptLabel(Player p, Region region) {
        def labels = []
        if (p.cptGlobal().qualified) {
            labels << "Direct"
        }
        if (p.cptGlobal().qualifiedByScore) {
            labels << "Global"
        }
        if (region != Region.GLOBAL) {
            println "Looking up cpt rank of $p in region $region"
            if (p.findCptRanking(region).qualifiedByScore) {
                labels << "Regional"
            }
        }
        else {
            if (Region.locals().any { p.findCptRanking(it)?.qualifiedByScore} ) {
                labels << "Regional"
            }
        }
        return labels.join(" | ")
    }



}