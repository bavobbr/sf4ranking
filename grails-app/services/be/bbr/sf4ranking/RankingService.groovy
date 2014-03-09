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
    Integer updateWeights(Version game)
    {
        def tournaments = Tournament.findAllByGame(game)
        tournaments.each {tournament ->
            log.info "Updating tournament $tournament"
            def weight = 0
            if (tournament.weightingType == WeightingType.AUTO)
            {
                def topresults = tournament.results.sort {a, b -> b.player.skill(game) <=> a.player.skill(game)}.take(8)
                if (topresults)
                {
                    Integer skillScore = topresults.sum {Result r -> r.player.skill(game)}
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
    Integer updateTypes(Version game)
    {
        def tournaments = Tournament.findAllByWeightingTypeAndGame(WeightingType.AUTO, game).sort {a, b -> b.weight <=> a.weight}
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
    Integer updatePlayerScores(Version game)
    {
        List players = Player.list()
        players.each {Player p ->
            log.info("Evaluating player $p, looking for results")
            def results = Result.where {
                player == p
                tournament.game == game
            }.list()
            log.info "Found ${results.size()} results"
            def scores = results.collect {
                if (it.tournament.ranked) {
                    ScoringSystem.getScore(it.place, it.tournament.tournamentType, it.tournament.tournamentFormat)
                }
                else 0
            }.sort {a, b -> b <=> a}
            def bestof = scores.take(16)
            p.score = (bestof.sum() as Integer)?: 0
            p.applyScore(game, p.score)
            p.save(failOnError: true)
            log.info "Saved player $p"
        }
        return players.size()
    }

    /**
     * The player rank is based on how he positions by score
     * If a score is equal to another player the rank is not incremented but kept equal
     */
    Integer updatePlayerRank(Version game)
    {
        List players = Player.where { results.tournament.game == game }.list().sort { a, b -> b.score(game) <=> a.score(game) }
        def previous = 0
        def currentRank = 0
        players.eachWithIndex {Player p, Integer idx ->
            log.info("Updating rank of player $p")
            if (p.score(game) != previous)
            {
                currentRank = idx + 1
            }
            p.rank = currentRank
            p.applyRank(game, p.rank)
            previous = p.score(game)
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
