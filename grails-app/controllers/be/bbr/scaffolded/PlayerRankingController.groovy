package be.bbr.scaffolded

import be.bbr.sf4ranking.PlayerRanking

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PlayerRankingController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PlayerRanking.list(params), model:[playerRankingInstanceCount: PlayerRanking.count()]
    }

    def show(PlayerRanking playerRankingInstance) {
        respond playerRankingInstance
    }

    def create() {
        respond new PlayerRanking(params)
    }

    @Transactional
    def save(PlayerRanking playerRankingInstance) {
        if (playerRankingInstance == null) {
            notFound()
            return
        }

        if (playerRankingInstance.hasErrors()) {
            respond playerRankingInstance.errors, view:'create'
            return
        }

        playerRankingInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'playerRankingInstance.label', default: 'PlayerRanking'), playerRankingInstance.id])
                redirect playerRankingInstance
            }
            '*' { respond playerRankingInstance, [status: CREATED] }
        }
    }

    def edit(PlayerRanking playerRankingInstance) {
        respond playerRankingInstance
    }

    @Transactional
    def update(PlayerRanking playerRankingInstance) {
        if (playerRankingInstance == null) {
            notFound()
            return
        }

        if (playerRankingInstance.hasErrors()) {
            respond playerRankingInstance.errors, view:'edit'
            return
        }

        playerRankingInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PlayerRanking.label', default: 'PlayerRanking'), playerRankingInstance.id])
                redirect playerRankingInstance
            }
            '*'{ respond playerRankingInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PlayerRanking playerRankingInstance) {

        if (playerRankingInstance == null) {
            notFound()
            return
        }

        playerRankingInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PlayerRanking.label', default: 'PlayerRanking'), playerRankingInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'playerRankingInstance.label', default: 'PlayerRanking'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
