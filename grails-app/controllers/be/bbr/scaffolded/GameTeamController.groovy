package be.bbr.scaffolded

import be.bbr.sf4ranking.GameTeam

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GameTeamController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond GameTeam.list(params), model:[gameTeamInstanceCount: GameTeam.count()]
    }

    def show(GameTeam gameTeamInstance) {
        respond gameTeamInstance
    }

    def create() {
        respond new GameTeam(params)
    }

    @Transactional
    def save(GameTeam gameTeamInstance) {
        if (gameTeamInstance == null) {
            notFound()
            return
        }

        if (gameTeamInstance.hasErrors()) {
            respond gameTeamInstance.errors, view:'create'
            return
        }

        gameTeamInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'gameTeamInstance.label', default: 'GameTeam'), gameTeamInstance.id])
                redirect gameTeamInstance
            }
            '*' { respond gameTeamInstance, [status: CREATED] }
        }
    }

    def edit(GameTeam gameTeamInstance) {
        respond gameTeamInstance
    }

    @Transactional
    def update(GameTeam gameTeamInstance) {
        if (gameTeamInstance == null) {
            notFound()
            return
        }

        if (gameTeamInstance.hasErrors()) {
            respond gameTeamInstance.errors, view:'edit'
            return
        }

        gameTeamInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'GameTeam.label', default: 'GameTeam'), gameTeamInstance.id])
                redirect gameTeamInstance
            }
            '*'{ respond gameTeamInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(GameTeam gameTeamInstance) {

        if (gameTeamInstance == null) {
            notFound()
            return
        }

        gameTeamInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'GameTeam.label', default: 'GameTeam'), gameTeamInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'gameTeamInstance.label', default: 'GameTeam'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
