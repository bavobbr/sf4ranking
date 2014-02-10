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

class AdminController
{

    RankingService rankingService
    DataService dataService
    CleanupService cleanupService

    def index() {}

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
        def num = rankingService.updateWeights()
        flash.message = "Updated weight of $num tournaments"
        render view: "index"
    }

    def updateTournamentTypes()
    {
        def num = rankingService.updateTypes()
        flash.message = "Updated type of $num tournaments"
        render view: "index"
    }

    def updatePlayerScores()
    {
        def num = rankingService.updatePlayerScore()
        flash.message = "Updated score of $num players"
        render view: "index"
    }

    def updatePlayerRank()
    {
        def num = rankingService.updatePlayerRank()
        flash.message = "Updated rank of $num players"
        render view: "index"
    }

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
        def t = dataService.importTournament(tname, results, tdate, tformat, tcountry, tgame, tvideos, tweight, ttype)
        redirect(controller: "rankings", action: "tournament", params: [id: t.id])
    }

    def importFileData()
    {
        String status = dataService.importFileData()
        flash.message = status
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
            players = Player.findAllBySkillLessThanEquals(0)
        }
        def listing = players.collect {it.name}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
    }

    def printTournamentSizes() {
        def tournamentSizes = [:]
        Tournament.list().each {
            def numresults = it.results.size()
            tournamentSizes[it] = numresults
        }
        def listing = tournamentSizes.collect { Tournament k, def v -> "[${k.name}] $v ${k.tournamentFormat} ${k.weightingType}"}.join("\r\n")
        render(text: listing, contentType: "text/plain", encoding: "UTF-8")
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

    def fixTournamentFormats() {
        cleanupService.fixTournamentFormats()
        render view: "index"
    }

    def fixPlayerRankings() {
        cleanupService.fixPlayerRankings()
        render view: "index"
    }

}
