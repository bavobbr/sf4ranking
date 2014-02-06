package be.bbr.sf4ranking

import grails.transaction.Transactional

@Transactional
class RankingService
{

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
            def scores = results.collect {
                getScore(it.place, it.tournament.tournamentType, it.tournament.tournamentFormat)
            }.sort {a, b -> b <=> a}
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

    /**
     * Keeping this here too so I dont need to change the views which could give merge issues with Kineda
     */
    public Integer getScore(Integer rank, TournamentType tournamentType, TournamentFormat tournamentFormat = TournamentFormat.DOUBLE_BRACKET)
    {
        ScoringSystem.getScore(rank, tournamentType, tournamentFormat)
    }

}
