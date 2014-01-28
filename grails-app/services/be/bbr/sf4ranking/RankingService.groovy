package be.bbr.sf4ranking

import grails.transaction.Transactional

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
        players.eachWithIndex {Player p, Integer idx ->
            p.rank = idx + 1
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

    void importFileData()
    {
        def dir = new File(RankingService.class.getResource("/data/").toURI())
        dir.eachFile {File filename ->
            Tournament tournament = null
            String file = filename.text
            log.info("Parsing file $filename")
            file.eachLine {String line, index ->
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
                    tournament = new Tournament(name: filename.name - ".txt", countryCode: tcc, date: date, weight: 1, game: tversion,
                                                videos: tvideos)
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
        }

        String file = new File(RankingService.class.getResource("/skills.txt").toURI()).text
        file.eachLine {
            def tokens = it.tokenize("/")
            def skill = tokens.first() as Integer
            def code = tokens[1]
            def cc = code == "-" ? null : code as CountryCode
            def name = tokens[2].trim()
            def pvideos = null
            if (tokens.size() >= 4)
            {
                pvideos = tokens[3].trim().tokenize(" ")
            }
            log.info("Applying skill $skill to $name")
            Player p = Player.findByCodename(name.toUpperCase())
            if (p)
            {
                p.skill = skill
                p.countryCode = cc
                p.save(failOnError: true)
                p.videos = pvideos
            }
            else
            {
                log.error(" Player with name $name could not be found")
            }

        }

    }
}
