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
        def index = 1
        def example = "player1 (char1/char2,char1/char3)\nplayer2 (char1,char2)\nplayer3 (char1/char2)\nplayer4"
        render view: "importer", model: [hint: example]
    }

    def importTournament()
    {
        String tname = params.tname
        Date tdate = new Date(params.tdate_year.toInteger() - 1900, params.tdate_month.toInteger(), params.tdate_day.toInteger())
        TournamentFormat tformat = TournamentFormat.fromString(params.tformat)
        TournamentType ttype = TournamentType.fromString(params.ttype)
        WeightingType tweight = WeightingType.fromString(params.tweight)
        CountryCode tcountry = CountryCode.fromString(params.tcountry)
        Version tgame = Version.fromString(params.tgame)
        String results = params.tresults
        String coverage = params.tcoverage
        List tvideos = params.tvideos.tokenize(" ")
        Boolean tranked = params.tranked?.toBoolean() ?: true
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
        players.each {
            def alts = dataService.findAlikes(it.name)
            if (alts && alts.size() > 1) map[it] = alts
        }
        [players: map]
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
