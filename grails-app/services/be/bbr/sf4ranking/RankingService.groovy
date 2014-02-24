package be.bbr.sf4ranking

import grails.transaction.Transactional

/**
 * This service applies the ranking values (rank, score, weight, type) to all imported data
 * All the entries are evaluated together, rather than only the one that is added/updated
 */
@Transactional
class RankingService
{

    /**
     * Take the 8 best players from a tournament and calculate a skill average, this becomes the tournament weight
     * Only applied when weighting is set as AUTO, otherwise the weight is static per supplied tournament type
     */
    Integer updateWeights()
    {
        def tournaments = Tournament.list()
        tournaments.each {tournament ->
            def weight = 0
            if (tournament.weightingType == WeightingType.AUTO)
            {
                def topresults = tournament.results.sort {a, b -> b.player.skill <=> a.player.skill}.take(8)
                if (topresults)
                {
                    Integer skillScore = topresults.sum {Result r -> r.player.skill}
                    weight = (skillScore as Double) / topresults.size() * 10
                }
            }
            else
            {
                weight = tournament.tournamentType.classWeight
            }
            tournament.weight = weight
            tournament.save(flush: true, failOnError: true)
            log.info "Updated tournament $tournament with weight ${tournament.weight}"
        }
        return tournaments.size()
    }

    /**
     * Distribute the types for the tournaments that use AUTO weighting
     * Based on the tournament weight
     */
    Integer updateTypes()
    {
        def tournaments = Tournament.findAllByWeightingType(WeightingType.AUTO).sort {a, b -> b.weight <=> a.weight}
        // AUTO weighting starts from premier 5
        tournaments.each { it.tournamentType = TournamentType.UNRANKED }
        tournaments.removeAll { !it.ranked }
        applyType(tournaments, TournamentType.PREMIER_MANDATORY, 0, 4)
        applyType(tournaments, TournamentType.PREMIER_5, 4, 5)
        applyType(tournaments, TournamentType.PREMIER_12, 9, 12)
        applyType(tournaments, TournamentType.INTERNATIONAL, 21, 31)
        applyType(tournaments, TournamentType.SERIES, 52, 50)
        applyType(tournaments, TournamentType.CIRCUIT, 102, 200)
        tournaments*.save(failOnError: true)
        return tournaments.size()
    }

    /**
     * The player score is the sum of his best 16 tournaments in AE
     */
    Integer updatePlayerScore()
    {
        List players = Player.list()
        players.each {Player p ->
            log.info("Evaluating player $p")
            def results = Result.findAllByPlayer(p)
            def scores = results.collect {
                if (it.tournament.ranked) {
                    ScoringSystem.getScore(it.place, it.tournament.tournamentType, it.tournament.tournamentFormat)
                }
                else 0
            }.sort {a, b -> b <=> a}
            def bestof = scores.take(16)
            p.score = bestof.sum() as Integer
            p.save()
        }
        return players.size()
    }

    /**
     * The player rank is based on how he positions by score
     * If a score is equal to another player the rank is not incremented but kept equal
     */
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
        log.info "Applied type $type"
    }


    private List playerScoresAt(Date date) {
        List playerScores = []
        List players = Player.list(readOnly: true)
        players.each { Player p ->
            def results = Result.findAllByPlayer(p, [readOnly: true])
            def scores = results.collect {
                if (it.tournament.ranked && it.tournament.date.before(date)) {
                    ScoringSystem.getScore(it.place, it.tournament.tournamentType, it.tournament.tournamentFormat)
                }
                else 0
            }.sort {a, b -> b <=> a}
            def bestof = scores.take(16)
            def sum = bestof.sum() as Integer
            Expando holder = new Expando()
            holder.score = sum
            holder.name = p.name
            holder.id = p.id
            playerScores << holder
            println "added ${holder.name} with ${holder.score} and id ${holder.id}"
        }
        return playerScores
    }

    List playerRanksAt(Date date) {
        def sortedPlayers = playerScoresAt(date).sort { a, b -> b.score <=> a.score }
        def previous = 0
        def currentRank = 0
        sortedPlayers.eachWithIndex { p, Integer idx ->
            if (p.score != previous)
            {
                currentRank = idx + 1
            }
            p.rank = currentRank
            previous = p.score
        }
        return sortedPlayers
    }

}
