package be.bbr.sf4ranking

import grails.transaction.Transactional

/**
 * This service applies the ranking values (rank, score, weight, type) to all imported data
 * All the entries are evaluated together, rather than only the one that is added/updated
 */
@Transactional
class RankingService
{

    ConfigurationService configurationService

    /**
     * Take the 8 best players from a tournament and calculate a skill average, this becomes the tournament weight
     * Only applied when weighting is set as AUTO, otherwise the weight is static per supplied tournament type
     */
    Integer updateWeights(Version game)
    {
        def tournaments = []
        configurationService.withUniqueSession {
            tournaments = Tournament.findAllByGame(game)
            tournaments.each {tournament ->
                log.info "Updating tournament $tournament"
                def weight = 0
                def topresults = tournament.results.sort {a, b -> b.player.skill(game) <=> a.player.skill(game)}.take(8)
                if (topresults)
                {
                    Integer skillScore = topresults.sum {Result r -> r.player.skill(game)}
                    weight = (skillScore as Double) / topresults.size() * 10
                }

                tournament.weight = weight
                tournament.save(flush: true, failOnError: true)
                log.info "Updated tournament $tournament with weight ${tournament.weight}"
            }
        }
        return tournaments.size()
    }

    /**
     * Distribute the types for the tournaments that use AUTO weighting
     * Based on the tournament weight
     */
    Integer updateTypes(Version game)
    {
        def tournaments = []
        configurationService.withUniqueSession {
            tournaments = Tournament.findAllByWeightingTypeAndGame(WeightingType.AUTO, game).sort {a, b -> b.weight <=> a.weight}
            // AUTO weighting starts from premier 5
            tournaments.each {it.tournamentType = TournamentType.UNRANKED}
            tournaments.removeAll {!it.ranked}
            double factor = Math.max(tournaments.size() / 100.0, 1.0)
            int end = applyType(tournaments, TournamentType.PREMIER_MANDATORY, 0, 4, factor)
            end = applyType(tournaments, TournamentType.PREMIER_5, end, 5, factor)
            end = applyType(tournaments, TournamentType.PREMIER_12, end, 12, factor)
            end = applyType(tournaments, TournamentType.INTERNATIONAL, end, 31, factor)
            end = applyType(tournaments, TournamentType.SERIES, end, 50, factor)
            end = applyType(tournaments, TournamentType.CIRCUIT, end, 200, factor)
            tournaments*.save(failOnError: true)
        }
        return tournaments.size()
    }

    /**
     * The player score is the sum of his best 16 tournaments in AE
     */
    Integer updatePlayerScores(Version game)
    {
        List players = Player.list()
        configurationService.withUniqueSession {
            players.each {Player p ->
                log.info("Evaluating for $game player $p, looking for results")
                def results = Result.where {
                    player == p
                    tournament.game == game
                }.list()
                log.info "Found ${results.size()} results"
                def playerScore = getScore(results) {Result r ->
                    ScoringSystem.getScore(r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
                }
                p.applyScore(game, playerScore)
                def decayedScore = getScore(results) {Result r ->
                    ScoringSystem.getDecayedScore(r.tournament.date, r.place, r.tournament.tournamentType, r.tournament.tournamentFormat)
                }
                p.applyScore(game, decayedScore)
                p.applyTotalScore(game, playerScore)
                p.save(failOnError: true)
            }
            log.info "Updated ${players.size()} scores"
        }
        return players.size()
    }

    private Integer getScore(List<Result> results, Closure scoringRule)
    {
        def scores = results.collect {
            if (it.tournament.ranked)
            {
                scoringRule(it)
            }
            else 0
        }.sort {a, b -> b <=> a}
        def bestof = scores.take(16)
        (bestof.sum() as Integer) ?: 0
    }

    /**
     * The player rank is based on how he positions by score
     * If a score is equal to another player the rank is not incremented but kept equal
     */
    Integer updatePlayerRank(Version game)
    {
        List players = Player.where {results.tournament.game == game}.list().sort {a, b -> b.score(game) <=> a.score(game)}
        configurationService.withUniqueSession {
            log.info("Found ${players.size()} to update rank")
            def previous = 0
            def currentRank = 0
            players.eachWithIndex {Player p, Integer idx ->
                log.info("Updating $game rank of player $p")
                if (p.score(game) != previous)
                {
                    currentRank = idx + 1
                }
                def rank = currentRank
                p.applyRank(game, rank)
                previous = p.score(game)
                log.info("Updated rank of player $p, setting previous as $previous")
            }
        }
        return players.size()
    }

    /**
     */
    Integer updateMainTeams(Version game)
    {
        List players = Player.where {results.tournament.game == game}.list().sort {a, b -> b.score(game) <=> a.score(game)}
        configurationService.withUniqueSession {
            log.info("Found ${players.size()} to update main")
            players.each {Player p ->
                PlayerRanking ranking = p.rankings.find {it.game == game}
                if (ranking)
                {
                    ranking.mainCharacters.clear()
                    def filteredResults = p.results.findAll {it.tournament.game == game}
                    def teams = filteredResults.collect {Result r -> r.characterTeams.collect {it}}.flatten()
                    teams.removeAll {it.hasUnknown()}
                    def countedGroup = teams.countBy {GameTeam team -> team}
                    def sortedGroup = countedGroup.sort {a, b -> b.value <=> a.value}
                    if (sortedGroup)
                    {
                        def main = sortedGroup.keySet().first()
                        log.info "applying main team $main"
                        main.pchars.each {GameCharacter gameCharacter ->
                            ranking.mainCharacters.add(gameCharacter.characterType)
                        }
                    }
                    else
                    {
                        log.info "applying unknown main team to ${p.name}"
                        ranking.mainCharacters.add(CharacterType.UNKNOWN)
                    }
                    ranking.save(failOnError: true)
                }
                p.save(failOnError: true)

            }
        }
        return players.size()
    }

    Integer updateMainGames()
    {
        configurationService.withUniqueSession {
            Player.list().each {Player player ->
                log.info "Updating main game of $player.name"
                def c = Result.createCriteria()
                def results = c {
                    createAlias('tournament', 'tournamentAlias')
                    projections {
                        groupProperty("tournamentAlias.game")
                        rowCount()
                    }
                    eq("player", player)
                }
                log.info "Counts is $results"
                def sorted = results.sort {a, b -> b[1] <=> a[1]}
                if (sorted)
                {
                    def main = sorted.first()[0]
                    log.info "Main game is $main"
                    player.mainGame = main
                }
            }
        }
        return Player.count
    }

    private int applyType(List tournaments, TournamentType type, int start, int amount, double factor)
    {
        int factoredAmount = (int) (amount * factor)
        log.info "Applying type $type to $amount tournaments from $start with factor $factor"
        log.info "Translated to type $type times $factoredAmount tournaments from $start"
        if (start > tournaments.size() - 1) return tournaments.size()
        def endIndex = Math.min(start + factoredAmount - 1, tournaments.size() - 1)
        tournaments[start..endIndex]*.tournamentType = type
        log.info "Applied type $type"
        return start + factoredAmount;
    }


    private List playerScoresAt(Date date)
    {
        List playerScores = []
        List players = Player.list(readOnly: true)
        players.each {Player p ->
            def results = Result.findAllByPlayer(p, [readOnly: true])
            def scores = results.collect {
                if (it.tournament.ranked && it.tournament.date.before(date))
                {
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

    List playerRanksAt(Date date)
    {
        def sortedPlayers = playerScoresAt(date).sort {a, b -> b.score <=> a.score}
        def previous = 0
        def currentRank = 0
        sortedPlayers.eachWithIndex {p, Integer idx ->
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
