package be.bbr.sf4ranking

import grails.transaction.Transactional

/**
 * This is mainly used to upgrade old data
 */
@Transactional
class CleanupService
{

    /**
     * Assumes that almost all tournaments are double-bracket except for some known tournaments
     * Should not be needed if tournaments are filled in correctly with format
     */
    def fixTournamentFormats()
    {
        Tournament.list().each {
            it.tournamentFormat = TournamentFormat.DOUBLE_BRACKET
            it.save()
            log.info "Setting $it.name as double"
        }
        Tournament.findAllByCodenameLike("%TOPANGA%").each {
            it.tournamentFormat = TournamentFormat.LEAGUE
            it.save()
            log.info "Setting $it.name as league"
        }
        Tournament.findAllByCodenameLike("%CAPCOM CUP TGS%").each {
            it.tournamentFormat = TournamentFormat.SINGLE_BRACKET
            it.save()
            log.info "Setting $it.name as single"
        }
    }

    /**
     * Assumes that almost all tournaments are double-bracket except for some known tournaments
     * Should not be needed if tournaments are filled in correctly with format
     */
    def fixLocalTournaments()
    {
        Tournament.list().each {
            if (it.weightingType == WeightingType.FIXED) {
                if (it.tournamentType == TournamentType.CIRCUIT) {
                    println "Setting as local: $it.name"
                    it.tournamentType = TournamentType.LOCAL
                    it.save()
                }
            }
        }
    }

    /**
     * Fixes rank in tournaments for players on equal spots
     * Should not be needed if tournaments are entered with correct format
     */
    def fixPlayerRankings()
    {
        Tournament.list().each {Tournament t ->
            t.results.each {Result r ->
                r.place = ScoringSystem.getRank(r.place, t.tournamentFormat)
                r.save()
            }
            log.info "Fixed ranks of tournament $t"
            t.save()
        }
    }

    /**
     * Fixes ranked field in tournaments, currently AE only
     */
    def fixTournamentUnrank()
    {
        Tournament.findAllByGame(Version.AE2012).each {
            it.ranked = true
            log.info "setting $it as ranked"
        }
        Tournament.findAllByGameNotEqual(Version.AE2012).each {
            it.ranked = false
            log.info "setting $it as unranked"
        }
    }

    /**
     * Fixes codenames after name update
     */
    def fixCodenames()
    {
        Player.list().each {
            if (it.codename != it.name?.toUpperCase())
            {
                log.info "Fixing name of ${it.codename} to ${it.name}"
                it.codename = it.name?.toUpperCase()
            }
        }
        Tournament.list().each {
            if (it.codename != it.name?.toUpperCase())
            {
                log.info "Fixing tournament name of ${it.codename} to ${it.name}"
                it.codename = it.name?.toUpperCase()
            }
        }
    }

    def autoWeighAll()
    {
        log.info "Putting all non league/grandslams on AUTO"
        def tournaments = Tournament.list()
        def normalTypes = TournamentType.values() - TournamentType.GRAND_SLAM - TournamentType.CHAMPIONSHIP -
                          TournamentType.TOURNAMENT_CHAMPIONS - TournamentType.CIRCUIT - TournamentType.ROUND_ROBIN_GROUP_STAGE
        tournaments.each {
            if (it.tournamentType in normalTypes)
            {
                if (it.weightingType == WeightingType.FIXED)
                {
                    log.info "Unfixing ${it.name}"
                    it.weightingType = WeightingType.AUTO
                    it.save()
                }
            }
        }
    }


    def rankAll()
    {
        log.info "Marking all except exhibition tournaments as ranked"
        def tournaments = Tournament.list()
        tournaments.each {
            if (it.tournamentFormat != TournamentFormat.EXHIBITION)
            {
                if (!it.ranked || it.tournamentType == TournamentType.UNRANKED)
                {
                    log.info "Ranking ${it.name}"
                    it.ranked = true
                    it.weightingType = WeightingType.AUTO
                    it.save()
                }
            }
        }
    }

    /**
     * Does a first run in setting player skills. This is meant to be manually altered after depending on circmunstances
     * Eg how moes does he play and how many tournaments are reported from his region
     * The GOD status of skill 10 is always done manually
     */
    def autofillSkill(Version game)
    {
        List<PlayerRanking> rankings = PlayerRanking.findAllByGame(game)
        rankings.each {
            it.skill = 0 // RESET
            it.save()
        }
        def count = Math.min(rankings.size(), 750)
        if (count > 0)
        {
            double factor = count / 100
            log.info("Checking with alltime ranking")
            def byTotal = rankings.sort {a, b -> a.totalScore <=> b.totalScore}
            byTotal = byTotal.reverse().take(750).reverse()
            println byTotal*.player.name
            1.upto(99) {Integer skillLevel ->
                def lowerBound = Math.log(skillLevel) / Math.log(100)
                def upperBound = Math.log(skillLevel+1) / Math.log(100)
                log.info "Level $skillLevel has lowerBound $lowerBound and upperBound $upperBound"
                def intervalStart = lowerBound * factor * 100 as Integer
                def intervalEnd = upperBound * factor * 100 as Integer
                log.info "This is from range $intervalStart to $intervalEnd applied from $count rankings using factor $factor"
                byTotal[intervalStart..intervalEnd - 1].each {
                    def adjustedSkill = skillLevel
                    if (it.skill < adjustedSkill)
                    {
                        log.info "alltime - Promoting player ${it.player} with ${it.skill} to ${adjustedSkill}"
                        it.skill = adjustedSkill
                        it.save()
                    }
                    else if (it.skill > adjustedSkill)
                    {
                        log.info "alltime - Demoting player ${it.player} with ${it.skill} to ${adjustedSkill}"
                        it.skill = adjustedSkill
                        it.save()
                    }
                }

            }
            log.info("Checking with actual ranking")
            def byActual = rankings.sort {a, b -> a.score <=> b.score}
            byActual = byActual.reverse().take(750).reverse()
            println byActual*.player.name
            1.upto(99) {Integer skillLevel ->
                def lowerBound = Math.log(skillLevel) / Math.log(100)
                def upperBound = Math.log(skillLevel+1) / Math.log(100)
                log.info "Level $skillLevel has lowerBound $lowerBound and upperBound $upperBound"
                def intervalStart = lowerBound * factor * 100 as Integer
                def intervalEnd = upperBound * factor * 100 as Integer
                log.info "This is from range $intervalStart to $intervalEnd applied from $count rankings using factor $factor"
                byActual[intervalStart..intervalEnd - 1].each {
                    def adjustedSkill = skillLevel
                    if (it.skill < adjustedSkill)
                    {
                        log.info "actual - Promoting player for actual score ${it.player} with ${it.skill} to ${adjustedSkill}"
                        it.skill = adjustedSkill
                        it.save()
                    }
                    else if (it.skill == adjustedSkill)
                    {
                        log.info "actual - Leaving player ${it.player} with ${it.skill} as is"
                    }
                    else
                    {
                        log.info "Total skill was higher for player ${it.player} with ${it.skill}, not adjusting to ${adjustedSkill}"
                    }
                }
            }
        }
    }

    def findSkillDeviations(Version game)
    {
        List<PlayerRanking> rankings = PlayerRanking.findAllByGame(game)
        def output = ["DIFF FOR GAME $game"]
        rankings.sort {a, b -> a.totalScore <=> b.totalScore}
        def count = rankings.size()
        if (count > 0)
        {
            double factor = count / 100
            1.upto(99) {Integer skillLevel ->
                def lowerBound = Math.log10(skillLevel)
                def upperBound = Math.log10(skillLevel + 1)
                def intervalStart = lowerBound * factor * 100 as Integer
                def intervalEnd = upperBound * factor * 100 as Integer
                rankings[intervalStart..intervalEnd - 1].each {
                    def adjustedSkill = skillLevel
                    if (!(it.player.countryCode in [CountryCode.US, CountryCode.JP])) {
                        adjustedSkill++ // auto-compensate for lesser coverage
                    }
                    if (it.skill > adjustedSkill + 1)
                    {
                        log.info "Player ${it.player.name}  skill [${it.skill}] autoskill [${adjustedSkill}]"
                        output << "Player ${it.player.name}  skill [${it.skill}] autoskill [${adjustedSkill}]"
                    }
                }
            }
        }
        return output
    }

    /**
     * Use the IGAU/MKX skill as default if the player is ranked for a version but has no skill set for that version
     * @return
     */
    def mergeSkills()
    {
        Player.list().each {Player p ->
            if (p.hasRanking(Version.MKX) && p.skill(Version.MKX) > 0)
            {
                def skill = p.skill(Version.MKX)
                if (p.hasRanking(Version.INJUSTICE2) && p.skill(Version.INJUSTICE2) < skill)
                {
                    p.applySkill(Version.INJUSTICE2, skill)
                }
            }
            if (p.hasRanking(Version.IGAU) && p.skill(Version.IGAU) > 0)
            {
                def skill = p.skill(Version.IGAU)
                if (p.hasRanking(Version.INJUSTICE2) && p.skill(Version.INJUSTICE2) < skill)
                {
                    p.applySkill(Version.INJUSTICE2, skill)
                }
            }
        }
    }

    /**
     * Drops ghost users that are not ranked anywhere
     */
    def dropUnrankedPlayers()
    {
        def players = Player.withCriteria {isEmpty("results")}
        players.each {log.info "dropping player $it"}
        return players.size()
    }

    def dropDeadRanks()
    {
        def rankings = PlayerRanking.list()
        rankings.each {
            if (it.score == 0 && it.totalScore == 0) {
                it.delete()
            }
        }
    }



    def rollupEvents() {
        def tournaments = Tournament.list()
        log.info("Checking out ${tournaments.size()} tournaments")
        def grouped = tournaments.groupBy {
            if (it.name.contains("-")) {
                def last = it.name.tokenize("-").last()
                return (it.name - "-$last").trim()
            } else return it.name.trim()

        }
        def sorted = grouped.sort { it.value.size() }
        def findOrCreateEvent = { String name ->
            def event = Event.findByCodename(name.toUpperCase())
            if (!event) {
                event = new Event(name: name)
                event.weight = 0
            }
            return event
        }
        sorted.each { k, v ->
            //println "$k: $v.game"
            if (v.size() > 1) {
                Event event = findOrCreateEvent(k)
                v.each { t ->
                    if (!event.tournaments.find { it.name == t.name}) {
                        println "added $t.name to event $event.name"
                        event.addToTournaments(t)
                        event.date = t.date
                        event.countryCode = t.countryCode
                        event.weight += t.weight
                        if (t.game == Version.SF5) event.region = t.region
                        event.save(failOnError: true)
                    }
                }
            }
        }
        log.info("Done rolling up ${tournaments.size()} tournaments into ${sorted.size()} events")
    }
}
