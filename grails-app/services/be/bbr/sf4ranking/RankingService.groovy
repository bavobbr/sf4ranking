package be.bbr.sf4ranking

import grails.transaction.NotTransactional
import grails.transaction.Transactional

/**
 * This service applies the ranking values (rank, score, weight, type) to all imported data
 * All the entries are evaluated together, rather than only the one that is added/updated
 */
class RankingService {

    static transactional = false

    ConfigurationService configurationService
    QueryService queryService

    /**
     * Take the 8 best players from a tournament and calculate a skill average, this becomes the tournament weight
     * Only applied when weighting is set as AUTO, otherwise the weight is static per supplied tournament type
     */
    @Transactional
    Integer updateWeights(Version game) {
        def tournaments = []
        configurationService.withUniqueSession {
            tournaments = Tournament.findAllByGame(game)
            tournaments.each { tournament ->
                def sampleSize = tournament.game == Version.SF5? 16 : 8
                log.info "Updating tournament $tournament"
                Integer weight = 0
                def topresults = tournament.results.sort { a, b -> b.player.skill(game) <=> a.player.skill(game) }.take(sampleSize)
                if (topresults) {
                    Integer skillScore = topresults.sum { Result r -> Math.pow(r.player.skill(game), 2) }
                    def entries = Math.max(topresults.size(), sampleSize)
                    weight = (skillScore as Double) / entries * 10
                    def countryBonus = 1
                    Set uniqueCountries = tournament.results.collect { Result r -> r.player.countryCode }
                    uniqueCountries.remove(null)
                    if (uniqueCountries.size() >= 3) {
                        countryBonus = 1.1
                        log.info "Countrybonus for ${tournament} set to $countryBonus as countries is $uniqueCountries"
                    }
                    if (uniqueCountries.size() >= 5) {
                        countryBonus = 1.2
                        log.info "Countrybonus for ${tournament} set to $countryBonus as countries is $uniqueCountries"
                    }
                    weight = weight * countryBonus / 10
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
    @Transactional
    Integer updateTypes(Version game) {
        def tournaments = []
        configurationService.withUniqueSession {
            tournaments = Tournament.findAllByGame(game).sort { a, b -> b.weight <=> a.weight }
            if (!tournaments) return
            // AUTO weighting starts from premier 5
            def lastTournament = tournaments.sort { Tournament t -> t.date }.last()
            println "Using last tournament $lastTournament on ${lastTournament.date} as reference"
            def now = lastTournament.date.toCalendar()
            def yearAgo = lastTournament.date.toCalendar()

            tournaments = tournaments.sort { a, b -> b.weight <=> a.weight }
            yearAgo.set(GregorianCalendar.YEAR, now.get(GregorianCalendar.YEAR) - 2)
            println "year ago is $yearAgo.time"
            tournaments.findAll { it.weightingType == WeightingType.AUTO }.each { Tournament t ->
                t.tournamentType = TournamentType.UNRANKED
            }
            tournaments.findAll { it.date.before(yearAgo.time) }.each { Tournament t ->
                t.tournamentType = TournamentType.UNRANKED
            }
            tournaments.removeAll {
                !it.ranked || !it.finished || it.weightingType == WeightingType.FIXED || it.date.before(yearAgo.time)
            }
            int end = applyType(tournaments, TournamentType.PREMIER_MANDATORY, 0, 5, 1)
            end = applyType(tournaments, TournamentType.PREMIER_5, end, 5, 1)
            end = applyType(tournaments, TournamentType.PREMIER_12, end, 12, 1)
            end = applyType(tournaments, TournamentType.INTERNATIONAL, end, 31, 1)
            end = applyType(tournaments, TournamentType.SERIES, end, 50, 1)
            end = applyType(tournaments, TournamentType.CIRCUIT, end, 400, 1)
            tournaments*.save(failOnError: true)
        }
        return tournaments.size()
    }

    /**
     * The player score is the sum of his best 12 tournaments
     */
    @NotTransactional
    Integer updatePlayerScores(Version game) {
        List players = Player.list()
        configurationService.withUniqueSession {
            players.eachWithIndex { Player p, Integer idx ->
                log.info("Evaluating for $game player $p, looking for results [${idx+1} / ${players.size()}]")
                def results = Result.findAllByPlayer(p)
                results = results.findAll {
                    it.tournament.game == game && it.tournament.finished
                }
                log.info("Found ${results.size()} results")
                def playerScore = getScore(results) { Result r ->
                    r.tournament.ranked ? ScoringSystem.getLegacyScore(r.place, r.tournament.weight, r.tournament.tournamentFormat) : 0
                }
                p.applyScore(game, playerScore)
                def actualScore = getScore(results) { Result r ->
                    r.tournament.ranked ? ScoringSystem.getScore(r.place, r.tournament.tournamentType, r.tournament.tournamentFormat) : 0
                }
                p.applyScore(game, actualScore)
                p.applyTotalScore(game, playerScore)
                // calculate CPT score
                if (game == Version.SF5) {
                    def cptScore = 0
                    def cptScoreAO = 0
                    def cptScoreLA = 0
                    def cptScoreNA = 0
                    def cptScoreEU = 0
                    def cptCount = 0
                    def prize = 0
                    results.each {
                        if (it.tournament.cptTournament && it.tournament.cptTournament != CptTournament.NONE && it.tournament.finished) {
                            def score = it.tournament.cptTournament.getScore(it.place)
                            cptScore += score
                            if (it.tournament.cptTournament == CptTournament.RANKING || it.tournament.cptTournament == CptTournament.ONLINE_EVENT) {
                                switch (it.tournament.region) {
                                    case Region.AO: cptScoreAO += score; break;
                                    case Region.LA: cptScoreLA += score; break;
                                    case Region.NA: cptScoreNA += score; break;
                                    case Region.EU: cptScoreEU += score; break;
                                }
                            }
                            cptCount++
                            def countryCode = it.tournament.countryCode
                            prize = prize + it.tournament.cptTournament.getPrize(it.place, countryCode)
                        }
                    }
                    if (cptScore) {
                        p.findOrCreateCptRanking(Region.GLOBAL).score = cptScore
                    }
                    else {
                        if (p.findCptRanking(Region.GLOBAL)) p.deleteCptRanking(Region.GLOBAL)
                    }
                    if (cptScoreAO) {
                        p.findOrCreateCptRanking(Region.AO).score = cptScoreAO
                    }
                    else {
                        if (p.findCptRanking(Region.AO)) p.deleteCptRanking(Region.AO)
                    }
                    if (cptScoreLA) {
                        p.findOrCreateCptRanking(Region.LA).score = cptScoreLA
                    }
                    else {
                        if (p.findCptRanking(Region.LA)) p.deleteCptRanking(Region.LA)
                    }
                    if (cptScoreNA) {
                        p.findOrCreateCptRanking(Region.NA).score = cptScoreNA
                    }
                    else {
                        if (p.findCptRanking(Region.NA)) p.deleteCptRanking(Region.NA)
                    }
                    if (cptScoreEU) {
                        p.findOrCreateCptRanking(Region.EU).score = cptScoreEU
                    }
                    else {
                        if (p.findCptRanking(Region.EU)) p.deleteCptRanking(Region.EU)
                    }
                    p.cptTournaments = cptCount
                    p.cptPrize = prize
                }
                p.save(failOnError: true)
                log.info("Saved player $p.name [${idx+1} / ${players.size()}]")
            }
            log.info "Updated ${players.size()} scores"
        }
        log.info("Flushing player score session...")
        Player.withSession { session -> session.flush() }
        log.info("Flushing player score session DONE")
        return players.size()
    }

    private Integer getScore(List<Result> results, Closure scoringRule) {
        def scores = results.collect {
            if (it.tournament.ranked && it.tournament.finished) {
                scoringRule(it)
            } else 0
        }.sort { a, b -> b <=> a }
        def bestof = scores.take(12)
        (bestof.sum() as Integer) ?: 0
    }

    /**
     * The player rank is based on how he positions by score
     * If a score is equal to another player the rank is not incremented but kept equal
     */
    @NotTransactional
    Integer updatePlayerRank(Version game) {
        List players = Player.findAll { results.tournament.game == game }
        players = players.sort { a, b -> b.score(game) <=> a.score(game) }
        configurationService.withUniqueSession {
            log.info("Found ${players.size()} to update rank")
            def previous = 0
            def currentRank = 0
            players.eachWithIndex { Player p, Integer idx ->
                if (p.score(game) != previous) {
                    currentRank = idx + 1
                }
                def rank = currentRank
                p.applyRank(game, rank)
                previous = p.score(game)
                log.info("Updated rank of player $p, setting previous as $previous [${idx+1} / ${players.size()}]")
            }
        }
        if (game == Version.SF5) {
            players = players.sort { Player a, Player b -> b.cptScore() <=> a.cptScore() }
            configurationService.withUniqueSession {
                log.info("Found ${players.size()} to update CPT rank")
                def previous = 0
                def currentRank = 0
                players.eachWithIndex { Player p, Integer idx ->
                    if (p.cptScore() != previous) {
                        currentRank = idx + 1
                    }
                    def rank = currentRank
                    p.findOrCreateCptRanking(Region.GLOBAL).rank = rank
                    previous = p.cptScore()
                    log.info("Updated CPT rank of player $p, setting previous as $previous [${idx+1} / ${players.size()}]")
                }
            }

            Region.locals().each { region ->
                players = players.sort { Player a, Player b -> b.cptScore(region) <=> a.cptScore(region) }
                configurationService.withUniqueSession {
                    log.info("Found ${players.size()} to update CPT $region rank")
                    def previous = 0
                    def currentRank = 0
                    players.eachWithIndex { Player p, Integer idx ->
                        if (p.cptScore(region)) {
                            if (p.cptScore(region) != previous) {
                                currentRank = idx + 1
                            }
                            def rank = currentRank
                            p.findOrCreateCptRanking(region).rank = rank
                            previous = p.cptScore(region)
                            log.info("Updated CPT rank of player $p, setting previous as $previous")
                        } else {
                            p.deleteCptRanking(region)
                        }
                    }
                }
            }
        }
        log.info("Flushing player score session...")
        Player.withSession { session -> session.flush() }
        log.info("Flushing player score session DONE")
        return players.size()
    }

    /**
     */
    @NotTransactional
    Integer updateMainTeams(Version game) {
        List players = Player.findAll {
            results.tournament.game == game
        }.sort { a, b -> b.score(game) <=> a.score(game) }
        configurationService.withUniqueSession {
            log.info("Found ${players.size()} to update main")
            players.eachWithIndex { Player p, Integer idx ->
                PlayerRanking ranking = p.rankings.find { it.game == game }
                if (ranking) {
                    ranking.mainCharacters.clear()
                    def filteredResults = p.results.findAll { it.tournament.game == game }
                    def last5 = filteredResults.sort { it.tournament.date }.reverse().take(5)
                    def teams = last5.collect { Result r -> r.characterTeams.collect { it } }.flatten()
                    teams.removeAll { it.hasUnknown() }
                    def countedGroup = teams.countBy { GameTeam team -> team }
                    def sortedGroup = countedGroup.sort { a, b -> b.value <=> a.value }
                    if (sortedGroup) {
                        def main = sortedGroup.keySet().first()
                        log.info "applying main team $main [${idx+1} / ${players.size()}]"
                        main.pchars.each { GameCharacter gameCharacter ->
                            ranking.mainCharacters.add(gameCharacter.characterType)
                        }
                    } else {
                        log.info "applying unknown main team to ${p.name}"
                        ranking.mainCharacters.add(CharacterType.UNKNOWN)
                    }
                    ranking.save(failOnError: true)
                }
                p.save(failOnError: true)

            }
        }
        log.info("Flushing player score session...")
        Player.withSession { session -> session.flush() }
        log.info("Flushing player score session DONE")
        return players.size()
    }

    @NotTransactional
    Integer updateMainGames() {
        configurationService.withUniqueSession {
            def players = Player.list()
            players.each { Player player ->
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
                def sorted = results.sort { a, b -> b[1] <=> a[1] }
                if (sorted) {
                    def main = sorted.first()[0]
                    log.info "Main game is $main"
                    player.mainGame = main
                }
                def rankingsToDelete = player.rankings.findAll { it.score == 0 && it.totalScore == 0 }.collect {
                    it.game
                }
                rankingsToDelete.each {
                    player.deleteRanking(it)
                }
                player.save(flush: true)
            }
            log.info("Flushing player score session...")
            Player.withSession { session -> session.flush() }
            log.info("Flushing player score session DONE")
        }
        return Player.count

    }

    private int applyType(List tournaments, TournamentType type, int start, int amount, double factor) {
        int factoredAmount = (int) (amount * factor)
        log.info "Applying type $type to $amount tournaments from $start with factor $factor"
        log.info "Translated to type $type times $factoredAmount tournaments from $start"
        if (start > tournaments.size() - 1) return tournaments.size()
        def endIndex = Math.min(start + factoredAmount - 1, tournaments.size() - 1)
        tournaments[start..endIndex]*.tournamentType = type
        log.info "Applied type $type"
        return start + factoredAmount;
    }


    private List playerScoresAt(Date date) {
        List playerScores = []
        List players = Player.list(readOnly: true)
        players.each { Player p ->
            def results = Result.findAllByPlayer(p, [readOnly: true])
            def scores = results.collect {
                if (it.tournament.ranked && it.tournament.date.before(date)) {
                    ScoringSystem.getScore(it.place, it.tournament.tournamentType, it.tournament.tournamentFormat)
                } else 0
            }.sort { a, b -> b <=> a }
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
            if (p.score != previous) {
                currentRank = idx + 1
            }
            p.rank = currentRank
            previous = p.score
        }
        return sortedPlayers
    }

    @Transactional
    public void updateProTour(Version game) {
        if (game == Version.SF5) {
            def extraspots = countDuplicateQualifiers()
            def totalPointSpots = 8 + extraspots
            def players = queryService.findCptPlayers(Region.GLOBAL)
            log.info "returning ${players.size()} players for CPT game $game"
            def playersNA = queryService.findCptPlayers(Region.NA)
            def playersLA = queryService.findCptPlayers(Region.LA)
            def playersAO = queryService.findCptPlayers(Region.AO)
            def playersEU = queryService.findCptPlayers(Region.EU)
            applyDirectQualifiers()
            applyQualifiedByScore(players, totalPointSpots)
            applyTwoRegionalInvites(Region.NA, playersNA)
            applyTwoRegionalInvites(Region.LA, playersLA)
            applyTwoRegionalInvites(Region.AO, playersAO)
            applyTwoRegionalInvites(Region.EU, playersEU)
        }
    }

    private void applyDirectQualifiers() {
        def pastTournaments = queryService.pastCptTournaments()
        Map<Region, List<Player>> regionalQualifyingHistories = [:]
        Region.values().each { regionalQualifyingHistories[it] = [] }
        pastTournaments.sort { it.date }.each { updateDirectQualifiedPlayer(it, regionalQualifyingHistories) }
    }

    private void updateDirectQualifiedPlayer(Tournament t, Map<Region, List<Player>> regionalQualifyingHistories) {
        log.info("... CPT stats on tournament ${t.name} with state ${t.finished} and results ${t.results.size()}")
        if (t.cptTournament in [CptTournament.PREMIER_SCORELESS, CptTournament.PREMIER, CptTournament.EVO, CptTournament.REGIONAL_FINAL]) {
            def firstPlayer = t.results?.sort { it.place }?.first()?.player?.findOrCreateCptRanking(Region.GLOBAL)
            if (firstPlayer) firstPlayer.qualified = true
        } else if (t.cptTournament == CptTournament.RANKING || t.cptTournament == CptTournament.ONLINE_EVENT) {
            Player qp = t.results.sort { it.place }.findResult {
                if (!regionalQualifyingHistories[t.region].contains(it.player)) {
                    regionalQualifyingHistories[t.region] << it.player
                    return it.player
                } else return null
            }
            if (qp) {
                qp.findOrCreateCptRanking(t.region).qualified = true
            }
        }
    }

    private List<Player> applyQualifiedByScore(List<Player> players, Integer spots) {
        players.each {
            if (it.findCptRanking(Region.GLOBAL)) {
                it.findCptRanking(Region.GLOBAL).qualifiedByScore = false // reset
            }
        }
        return players.findAll { !it.cptGlobal()?.qualified }.take(spots).collect {
            it.findOrCreateCptRanking(Region.GLOBAL).qualifiedByScore = true
            return it
        }
    }

    private void applyTwoRegionalInvites(Region region, List<Player> regionalPlayers) {
        regionalPlayers.each {
            if (it.findCptRanking(region)) {
                it.findCptRanking(region).qualifiedByScore = false // reset
            }
        }
        def unqualifiedPlayers = regionalPlayers.findAll { p ->
            return !p.cptGlobal()?.qualified && !p.cptGlobal()?.qualifiedByScore
        }
        unqualifiedPlayers.take(2).each {
            it.findOrCreateCptRanking(region).qualifiedByScore = true
        }
    }

    public Integer countDuplicateQualifiers() {
        def allWinners = queryService.getQualifiedSpotWinners().collect { it.name }
        def dups = allWinners.countBy { it }
        return dups.values().sum() - dups.keySet().size()
    }

    private List<Player> findAllRegionalQualifyingByScore(List<Player> globalQualifyingByScore) {
        def regions = [Region.AO, Region.EU, Region.LA, Region.NA]
        def qualifiedRegionally = []
        regions.each { region ->
            def regionalPlayers = queryService.findCptPlayers(region)
            def unqualifiedPlayersRegional = regionalPlayers.findAll { p ->
                return !globalQualifyingByScore.any { it.name == p.name } && !p.cptGlobal()?.qualified
            }
            qualifiedRegionally.addAll(unqualifiedPlayersRegional.take(2))
        }
        return qualifiedRegionally
    }

}
