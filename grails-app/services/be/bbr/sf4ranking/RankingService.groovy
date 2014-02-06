package be.bbr.sf4ranking

import grails.transaction.Transactional

@Transactional
class RankingService
{

    private static final Map scores = [
            "GRAND_SLAM": [2000, 1300, [780] * 2, [430] * 4, [240] * 8, [120] * 16].flatten(),
            "CHAMPIONSHIP": [1500, 1050, [690] * 2, [320] * 4, [200] * 8, [100] * 16].flatten(),
            "PREMIER_MANDATORY": [1000, 650, [390] * 2, [215] * 4, [120] * 8, [60] * 16].flatten(),
            "PREMIER_5": [900, 585, [350] * 2, [190] * 4, [105] * 8, [50] * 16].flatten(),
            "PREMIER_12": [470, 305, [185] * 2, [100] * 4, [55] * 8, [25] * 16].flatten(),
            "INTERNATIONAL": [280, 180, [110] * 2, [60] * 4, [30] * 8, [15] * 16].flatten(),
            "SERIES": [160, 95, [57] * 2, [29] * 4, [15] * 8, [7] * 16].flatten(),
            "CIRCUIT": [100, 60, [35] * 2, [20] * 4, [7] * 8, [3] * 16].flatten(),
    ]

    private static final Map ranks = [
            LEAGUE: 1..32,
            UNKNOWN: 1..32,
            SINGLE_BRACKET: [1, 2, [3] * 2, [5] * 4, [9] * 8, [17] * 16].flatten(),
            DOUBLE_BRACKET: [1, 2, 3, 4, [5] * 2, [7] * 2, [9] * 4, [13] * 4, [17] * 8, [25] * 8].flatten()
    ]

    Integer updateWeights()
    {
        def tournaments = Tournament.list()
        tournaments.each {tournament ->
            def topresults = tournament.results.sort {a, b -> b.player.skill <=> a.player.skill}.take(8)
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
        def tournaments = Tournament.list().sort {a, b -> b.weight <=> a.weight}
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
            def scores = results.collect {getScore(it.place, it.tournament.tournamentType)}.sort {a, b -> b <=> a}
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
            if (p.score != previous)
            {
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
        List typescores = scores[tournamentType.name()] as List
        return typescores[rank - 1] as Integer
    }

    public Integer getRank(Integer index, TournamentFormat tournamentFormat)
    {
        List typeranks = ranks[tournamentFormat.name()] as List
        return typeranks[index - 1] as Integer
    }


}
