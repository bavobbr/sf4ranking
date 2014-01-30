package be.bbr.sf4ranking

import grails.transaction.Transactional
import groovy.json.JsonSlurper

@Transactional
class RankingService
{

    private static final Map scores = [
            "GRAND_SLAM": [2000, 1300, [780] * 2, [430] * 4, [240] * 8].flatten(),
            "CHAMPIONSHIP": [1500, 1050, [690] * 2, [320] * 4, [200] * 8].flatten(),
            "PREMIER_MANDATORY": [1000, 650, [390] * 2, [215] * 4, [120] * 8].flatten(),
            "PREMIER_5": [900, 585, [350] * 2, [190] * 4, [105] * 8].flatten(),
            "PREMIER_12": [470, 305, [185] * 2, [100] * 4, [55] * 8].flatten(),
            "INTERNATIONAL": [280, 180, [110] * 2, [60] * 4, [30] * 8].flatten(),
            "SERIES": [160, 95, [57] * 2, [29] * 4, [15] * 8].flatten(),
            "CIRCUIT": [100, 60, [35] * 2, [20] * 4, [7] * 8].flatten(),
    ]

    Integer updateWeights()
    {
        def tournaments = Tournament.list()
        tournaments.each {tournament ->
            def topresults = tournament.results.sort {a, b -> b.player.skill<=>a.player.skill}.take(8)
            if (topresults)
            {
                Integer skillScore = topresults.sum {Result r -> r.player.skill}
                tournament.weight = (skillScore as Double) / topresults.size() * 10
                tournament.save(flush: true)
                log.info "Updated tournament $tournament with weight ${tournament.weight}"
            }
        }
        return tournaments.size()
    }

    Integer updateTypes()
    {
        def tournaments = Tournament.list().sort {a, b -> b.weight<=>a.weight}
        applyType(tournaments, TournamentType.GRAND_SLAM, 0, 1)
        applyType(tournaments, TournamentType.CHAMPIONSHIP, 1, 3)
        applyType(tournaments, TournamentType.PREMIER_MANDATORY, 4, 5)
        applyType(tournaments, TournamentType.PREMIER_5, 9, 5)
        applyType(tournaments, TournamentType.PREMIER_12, 14, 12)
        applyType(tournaments, TournamentType.INTERNATIONAL, 26, 20)
        applyType(tournaments, TournamentType.SERIES, 46, 50)
        applyType(tournaments, TournamentType.CIRCUIT, 96, 200)
        tournaments*.save()
        return tournaments.size()
    }

    Integer updatePlayerScore()
    {
        List players = Player.list()
        players.each {Player p ->
            log.info("Evaluating player $p")
            def results = Result.findAllByPlayer(p)
            def scores = results.collect { getScore(it.place, it.tournament.tournamentType) }.sort { a, b -> b <=> a}
            def bestof = scores.take(16)
            p.score = bestof.sum() as Integer
            p.save()
        }
        return players.size()
    }

    Integer updatePlayerRank()
    {
        List players = Player.list(order: "desc", sort: 'score')
        def previous = 0
        def currentRank = 0
        players.eachWithIndex {Player p, Integer idx ->
            if (p.score != previous) {
                currentRank = idx + 1
            }
            p.rank = currentRank
            previous = p.score
        }
        return players.size()
    }

    private void applyType(List tournaments, TournamentType type, int start, int amount)
    {
        if (start > tournaments.size() - 1) return
        def endIndex = Math.min(start + amount - 1, tournaments.size() - 1)
        tournaments[start..endIndex]*.tournamentType = type
    }

    public Integer getScore(Integer rank, TournamentType tournamentType)
    {
        List typescores = scores[tournamentType.name()]
        return typescores[rank - 1]
    }

    Tournament importTournament(String tname, String results)
    {
        Tournament tournament = null
        results.eachLine {String line, index ->
            log.info("Parsing line $line")
            if (index == 0)
            {
                def tokens = line.trim().tokenize("/")
                Date date = Date.parse("dd-MM-yyyy", tokens[0].trim())
                def tcc = tokens[1].trim() as CountryCode
                def tversion = tokens[2].trim() as Version
                def tvideos = null
                if (tokens.size() >= 4)
                {
                    tvideos = tokens[3].trim().tokenize(" ")
                }
                log.info("version is $tversion")
                tournament = new Tournament(name: tname, countryCode: tcc, date: date, weight: 1, game: tversion, videos: tvideos)
                tournament.save()
            }
            else
            {

                String pname = line.trim().tokenize("/").first().trim()
                String pchar = line.trim().tokenize("/").last().trim()
                Player p = Player.findByCodename(pname.toUpperCase())
                if (!p)
                {
                    p = new Player(name: pname, skill: 0)
                    log.info("Creating player $p using char $pchar")
                    p.save(failOnError: true)
                }
                CharacterType ctype
                try
                {
                    ctype = pchar.toUpperCase() as CharacterType
                }
                catch (e)
                {
                    ctype = CharacterType.UNKNOWN
                }
                Result r = new Result(player: p, place: index, pcharacter: ctype, tournament: tournament)
                r.save(failOnError: true)
                tournament.addToResults(r)
            }
        }
        tournament.save(failOnError: true)
        log.info("Saved tournament " + tournament)

        return tournament
    }

    String importFileData()
    {
        if (Player.count() > 0 || Tournament.count() > 0) {
            return "Delete data first, re-import works only on empty database"
        }
        def playerFile = new File(RankingService.class.getResource("/data/players.json").toURI())
        def pdata = new JsonSlurper().parseText(playerFile.text)
        pdata.each {
            log.info "Saving player $it.name"
            def cc = it.countryCode as CountryCode
            Player p = new Player(name: it.name, countryCode: cc, skill: it.skill, videos: it.videos, score: it.score, rank: it.rank)
            p.save(failOnError: true)
        }


        def tournamentFile = new File(RankingService.class.getResource("/data/tournaments.json").toURI())
        def tdata = new JsonSlurper().parseText(tournamentFile.text)
        tdata.each {
            log.info "Importing tournament $it.name"
            CountryCode country = it.country as CountryCode
            Version version = it.version as Version
            Date date = Date.parse("dd-MM-yyyy", it.date as String)
            Tournament tournament = new Tournament(name: it.name, countryCode: country, game: version, date: date, videos: it.videos, weight: 1)
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
}
