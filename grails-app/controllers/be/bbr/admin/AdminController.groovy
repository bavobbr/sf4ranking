package be.bbr.admin

import be.bbr.sf4ranking.CharacterType
import be.bbr.sf4ranking.CleanupService
import be.bbr.sf4ranking.CountryCode
import be.bbr.sf4ranking.DataService
import be.bbr.sf4ranking.Player
import be.bbr.sf4ranking.RankingService
import be.bbr.sf4ranking.Tournament
import be.bbr.sf4ranking.TournamentFormat
import be.bbr.sf4ranking.TournamentType
import be.bbr.sf4ranking.Version
import be.bbr.sf4ranking.WeightingType
import grails.converters.JSON

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

    def index() {}

    /**
     * Update methods that need to be triggered after entering data
     */
    def updateAll() {
        initializeTournamentWeights()
        updateTournamentTypes()
        updatePlayerScores()
        updatePlayerRank()
        flash.message = "Updated weight, type of tournament and score, rank of all players"
        render view: "index"
    }

    def initializeTournamentWeights()
    {
        def sum = Version.values().inject(0) { result, game ->
            result + rankingService.updateWeights(game)
        }
        flash.message = "Updated weight of $sum tournaments"
        render view: "index"
    }

    def updateTournamentTypes()
    {
        def sum = Version.values().inject(0) { result, game ->
            result + rankingService.updateTypes(game)
        }
        flash.message = "Updated type of $sum tournaments"
        render view: "index"
    }

    def updatePlayerScores()
    {
        def sum = Version.values().inject(0) { result, game ->
            result + rankingService.updatePlayerScores(game)
        }
        flash.message = "Updated score of $sum players"
        render view: "index"
    }

    def updatePlayerRank()
    {
        def sum = Version.values().inject(0) { result, game ->
            result + rankingService.updatePlayerRank(game)
        }
        flash.message = "Updated rank of $sum players"
        render view: "index"
    }

    /**
     * Manual data import and manipulation
     */
    def importer()
    {
        def index = 1
        def example = CharacterType.values().inject("") { a, b -> a+"player at place ${index++} / $b\n"}
        render view: "importer", model: [hint: example]
    }

    def importTournament()
    {
        String tname = params.tname
        Date tdate = new Date(params.tdate_year.toInteger()-1900, params.tdate_month.toInteger(), params.tdate_day.toInteger())
        TournamentFormat tformat = TournamentFormat.fromString(params.tformat)
        TournamentType ttype = TournamentType.fromString(params.ttype)
        WeightingType tweight = WeightingType.fromString(params.tweight)
        CountryCode tcountry = CountryCode.fromString(params.tcountry)
        Version tgame = Version.fromString(params.tgame)
        String results = params.tresults
        List tvideos = params.tvideos.tokenize(" ")
        Boolean tranked = params.tranked?.toBoolean()?: true
        def t = dataService.importTournament(tname, results, tdate, tformat, tcountry, tgame, tvideos, tweight, ttype, tranked)
        redirect(controller: "rankings", action: "tournament", params: [id: t.id])
    }

    def importServerSideData()
    {
        String status = dataService.importFileData()
        flash.message = status
        render view: "index"
    }

    def merge()
    {
        [players: Player.list(order: "asc", sort: 'name')]
    }

    def mergePlayers()
    {
        def p1 = Player.findById(params.p1)
        def p2 = Player.findById(params.p2)
        dataService.merge(p1, p2)
        redirect(controller: "rankings", action: "player", params: [id: p2.id])
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

    def selectTournamentVideos() {
        [tournament : Tournament.findById(params.id)]
    }

    def selectPlayerVideos() {
        [player : Player.findById(params.id)]
    }

    def updateTournamentVideos() {
        def video = Tournament.findById(params.id)
        def videos = params.videos.tokenize(" ")
        video.videos = videos as Set
        redirect(controller: "rankings", action: "tournament", params: [id: params.id])
    }

    def updatePlayerVideos() {
        def video = Player.findById(params.id)
        def videos = params.videos.tokenize(" ")
        video.videos = videos as Set
        redirect(controller: "rankings", action: "player", params: [id: params.id])
    }

    /**
     * Maintenance methods
     */

    def fixTournamentFormats() {
        cleanupService.fixTournamentFormats()
        render view: "index"
    }

    def fixPlayerRankings() {
        cleanupService.fixPlayerRankings()
        render view: "index"
    }

    def fixTournamentUnrank() {
        cleanupService.fixTournamentUnrank()
        render view: "index"
    }

    def fixCodenames() {
        cleanupService.fixCodenames()
        render view: "index"
    }

    def dropUnrankedPlayers() {
        def num = cleanupService.dropUnrankedUsers()
        flash.message = "Dropped $num players"
        render view: "index"
    }

    def fixPlayerGameRankings() {
        cleanupService.fixPlayerGameRankings()
        render view: "index"
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
            players = Player.list().findAll { it.overallScore() <= 0 }
        }
        def listing = players.collect {it.name}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def printPlayerRanks()
    {
        List players = Player.list().sort { a, b -> b.score(AE2012) <=> a.score(AE2012)}
        def listing = players.collect { Player p -> "${p.rank(AE2012)}, ${p.name}, ${p.score(AE2012)}"}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def printTournamentSizes() {
        def tournamentSizes = [:]
        Tournament.list().each {
            def numresults = it.results.size()
            tournamentSizes[it] = numresults
        }
        def listing = tournamentSizes.collect { Tournament k, def v -> "${k.name}, $v, ${k.tournamentFormat}, ${k.tournamentType}, ${k.weightingType}, ${k.ranked}"}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }


    def deleteAll()
    {
        def confirmed = (params.confirm == "I do")
        if (confirmed)
        {
            dataService.deleteAll()
            render view: "index"
        }
        else {
            render view: "confirmDelete"
        }
    }

    def playerRanksBefore(Tournament tournament) {
        def playerRanks = rankingService.playerRanksAt(tournament.date)
        def listing = playerRanks.collect { p -> "${p.rank}, ${p.name}, ${p.score}"}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def playerRanksAfter(Tournament tournament) {
        def playerRanks = rankingService.playerRanksAt(tournament.date+1)
        def listing = playerRanks.collect { p -> "${p.rank}, ${p.name}, ${p.score}"}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def playerDiffForTournament(Tournament tournament) {
        def pids = tournament.results.collect { it.player.id }
        def playerRanks = rankingService.playerRanksAt(tournament.date)
        playerRanks.retainAll { it.id in pids }
        def playerRanksAfter = rankingService.playerRanksAt(tournament.date+1)
        playerRanksAfter.retainAll { it.id in pids }
        playerRanks.each { def pbefore ->
            def other = playerRanksAfter.find { it.id == pbefore.id }
            pbefore.rankAfter = other.rank
            pbefore.scoreAfter = other.score
            pbefore.scoreDiff = pbefore.scoreAfter - pbefore.score
            pbefore.rankDiff = pbefore.rank - pbefore.rankAfter
        }
        //def listing = playerRanks.collect { p -> "${p.name}, ${p.rank}, ${p.score}, ${p.rankAfter}, ${p.scoreAfter}"}.join("\r\n")
        [tournament: tournament, players: playerRanks]
    }

}
