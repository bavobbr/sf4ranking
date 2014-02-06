package be.bbr.sf4ranking

import grails.transaction.Transactional
import groovy.json.JsonSlurper

@Transactional
class DataService
{

    Tournament importTournament(String tname, String results, Date date, TournamentFormat format, CountryCode country, Version game,
                                List videos, WeightingType wtype, TournamentType type)
    {
        if (wtype == WeightingType.AUTO) type = null
        else if (wtype == WeightingType.FIXED && type == null) throw new RuntimeException("A tournament type needs to be given when setting weight to FIXED")
        Tournament tournament = null
        tournament = new Tournament(name: tname, countryCode: country, date: date, weight: 1, game: game, videos: videos, format: format, weightingType: wtype, tournamentType: type)
        tournament.save(failOnError: true)
        results.eachLine {String line, index ->
            log.info("Parsing line $line")
            String pname = line.trim().tokenize("/").first().trim()
            String pchar = line.trim().tokenize("/").last().trim()
            Player p = Player.findByCodename(pname.toUpperCase())
            if (!p)
            {
                p = new Player(name: pname, skill: 0)
                log.info("Creating player $p using char $pchar")
                p.save(failOnError: true)
            }
            CharacterType ctype = CharacterType.fromString(pchar.toUpperCase())?: CharacterType.UNKNOWN
            def rank = ScoringSystem.getRank(index+1, tournament.tournamentFormat)
            Result r = new Result(player: p, place: rank, pcharacter: ctype, tournament: tournament)
            r.save(failOnError: true)
            tournament.addToResults(r)
        }
        tournament.save(failOnError: true)
        log.info("Saved tournament " + tournament)
        return tournament
    }

    String importFileData()
    {
        if (Player.count() > 0 || Tournament.count() > 0)
        {
            return "Delete data first, re-import works only on empty database"
        }
        def playerFile = new File(DataService.class.getResource("/data/players.json").toURI())
        def pdata = new JsonSlurper().parseText(playerFile.text)
        pdata.each {
            log.info "Saving player $it.name"
            def cc = it.countryCode as CountryCode
            Player p = new Player(name: it.name, countryCode: cc, skill: it.skill, videos: it.videos, score: it.score, rank: it.rank)
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
            Tournament tournament = new Tournament(name: it.name, countryCode: country, game: version, date: date, videos: it.videos, weight: weight, tournamentFormat: format, tournamentType: type, weightingType: weightingType)
            it.players.each {
                Player p = Player.findByCodename(it.player.toUpperCase())
                CharacterType ctype = it.character as CharacterType
                Result result = new Result(place: it.place, player: p, pcharacter: ctype)
                tournament.addToResults(result)
            }
            tournament.save(failOnError: true)
        }
        return "Created ${Tournament.count()} tournaments, ${Result.count()} rankings and ${Player.count()} players"
    }

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
            def players = []
            it.results.sort {a, b -> a.place <=> b.place}.each {
                def player = [:]
                player.place = it.place
                player.player = it.player.name
                player.character = it.pcharacter?.name()
                players << player
            }
            tournament.players = players
            tournaments << tournament
        }
        return tournaments
    }

    List<Player> exportPlayers()
    {
        def list = Player.list()
        def players = []
        list.each {
            def player = [:]
            player.name = it.name
            player.countryCode = it.countryCode?.name()
            player.rank = it.rank
            player.skill = it.skill
            player.videos = it.videos
            player.codename = it.codename
            player.score = it.score
            players << player
        }
        return players
    }

    void deleteAll()
    {
        Result.list().each {it.delete()}
        Player.list().each {it.delete()}
        Tournament.list().each {it.delete()}
    }

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
