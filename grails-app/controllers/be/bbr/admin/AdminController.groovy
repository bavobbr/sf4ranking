package be.bbr.admin

import be.bbr.sf4ranking.*
import grails.converters.JSON
import org.apache.shiro.SecurityUtils

import static be.bbr.sf4ranking.Version.AE2012

/**
 * Controller for data manipulation
 * Allows to import/export static data, import new tournaments, update rankings, scores and weights
 * do cleanup on data and print some useful information for debugging
 */
class AdminController
{

    RankingService rankingService
    DataService dataService
    CleanupService cleanupService
    QueryService queryService

    def index() {}

    /**
     * Update methods that need to be triggered after entering data
     */
    def updateAll()
    {
        if (SecurityUtils.subject.hasRole("Administrator"))
        {
            def game = Version.fromString(params.game)
            rankingService.updateWeights(game)
            rankingService.updateTypes(game)
            rankingService.updatePlayerScores(game)
            rankingService.updatePlayerRank(game)
            rankingService.updateMainTeams(game)
            flash.message = "Updated weight, type of tournament and score, rank of all players in $game"
        }
        render view: "index"
    }

    def initializeTournamentWeights()
    {
        def sum = Version.values().inject(0) {result, game ->
            result + rankingService.updateWeights(game)
        }
        flash.message = "Updated weight of $sum tournaments"
        render view: "index"
    }

    def updateTournamentTypes()
    {
        def sum = Version.values().inject(0) {result, game ->
            result + rankingService.updateTypes(game)
        }
        flash.message = "Updated type of $sum tournaments"
        render view: "index"
    }

    def updatePlayerScores()
    {
        def sum = Version.values().inject(0) {result, game ->
            result + rankingService.updatePlayerScores(game)
        }
        flash.message = "Updated score of $sum players"
        render view: "index"
    }

    def updatePlayerRank()
    {
        def sum = Version.values().inject(0) {result, game ->
            result + rankingService.updatePlayerRank(game)
        }
        flash.message = "Updated rank of $sum players"
        render view: "index"
    }

    def updateMainCharacters()
    {
        def sum = Version.values().inject(0) {result, game ->
            result + rankingService.updateMainTeams(game)
        }
        flash.message = "Updated char of $sum players"
        render view: "index"
    }

    def updateMainGames()
    {
        def sum = rankingService.updateMainGames()
        flash.message = "Updated main game of $sum players"
        render view: "index"
    }

    /**
     * Manual data import and manipulation
     */
    def importer()
    {
        def source = params.source
        def suggestedName
        def suggestedDate
        def suggestedSource
        def suggestedCountry
        if (source) {
            log.info "Importer called from tournament id ${source}"
            Tournament base = Tournament.get(source)
            suggestedSource = base.coverage
            suggestedDate = base.date
            suggestedCountry =  base.countryCode
            suggestedName = base.name.split("-")?.first()?.trim()
        }
        def example = "player1 (char1/char2,char1/char3)\nplayer2 (char1,char2)\nplayer3 (char1/char2)\nplayer4"
        return [hint: example, suggestedName: suggestedName, suggestedDate: suggestedDate, suggestedSource: suggestedSource, suggestedCountry: suggestedCountry]
    }

    def importTournament()
    {
        String tname = params.tname
        Date tdate = new Date(params.tdate_year.toInteger() - 1900, params.tdate_month.toInteger()-1, params.tdate_day.toInteger())
        TournamentFormat tformat = TournamentFormat.fromString(params.tformat)
        TournamentType ttype = TournamentType.fromString(params.ttype)
        WeightingType tweight = WeightingType.fromString(params.tweight)
        CountryCode tcountry = CountryCode.fromString(params.tcountry)
        Version tgame = Version.fromString(params.tgame)
        String results = params.tresults
        String coverage = params.tcoverage
        List tvideos = params.tvideos.tokenize(" ")
        Boolean tranked = params.tranked?.toBoolean() ?: true
        if (!tname || !tdate || !ttype || !tweight || !tgame || !results || tgame == Version.UNKNOWN) {
            flash.message = "Name, date, tournament type, weighting type, results and game are mandatory"
            render view: "importer"
            return
        }
        def t = dataService.importTournament(tname, results, tdate, tformat, tcountry, tgame, tvideos, tweight, ttype, tranked, coverage)
        redirect(controller: "rankings", action: "tournament", params: [id: t.id])
    }

    def validateResults()
    {
        def content = params.content
        def type = params.type
        def game = Version.fromString(params.game)
        List<String> feedback = dataService.validateResults(content, game, type)
        log.info "rendering $feedback"
        render(contentType: "text/html") {
            div {
                feedback.each {
                    p(it)
                }
            }
        }
        log.info "rendered $feedback"
    }

    def renderCharacterNames() {
        def game = Version.fromString(params.game);
        def names = CharacterType.values().findAll { it.game == Version.generalize(game) }
        log.info "rendering $game"
        render(contentType: "text/html") {
            ul {
                names.each {
                    li("${it.name()} / ${it.getValue()} / ${it.getShortname()}")
                }
            }
        }
        log.info "rendered $game"
    }

    def importServerSideData()
    {
        if (SecurityUtils.subject.hasRole("Administrator"))
        {
            String status = dataService.importFileData()
            flash.message = status
        }
        log.info "Import ready, returning to index"
        render view: "index"
    }

    def merge()
    {
        [players: Player.list(order: "asc", sort: 'name')]
    }

    def split(Player p)
    {
        def results = p.results.inject([]) {def list, Result value ->
            def display = "${value.tournament.game.name()} - ${value.tournament.name} - ${value.characterTeams}"
            list << [id: value.id, display: display]
        }
        [players: Player.list(order: "asc", sort: 'name'), player: p, results: results]
    }

    def mergePlayers()
    {
        def p1 = Player.findById(params.p1)
        def p2 = Player.findById(params.p2)
        dataService.merge(p1, p2)
        redirect(controller: "rankings", action: "player", params: [id: p2.id])
    }

    def mergeSkills()
    {
        cleanupService.mergeSkills()
        redirect(controller: "admin", action: "index")
    }


    def splitPlayers()
    {
        def toPlayer = new Player(name: params.to)
        def fromPlayer = Player.findById(params.from)
        log.info "Asked to split off ${fromPlayer.name} into ${toPlayer.name} with results ${params.results}"
        for (id in params.list('results'))
        {
            Result r = Result.findById(id)
            fromPlayer.removeFromResults(r)
            toPlayer.addToResults(r)
            r.save(failOnError: true)
        }
        toPlayer.save(failOnError: true)
        fromPlayer.save(failOnError: true)
        redirect(controller: "rankings", action: "player", params: [id: toPlayer.id])
    }

    /**
     * backup
     */

    def exportTournaments()
    {
        def tournaments = dataService.exportTournaments()
        render(tournaments as JSON)
    }

    def exportPlayers()
    {
        def players = dataService.exportPlayers()
        render(players as JSON)
    }

    def exportTeams()
    {
        def teams = dataService.exportTeams()
        render(teams as JSON)
    }

    /**
     * Quick editing of certain properties that are not editable in scaffold
     */

    def selectTournamentVideos()
    {
        [tournament: Tournament.findById(params.id)]
    }

    def selectPlayerVideos()
    {
        [player: Player.findById(params.id)]
    }

    def replaceResults(Tournament tournament) {
        StringBuffer buffer = new StringBuffer()
        tournament.results.sort { a,b -> a.place <=> b.place}.each {
            def chars = it.characterTeams.collect { it.pchars.collect { it.characterType?.value }.join("/")}.join(",")
            buffer.append "${it.player.name} ($chars)\n"
        }
        [results: buffer.toString(), tournament: tournament]
    }

    def updateTournamentResults()
    {
        def tournament = Tournament.findById(params.id)
        log.info "Update results of tournament ${tournament.name} with ${params.results}"
        def oldrresults = []
        oldrresults.addAll(tournament.results)
        oldrresults.each {
            tournament.removeFromResults(it)
            log.info "deleting result $it"
            it.delete(flush: true)
        }
        tournament.save(flush: true, failOnError: true)
        log.info "Deleted old results, adding new ones..."
        dataService.addResultsToTournament(params.results, tournament)
        redirect(controller: "rankings", action: "tournament", params: [id: params.id])
    }

    def updateTournamentVideos()
    {
        def video = Tournament.findById(params.id)
        def videos = params.videos.tokenize(" ")
        video.videos = videos as Set
        redirect(controller: "rankings", action: "tournament", params: [id: params.id])
    }

    def updatePlayerVideos()
    {
        def video = Player.findById(params.id)
        def videos = params.videos.tokenize(" ")
        video.videos = videos as Set
        redirect(controller: "rankings", action: "player", params: [id: params.id])
    }

    /**
     * Maintenance methods
     */

    def fixTournamentFormats()
    {
        if (SecurityUtils.subject.hasRole("Administrator"))
        {
            cleanupService.fixTournamentFormats()
        }
        render view: "index"
    }

    def fixPlayerRankings()
    {
        if (SecurityUtils.subject.hasRole("Administrator"))
        {
            cleanupService.fixPlayerRankings()
        }
        render view: "index"
    }

/*    def fixDates() {
        if (SecurityUtils.subject.hasRole("Administrator"))
        {
            cleanupService.notchDates()
        }
        render view: "index"
    }*/

    def fixTournamentUnrank()
    {
        if (SecurityUtils.subject.hasRole("Administrator"))
        {

            cleanupService.fixTournamentUnrank()
        }
        render view: "index"
    }

    def fixCodenames()
    {
        if (SecurityUtils.subject.hasRole("Administrator"))
        {
            cleanupService.fixCodenames()
        }
        render view: "index"
    }

    def removeFromTeam() {
        Player p = Player.get(params.pid)
        Team t = Team.get(params.tid)
        log.info("Removing $t from $p")
        p.removeFromTeams(t)
        p.save()
        log.info("Player $p is now in teams ${p.teams}")
        redirect controller: "rankings", action: "team", params: [id:t.id]
    }


    def printPlayers()
    {
        List players = []
        if (params.ranked == "true")
        {
            log.info("Looking for all player")
            players = Player.list()
        }
        else
        {
            log.info("Looking for unranked player")
            players = Player.list().findAll {it.overallScore() <= 0}
        }
        def listing = players.collect {it.name}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def printPlayerRanks()
    {
        List players = Player.list().sort {a, b -> b.overallScore() <=> a.overallScore()}
        def listing = players.collect {Player p -> "${p.rankings.size()}, ${p.name}, ${p.overallScore()}"}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def printTournamentSizes()
    {
        def tournamentSizes = [:]
        Tournament.list().each {
            def numresults = it.results.size()
            tournamentSizes[it] = numresults
        }
        def listing = tournamentSizes.collect {
            Tournament k, def v -> "${k.name}, $v, ${k.tournamentFormat}, ${k.tournamentType}, ${k.weightingType}, ${k.ranked}"
        }.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def listOrphanedPlayers() {
        def players = queryService.findOrphanedPlayers()
        [players: players]
    }

    def listAlikes() {
        def players = Player.list()
        def map = [:]
        players.each { Player p ->
            log.info "Finding matches for ${p.name}"
            def alts = dataService.findAlikes(p.name)
            alts.removeAll { it.name == p.name }
            if (alts && alts.size() >= 1) map[p] = alts
            log.info "Counting results for ${p.name}"
            def countResults = Result.countByPlayer(p)
            p.metaClass.countResults << { countResults }
            log.info "Counted $countResults"
        }
        def sortedMap = map.sort { k1, k2 -> k2.key.countResults() <=> k1.key.countResults() }
        def first10 = sortedMap.take(10)
        log.info "first 10 is $first10"
        [players: sortedMap]
    }


    def deleteAll()
    {
        def confirmed = (params.confirm == "I do")
        if (confirmed && SecurityUtils.subject.hasRole("Administrator"))
        {
            dataService.deleteAll()
            render view: "index"
        }
        else
        {
            render view: "confirmDelete"
        }
    }

    def snapshot()
    {
        if (SecurityUtils.subject.hasRole("Administrator"))
        {
            def game = Version.fromString(params.game) ?: Version.UNKNOWN
            def count = dataService.takeSnapshot(game)
            flash.message = "Took snapshot of $count games"
        }
        render view: "index"
    }

    def playerRanksBefore(Tournament tournament)
    {
        def playerRanks = rankingService.playerRanksAt(tournament.date)
        def listing = playerRanks.collect {p -> "${p.rank}, ${p.name}, ${p.score}"}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def playerRanksAfter(Tournament tournament)
    {
        def playerRanks = rankingService.playerRanksAt(tournament.date + 1)
        def listing = playerRanks.collect {p -> "${p.rank}, ${p.name}, ${p.score}"}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def playerDiffForTournament(Tournament tournament)
    {
        def pids = tournament.results.collect {it.player.id}
        def playerRanks = rankingService.playerRanksAt(tournament.date)
        playerRanks.retainAll {it.id in pids}
        def playerRanksAfter = rankingService.playerRanksAt(tournament.date + 1)
        playerRanksAfter.retainAll {it.id in pids}
        playerRanks.each {def pbefore ->
            def other = playerRanksAfter.find {it.id == pbefore.id}
            pbefore.rankAfter = other.rank
            pbefore.scoreAfter = other.score
            pbefore.scoreDiff = pbefore.scoreAfter - pbefore.score
            pbefore.rankDiff = pbefore.rank - pbefore.rankAfter
        }
        //def listing = playerRanks.collect { p -> "${p.name}, ${p.rank}, ${p.score}, ${p.rankAfter}, ${p.scoreAfter}"}.join("\r\n")
        [tournament: tournament, players: playerRanks]
    }

}
