package be.bbr.sf4ranking

import grails.plugin.searchable.SearchableService
import grails.transaction.Transactional
import grails.util.Environment
import groovy.json.JsonSlurper

/**
 * This service is responsible for importing data and exporting it as backup
 */
class DataService
{

    static transactional = false

    ConfigurationService configurationService
    SearchableService searchableService
    QueryService queryService
    /**
     * Takes in rich tournament data from the controller and saves it as tournament
     * Will also auto-create unknown players
     * Uses a specific results entry format to speed up data entry
     */
    @Transactional
    Tournament importTournament(String tname, String results, Date date, TournamentFormat format, CountryCode country, Version game,
                                List videos, WeightingType wtype, TournamentType type, Boolean ranked, String coverage, CptTournament cptTournament, String creator, Region region)
    {
        def finished = true
        if (!results) finished = false
        if (wtype == WeightingType.AUTO) type = null
        else if (wtype == WeightingType.FIXED && type == null) throw new RuntimeException("A tournament type needs to be given when setting weight to FIXED")
        if (format == TournamentFormat.EXHIBITION)
        {
            ranked = false
            wtype = WeightingType.AUTO
        }
        def fullname = "${tname} - ${game.name()}"
        Tournament tournament = new Tournament(name: fullname, countryCode: country, date: date, weight: 1, game: game, videos: videos,
                                    tournamentFormat: format, weightingType: wtype, tournamentType: type, ranked: ranked,
                                    coverage: coverage, cptTournament: cptTournament, finished: finished, creator: creator, region: region)
        tournament.save(failOnError: true)
        addResultsToTournament(results, tournament)
        tournament.save(failOnError: true)
        log.info("Saved tournament " + tournament)
        return tournament
    }

    @Transactional
    public void addResultsToTournament(String input, Tournament tournament)
    {
        input.trim().eachLine {def line, index ->
            def rank = ScoringSystem.getRank(index + 1, tournament.tournamentFormat)
            log.info "processing $line"
            def namematcher = (line =~ /^[^(]*/)
            String pname = namematcher[0].trim()
            Player p = Player.findByCodename(pname.toUpperCase())
            if (!p) {
                if (pname.contains("|")) {
                    pname = pname.tokenize("|").last().trim()
                }
                p = Player.findByCodename(pname.toUpperCase())
            }
            if (!p)
            {
                p = new Player(name: pname, cptPrize: 0, cptTournaments: 0)
                log.info "Creating player $p"
                p.save(failOnError: true)
            }
            if (!p.rankings.any {it.game == tournament.game})
            {
                PlayerRanking playerRanking = new PlayerRanking(score: 0, rank: 0, skill: 0, game: tournament.game)
                p.addToRankings(playerRanking)
            }
            Result r = new Result(player: p, place: rank, tournament: tournament)
            def charmatcher = (line =~ /\((.*?)\)/)
            if (charmatcher.count > 0)
            {
                boolean first = true
                String allchars = charmatcher[0][1]
                allchars.split(",").each {
                    GameTeam team = new GameTeam()
                    log.info "team: ${it.trim()}"
                    it.split("/").each {
                        CharacterType ctype = CharacterType.fromString(it.toUpperCase(), Version.generalize(tournament.game)) ?:
                                              CharacterType.UNKNOWN
                        team.addToPchars(new GameCharacter(characterType: ctype, main: first))
                        first = false
                    }
                    r.addToCharacterTeams(team)
                }
            }
            else
            {
                GameTeam team = new GameTeam()
                team.addToPchars(new GameCharacter(characterType: CharacterType.UNKNOWN, main: true))
                r.addToCharacterTeams(team)
                log.warn "no chars found, assigned empty team"
            }
            r.save(failOnError: true)
            tournament.addToResults(r)
        }
    }

    @Transactional
    Set<Player> findAlikes(String original) {
        log.info "Finding match for $original"
        Set<Player> alts = []
        def searchResult = Player.search(max: 5) {
            fuzzy("name", original, 0.4)
            fuzzy("twitter", original, 0.7)
            fuzzy("realname", original, 0.7)
        }
        alts = searchResult.results.collect {
            Player.read(it.id)
        }
        def withoutSpecial = original.replaceAll(Player.pattern, "").toLowerCase()
        println "looking for $withoutSpecial"
        searchResult = Player.search(max: 5) {
            fuzzy("simplified", withoutSpecial)
        }
        println "got $searchResult"
        alts.addAll(searchResult.results.collect {
            def p = Player.read(it.id)
            println "found $p"
            return p
        })
        log.info "Found ${alts.size()} matches"
        return alts
    }

    @Transactional
    List<Player> findAlike(String original, Integer max) {
        def alikes = findAlikes(original)
        return alikes? alikes.toList().take(max) : null
    }

    @Transactional
    Set<Player> findMatches(String query) {
        def wildcardedQuery = "%${query}%"
        log.info "Finding exact match for $query"
        Set<Player> matches = []
        matches.addAll(Player.findAllByCodenameIlike(wildcardedQuery))
        matches.addAll(Player.findAllByTwitterIlike(wildcardedQuery))
        matches.addAll(Player.findAllByRealnameIlike(wildcardedQuery))
        log.info "Found ${matches.size()} matches"
        return matches
    }

    @Transactional
    List<String> validateResults(String input, Version game, String type)
    {
        List<String> feedback = []
        if (game == Version.UNKNOWN || game == null) feedback << "Game version given is recognized as $game"
        input.trim().eachLine {def line, index ->
            def namematcher = (line =~ /^[^(]*/)
            String pname = namematcher[0].trim()
            if (type == "players")
            {
                Player p = Player.findByCodename(pname.toUpperCase())
                if (!p) {
                    if (pname.contains("|")) {
                        pname = pname.tokenize("|").last().trim()
                    }
                    p = Player.findByCodename(pname.toUpperCase())
                }
                if (!p) {
                    def suggestions = findAlike(pname, 3)
                    if (suggestions) {
                        feedback << "Not found [$pname]. Suggest: ${suggestions.name.join(", ")}"
                    }
                    else {
                        feedback << "Player with name [$pname] will be created new."
                    }
                }
            }
            else if (type == "chars")
            {
                def charmatcher = (line =~ /\((.*?)\)/)
                if (charmatcher.count > 0)
                {
                    String allchars = charmatcher[0][1]
                    allchars.split(",").each {String team ->
                        log.info "team: ${team.trim()}"
                        team.split("/").each {
                            CharacterType ctype = CharacterType.fromString(it.toUpperCase(), Version.generalize(game)) ?:
                                                  CharacterType.UNKNOWN
                            if (ctype == CharacterType.UNKNOWN) {
                                feedback <<
                                "Player [$pname] will have UNKNOWN character in team [$team] due to [$it]"
                            }
                        }
                    }
                }
                else
                {
                    feedback << "Player [$pname] will have completely UNKNOWN team"
                }
            }
        }
        if (!feedback) feedback << "All is well"
        return feedback
    }

    /**
     * Imports the static JSON data which is useful for test setups and initial deploys
     */
    String importFileData()
    {
            if (Player.count() > 0 || Tournament.count() > 0)
            {
                return "Delete data first, re-import works only on empty database"
            }
            def teamsFile = new File(DataService.class.getResource("/data/teams.json").toURI())
            def teamdata = new JsonSlurper().parseText(teamsFile.text)
            teamdata.each {
                log.info "Saving team $it.name"
                Team team = new Team(name: it.name, twitter: it.twitter, logo: it.logo, website: it.website, shortname: it.shortname)
                team.save(failOnError: true)
                log.info "saved team $team.id"
            }

            def playerFile = new File(DataService.class.getResource("/data/players.json").toURI())
            def pdata = new JsonSlurper().parseText(playerFile.text)
            pdata.each { pjson ->
                Player.withTransaction {
                    log.info "Saving player $pjson.name"
                    def cc = pjson.countryCode as CountryCode
                    def mainGame = Version.fromString(pjson.mainGame) ?: Version.UNKNOWN
                    def cptScore = pjson.cptScore ? pjson.cptScore : 0
                    def prevCptScore = pjson.prevCptScore ? pjson.prevCptScore : 0
                    def cptRank = pjson.cptRank ? pjson.cptRank : 0
                    def prevCptRank = pjson.prevCptRank ? pjson.prevCptRank : 0
                    def cptTournaments = pjson.cptTournaments ? pjson.cptTournaments : 0
                    def cptPrize = pjson.cptPrize ? pjson.cptPrize : 0
                    def cptQualified = pjson.cptQualified ? (pjson.cptQualified as boolean) : false
                    def pictureUrl = pjson.pictureUrl? pjson.pictureUrl : ""
                    def pictureCopyright = pjson.pictureCopyright? pjson.pictureCopyright : ""
                    def description = pjson.description? pjson.description : ""
                    Player p = new Player(name: pjson.name, countryCode: cc, videos: pjson.videos, wikilink: pjson.wikilink, twitter: pjson.twitter,
                            mainGame: mainGame, creator: pjson.creator, realname: pjson.realname, cptScore: cptScore,
                            cptQualified: cptQualified, prevCptScore: prevCptScore, cptRank: cptRank,
                            prevCptRank: prevCptRank, cptTournaments: cptTournaments, cptPrize: cptPrize, pictureCopyright: pictureCopyright,
                            pictureUrl: pictureUrl, description: description)
                    pjson.rankings.each {
                        def game = Version.fromString(it.game)
                        List mainCharacters = []
                        it.mainTeam.each {
                            def teamChar = CharacterType.fromString(it, Version.generalize(game)) ?: CharacterType.UNKNOWN
                            mainCharacters << teamChar
                        }
                        if (game && it.rank && it.score) {
                            PlayerRanking pranking = new PlayerRanking(skill: it.skill, rank: it.rank, score: it.score,
                                    totalScore: it.totalScore ?: 0, game: game, oldRank: it.oldRank,
                                    oldScore: it.oldScore, snapshot: it.snapshot)
                            p.addToRankings(pranking)
                            mainCharacters.each { pranking.addToMainCharacters(it) }
                        }
                    }
                    pjson.teams?.each {
                        log.info "finding team $it"
                        Team team = Team.findByCodename(it.toUpperCase())
                        if (team) p.addToTeams(team)
                    }
                    p.save(failOnError: true, flush: true)
                }
            }
            def tournamentFile = new File(DataService.class.getResource("/data/tournaments.json").toURI())
            def tdata = new JsonSlurper().parseText(tournamentFile.text)
            if (Environment.current == Environment.DEVELOPMENT) {
                //tdata = tdata.take(300)
            }
            tdata.each { tjson ->
                Tournament.withTransaction {
                    log.info "Importing tournament $tjson.name at $tjson.date"
                    CountryCode country = tjson.country as CountryCode
                    Version version = tjson.version as Version
                    if (Environment.current == Environment.DEVELOPMENT) {
                        if (version != Version.USF4 && version != Version.SF5) return
                    }
                    Date date = Date.parse("dd-MM-yyyy", tjson.date as String)
                    TournamentFormat format = TournamentFormat.fromString(tjson.format) ?: TournamentFormat.UNKNOWN
                    WeightingType weightingType = WeightingType.fromString(tjson.wtype) ?: WeightingType.AUTO
                    CptTournament cptTournament = CptTournament.fromString(tjson.cptTournament) ?: CptTournament.NONE
                    Region region = Region.fromString(tjson.region) ?: Region.UNKNOWN
                    TournamentType type = TournamentType.fromString(tjson.type)
                    Integer weight = tjson.weight ?: 0
                    String challonge = tjson.challonge
                    String coverage = tjson.coverage
                    String creator = tjson.creator
                    if (creator.equalsIgnoreCase("null")) creator = "unknown"
                    Boolean ranked = tjson.ranked?.toBoolean() ?: false
                    Boolean finished = tjson.finished?.toBoolean() ?: true
                    Tournament tournament = new Tournament(name: tjson.name, countryCode: country, game: version, date: date, videos: tjson.videos,
                            weight: weight, tournamentFormat: format, tournamentType: type,
                            weightingType: weightingType, challonge: challonge, ranked: ranked,
                            coverage: coverage, creator: creator, cptTournament: cptTournament, finished: finished, region: region)
                    tjson.players.each {
                        log.info "Processing ${it.player}"
                        Player p = Player.findByCodename(it.player.toUpperCase())
                        if (!p) {
                            log.warn("Creating player ad hoc $it")
                            p = new Player(name: it.player, countryCode: null)
                            p.save(failOnError: true)
                        }
                        Result result = new Result(place: it.place, player: p)
                        it.pteams.each {
                            GameTeam team = new GameTeam()
                            it.each {
                                CharacterType ctype = CharacterType.fromString(it, Version.generalize(version))
                                if (ctype == null) throw new RuntimeException("ctype is null for ${it} ${version}")
                                GameCharacter character = new GameCharacter(characterType: ctype, main: true)
                                team.addToPchars(character)
                            }
                            result.addToCharacterTeams(team)
                        }
                        tournament.addToResults(result)
                    }
                    tournament.save(failOnError: true, flush: true)
                }
            }
            log.info "All ${tdata.size()} tournaments imported"

        log.info "Import service completed"
        return "Created ${Tournament.count()} tournaments, ${Result.count()} rankings, ${Team.count} teams and ${Player.count()} players"
    }

    /**
     * Exports all tournament and result data as JSON
     */
    @Transactional
    List<Tournament> exportTournaments()
    {
        def list = Tournament.list()
        def tournaments = []
        list.each {
            def tournament = [:]
            tournament.version = it.game?.name()
            tournament.date = it.date?.format("dd-MM-yyyy")
            tournament.country = it.countryCode?.name()
            tournament.videos = it.videos
            tournament.name = it.name
            tournament.type = it.tournamentType?.name()
            tournament.format = it.tournamentFormat?.name()
            tournament.wtype = it.weightingType?.name()
            tournament.weight = it.weight
            tournament.challonge = it.challonge
            tournament.coverage = it.coverage
            tournament.ranked = it.ranked
            tournament.finished = it.finished
            tournament.creator = it.creator
            tournament.cptTournament = it.cptTournament?.name()
            tournament.region = it.region?.name()
            def players = []
            it.results.sort {a, b -> a.place <=> b.place}.each {
                def player = [:]
                player.place = it.place
                player.player = it.player.name
                def pteams = []
                it.characterTeams.each {
                    def pteam = []
                    it.pchars.each {
                        pteam << it.characterType.name()
                    }
                    pteams << pteam
                }
                player.pteams = pteams
                players << player
            }
            tournament.players = players
            tournaments << tournament
        }
        return tournaments
    }

    /**
     * Exports all Player data as JSON
     */
    @Transactional
    List<Player> exportPlayers()
    {
        def list = Player.list()
        def players = []
        list.each {
            def player = [:]
            player.name = it.name
            player.realname = it.realname
            player.countryCode = it.countryCode?.name()
            player.videos = it.videos
            player.codename = it.codename
            player.wikilink = it.wikilink
            player.twitter = it.twitter
            player.creator = it.creator
            player.pictureUrl = it.pictureUrl
            player.description = it.description
            player.pictureCopyright = it.pictureCopyright
            player.mainGame = it.mainGame?.name()
            player.cptScore = it.cptScore?: 0
            player.prevCptScore = it.prevCptScore?: 0
            player.cptRank = it.cptRank?: 0
            player.prevCptRank = it.prevCptRank?: 0
            player.cptPrize = it.cptPrize?: 0
            player.cptQualified = it.cptQualified?: false
            player.cptTournaments = it.cptTournaments?: 0
            player.cptPrize = it.cptPrize?: 0
            player.teams = it.teams.collect {it.codename}
            def rankings = []
            it.rankings.each {
                def ranking = [:]
                ranking.rank = it.rank
                ranking.score = it.score
                ranking.totalScore = it.totalScore
                ranking.skill = it.skill
                ranking.oldRank = it.oldRank
                ranking.oldScore = it.oldScore
                ranking.snapshot = it.snapshot
                def mainTeam = []
                it.mainCharacters.each {
                    mainTeam << it.name()
                }
                ranking.mainTeam = mainTeam
                ranking.game = it.game.name()
                rankings << ranking
            }
            player.rankings = rankings
            players << player
        }
        return players
    }

    /**
     * Exports all Team data as JSON
     */
    @Transactional
    List<Team> exportTeams()
    {
        def list = Team.list()
        def teams = []
        list.each {
            def team = [:]
            team.name = it.name
            team.shortname = it.shortname
            team.codename = it.codename
            team.logo = it.logo
            team.twitter = it.twitter
            team.website = it.website
            teams << team
        }
        return teams
    }

    /**
     * Cleans up database
     */
    void deleteAll()
    {
        configurationService.withUniqueSession {
            Result.list().each {it.delete()}
            Player.list().each {it.delete()}
            Tournament.list().each {it.delete()}
            Team.list().each {it.delete()}
        }

    }

    /**
     * Merges players into eachother to fix naming issues
     */
    @Transactional
    void merge(Player p1, Player p2)
    {
        configurationService.withUniqueSession {
            log.info("Merging $p1 into $p2")
            def resultsToMerge = Result.findAllByPlayer(p1)
            resultsToMerge.each {
                log.info "merging $it to $p2"
                it.player = p2
                it.save(failOnError: true, flush: true)
            }
            p1.delete(failOnError: true)
            p2.save(failOnError: true)
        }
    }
    @Transactional
    Integer takeSnapshot(Version game)
    {
        def rankings = []
        configurationService.withUniqueSession {
            rankings = PlayerRanking.findAllByGame(game)
            log.info "snapshotting ${rankings.size()} rankings for game $game"
            Date date = new Date()
            rankings.each {
                it.snapshot = date
                it.oldScore = it.score
                it.oldRank = it.rank
            }
        }
        if (game == Version.SF5) {
            Configuration configuration = Configuration.first()
            configuration.lastCptSnapshot = new Date()
            configuration.save()
            def players = queryService.findCptPlayers()
            players.each {
                it.prevCptScore = it.cptScore
                it.prevCptRank = it.cptRank
            }
        }
        return rankings.size()
    }

    public void reindexDatabase() {
        log.info "Reindexing..."
        searchableService.reindex()
        log.info "Reindexed compass"
    }
}
