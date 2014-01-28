package be.bbr.admin

import be.bbr.sf4ranking.Player
import be.bbr.sf4ranking.RankingService
import be.bbr.sf4ranking.Result
import be.bbr.sf4ranking.Tournament
import grails.converters.JSON

class AdminController
{

    RankingService rankingService

    def index() {}

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
        render view: "importer"
    }

    def importTournament()
    {
        String tname = params.tname
        String results = params.tresults
        rankingService.importTournament(tname, results)
        render view: "index"
    }

    def importFileData()
    {
        rankingService.importFileData()
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

    def merge()
    {
        [players: Player.list(order: "asc", sort: 'name')]
    }

    def mergePlayers()
    {
        def p1 = Player.findById(params.p1)
        def p2 = Player.findById(params.p2)
        log.info("Merging $p1 into $p2")
        def resultsToMerge = Result.findAllByPlayer(p1)
        resultsToMerge.each {
            log.info "merging $it to $p2"
            it.player = p2
            it.save()
        }
        p1.delete()
        redirect(controller: "rankings", action: "player", params: [id: p2.id])
    }


    def deleteAll()
    {
        def confirmed = (params.confirm == "I do")
        if (confirmed)
        {
            Result.list().each {it.delete()}
            Player.list().each {it.delete()}
            Tournament.list().each {it.delete()}
            render view: "index"
        }
        else {
            render view: "confirmDelete"
        }
    }

    def exportTournaments()
    {
        def list = Tournament.list()
        def tournaments = []
        list.each {
            def tournament = [:]
            tournament.version = it.game?.name()
            tournament.date = it.date?.format("dd-MM-yyyy")
            tournament.country = it.countryCode?.name()
            tournament.videos = it.videos
            tournament.name = it.name
            def players = []
            it.results.sort {a, b -> a.place<=>b.place}.each {
                def player = [:]
                player.place = it.place
                player.player = it.player.name
                player.character = it.pcharacter?.name()
                players << player
            }
            tournament.players = players
            tournaments << tournament

        }
        render(tournaments as JSON)
    }

    def exportPlayers()
    {
        def list = Player.list()
        def players = []
        list.each {
            def player = [:]
            player.name = it.name
            player.countryCode = it.countryCode?.name()
            player.rank = it.rank
            player.skill = it.skill
            player.videos = it.videos
            player.codename = it.codename
            player.score = it.score
            players << player
        }
        render(players as JSON)

    }

}
