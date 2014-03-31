package be.bbr.sf4ranking

import grails.transaction.Transactional
import groovy.json.JsonSlurper

/**
 * This service is responsible for importing data and exporting it as backup
 */
@Transactional
class DataService
{

    /**
     * Takes in rich tournament data from the controller and saves it as tournament
     * Will also auto-create unknown players
     * Uses a specific results entry format to speed up data entry
     */
    Tournament importTournament(String tname, String results, Date date, TournamentFormat format, CountryCode country, Version game,
                                List videos, WeightingType wtype, TournamentType type, Boolean ranked, String coverage)
    {
        if (wtype == WeightingType.AUTO) type = null
        else if (wtype == WeightingType.FIXED && type == null) throw new RuntimeException("A tournament type needs to be given when setting weight to FIXED")
        Tournament tournament = null
        if (format == TournamentFormat.EXHIBITION) {
            ranked = false
            wtype = WeightingType.AUTO
        }
        tournament = new Tournament(name: tname, countryCode: country, date: date, weight: 1, game: game, videos: videos, tournamentFormat: format, weightingType: wtype, tournamentType: type, ranked: ranked, coverage: coverage)
        tournament.save(failOnError: true)
        addResultsToTournament(results, tournament)
        tournament.save(failOnError: true)
        log.info("Saved tournament " + tournament)
        return tournament
    }

    private void addResultsToTournament(String input, Tournament tournament) {
        input.trim().eachLine { def line, index ->
            def rank = ScoringSystem.getRank(index+1, tournament.tournamentFormat)
            log.info "processing $line"
            def namematcher = (line =~ /^[^(]*/)
            String pname = namematcher[0].trim()
            Player p = Player.findByCodename(pname.toUpperCase())
            if (!p)
            {
                PlayerRanking playerRanking = new PlayerRanking(score: 0, rank: 0, skill: 0, game: tournament.game)
                p = new Player(name: pname)
                p.addToRankings(playerRanking)
                log.info "Creating player $p"
                p.save(failOnError: true)
            }
            Result r = new Result(player: p, place: rank, tournament: tournament)
            def charmatcher = (line =~ /\((.*?)\)/)
            if (charmatcher.count > 0) {
                boolean first = true
                String allchars = charmatcher[0][1]
                allchars.split(",").each {
                    GameTeam team = new GameTeam()
                    log.info "team: ${it.trim()}"
                    it.split("/").each {
                        CharacterType ctype = CharacterType.fromString(it.toUpperCase(), Version.generalize(tournament.game))?: CharacterType.UNKNOWN
                        team.addToPchars(new GameCharacter(characterType: ctype, main: first))
                        first = false
                    }
                    r.addToCharacterTeams(team)
                }
            }
            else {
                GameTeam team = new GameTeam()
                team.addToPchars(new GameCharacter(characterType: CharacterType.UNKNOWN, main: true))
                r.addToCharacterTeams(team)
                log.warn "no chars found, assigned empty team"
            }
            r.save(failOnError: true)
            tournament.addToResults(r)
        }
    }


    List<String> validateResults(String input, Version game) {
        List<String> feedback = []
        if (game == Version.UNKNOWN || game == null) feedback << "Game version given is recognized as $game"
        input.trim().eachLine { def line, index ->
            def namematcher = (line =~ /^[^(]*/)
            String pname = namematcher[0].trim()
            Player p = Player.findByCodename(pname.toUpperCase())
            if (!p) feedback << "Player with name $pname will be created new"
            def charmatcher = (line =~ /\((.*?)\)/)
            if (charmatcher.count > 0) {
                String allchars = charmatcher[0][1]
                allchars.split(",").each { String team ->
                    log.info "team: ${team.trim()}"
                    team.split("/").each {
                        CharacterType ctype = CharacterType.fromString(it.toUpperCase(), Version.generalize(game))?: CharacterType.UNKNOWN
                        if (ctype == CharacterType.UNKNOWN) feedback << "Player $pname will have UNKNOWN character in team $team due to $it"
                    }
                }
            }
            else {
                feedback << "Player $pname will have completely UNKNOWN team"
            }
        }
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
        pdata.each {
            log.info "Saving player $it.name"
            def cc = it.countryCode as CountryCode
            def mainGame = Version.fromString(it.mainGame)?: Version.UNKNOWN
            Player p = new Player(name: it.name, countryCode: cc, videos: it.videos, wikilink: it.wikilink, twitter: it.twitter, mainGame: mainGame)
            it.rankings.each {
                def game = Version.fromString(it.game)
                List mainCharacters = []
                it.mainTeam.each {
                    def teamChar = CharacterType.fromString(it, Version.generalize(game))?: CharacterType.UNKNOWN
                    mainCharacters << teamChar
                }
                if (game && it.rank && it.score) {
                    PlayerRanking pranking = new PlayerRanking(skill: it.skill, rank: it.rank, score: it.score, game: game)
                    p.addToRankings(pranking)
                    mainCharacters.each { pranking.addToMainCharacters(it) }
                }
            }
            it.teams?.each {
                log.info "finding team $it"
                Team team = Team.findByCodename(it.toUpperCase())
                if (team) p.addToTeams(team)
            }
            p.save(failOnError: true)
        }
        def tournamentFile = new File(DataService.class.getResource("/data/tournaments.json").toURI())
        def tdata = new JsonSlurper().parseText(tournamentFile.text)
        tdata.each {
            log.info "Importing tournament $it.name"
            CountryCode country = it.country as CountryCode
            Version version = it.version as Version
            Date date = Date.parse("dd-MM-yyyy", it.date as String)
            TournamentFormat format = TournamentFormat.fromString(it.format)?: TournamentFormat.UNKNOWN
            WeightingType weightingType = WeightingType.fromString(it.wtype)?: WeightingType.AUTO
            TournamentType type = TournamentType.fromString(it.type)
            Integer weight = it.weight?: 0
            String challonge = it.challonge
            String coverage = it.coverage
            Boolean ranked = it.ranked?.toBoolean()?: false
            Tournament tournament = new Tournament(name: it.name, countryCode: country, game: version, date: date, videos: it.videos, weight: weight, tournamentFormat: format, tournamentType: type, weightingType: weightingType, challonge: challonge, ranked: ranked, coverage: coverage)
            it.players.each {
                log.info "Processing ${it.player}"
                Player p = Player.findByCodename(it.player.toUpperCase())
                log.info "Found player $p for tournament ${tournament.name}"
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
                        //character.save(failOnError: true)
                        log.info "Found character $character for player ${p.name}"
                        team.addToPchars(character)
                    }
                    result.addToCharacterTeams(team)
                }
                log.info "Seen result $result"
                tournament.addToResults(result)
            }
            tournament.save(failOnError: true)
        }
        return "Created ${Tournament.count()} tournaments, ${Result.count()} rankings, ${Team.count} teams and ${Player.count()} players"
    }

    /**
     * Exports all tournament and result data as JSON
     */
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
    List<Player> exportPlayers()
    {
        def list = Player.list()
        def players = []
        list.each {
            def player = [:]
            player.name = it.name
            player.countryCode = it.countryCode?.name()
            player.videos = it.videos
            player.codename = it.codename
            player.wikilink = it.wikilink
            player.twitter = it.twitter
            player.mainGame = it.mainGame?.name()
            player.teams = it.teams.collect { it.codename }
            def rankings = []
            it.rankings.each {
                def ranking = [:]
                ranking.rank = it.rank
                ranking.score = it.score
                ranking.skill = it.skill
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
        Result.list().each {it.delete()}
        Player.list().each {it.delete()}
        Tournament.list().each {it.delete()}
        Team.list().each {it.delete()}

    }

    /**
     * Merges players into eachother to fix naming issues
     */
    void merge(Player p1, Player p2)
    {
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
