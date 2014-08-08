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
                          TournamentType.TOURNAMENT_CHAMPIONS
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

    def autofillSkill(Version game)
    {
        List<PlayerRanking> rankings = PlayerRanking.findAllByGame(game)
        rankings.sort {a, b -> a.score <=> b.score}
        def count = rankings.size()
        if (count > 0)
        {
            double factor = count / 100
            1.upto(9) {Integer skillLevel ->
                def lowerBound = Math.log10(skillLevel)
                def upperBound = Math.log10(skillLevel + 1)
                log.info "Level $skillLevel has lowerBound $lowerBound and upperBound $upperBound"
                def intervalStart = lowerBound * factor * 100 as Integer
                def intervalEnd = upperBound * factor * 100 as Integer
                log.info "This is from range $intervalStart to $intervalEnd applied from $count rankings using factor $factor"
                rankings[intervalStart..intervalEnd - 1].each {
                    if (it.skill < skillLevel)
                    {
                        log.info "Applying skill $skillLevel to ${it.player}"
                        it.skill = skillLevel
                        it.save()
                    }
                    else if (it.skill == skillLevel)
                    {
                        //log.info "Player ${it.player} has a higher skill level of ${it.skill}"
                    }
                    else
                    {
                        log.info "Player ${it.player} has a higher skill level of ${it.skill}"
                    }
                }
            }
        }
    }

    def findSkillDeviations(Version game)
    {
        List<PlayerRanking> rankings = PlayerRanking.findAllByGame(game)
        def output = ["DIFF FOR GAME $game"]
        rankings.sort {a, b -> a.score <=> b.score}
        def count = rankings.size()
        if (count > 0)
        {
            double factor = count / 100
            1.upto(9) {Integer skillLevel ->
                def lowerBound = Math.log10(skillLevel)
                def upperBound = Math.log10(skillLevel + 1)
                def intervalStart = lowerBound * factor * 100 as Integer
                def intervalEnd = upperBound * factor * 100 as Integer
                rankings[intervalStart..intervalEnd - 1].each {
                    if (it.skill > skillLevel + 1)
                    {
                        log.info "Player ${it.player.name}  skill [${it.skill}] autoskill [${skillLevel}]"
                        output << "Player ${it.player.name}  skill [${it.skill}] autoskill [${skillLevel}]"
                    }
                }
            }
        }
        return output
    }

    /**
     * Use the AE2012 skill as default if the player is ranked for a version but has no skill set for that version
     * @return
     */
    def mergeSkills()
    {
        Player.list().each {Player p ->
            if (p.hasRanking(Version.AE2012) && p.skill(Version.AE2012) > 0)
            {
                def skill = p.skill(Version.AE2012);
                if (p.hasRanking(Version.USF4) && p.skill(Version.USF4) == 0)
                {
                    p.applySkill(Version.USF4, skill)
                }
                if (p.hasRanking(Version.AE) && p.skill(Version.AE) == 0)
                {
                    p.applySkill(Version.AE, skill)
                }
                if (p.hasRanking(Version.SUPER) && p.skill(Version.SUPER) == 0)
                {
                    p.applySkill(Version.SUPER, skill)
                }
                if (p.hasRanking(Version.VANILLA) && p.skill(Version.VANILLA) == 0)
                {
                    p.applySkill(Version.VANILLA, skill)
                }
                if (p.hasRanking(Version.USF4) && p.skill(Version.USF4) == 0)
                {
                    p.applySkill(Version.USF4, skill)
                }
            }
            else if (p.hasRanking(Version.AE2012) && p.skill(Version.AE2012) == 0) {
                if (p.hasRanking(Version.USF4) && p.skill(Version.USF4) > 0)
                {
                    def skill = p.skill(Version.USF4)
                    log.info "Merging USF4 skill to AE2012 for $p"
                    p.applySkill(Version.AE2012, skill)
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

/*    def notchDates() {
        def tournaments = Tournament.where {
            id >= 94
        }
        tournaments.each {
            log.info "need to fix tournament ${it.name} at ${it.date}"
            def date = it.date
            Calendar cal = date.toCalendar()
            def oldMonth = cal.get(Calendar.MONTH)
            cal.set(Calendar.MONTH, oldMonth-1)
            def newdate = cal.getTime()
            log.info "new date would be $newdate"
            it.date = newdate
            it.save()
        }
    }*/

}
