package be.bbr.scaffolded

import be.bbr.sf4ranking.GameCharacter

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GameCharacterController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond GameCharacter.list(params), model:[gameCharacterInstanceCount: GameCharacter.count()]
    }

    def show(GameCharacter gameCharacterInstance) {
        respond gameCharacterInstance
    }

    def create() {
        respond new GameCharacter(params)
    }

    @Transactional
    def save(GameCharacter gameCharacterInstance) {
        if (gameCharacterInstance == null) {
            notFound()
            return
        }

        if (gameCharacterInstance.hasErrors()) {
            respond gameCharacterInstance.errors, view:'create'
            return
        }

        gameCharacterInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'gameCharacterInstance.label', default: 'GameCharacter'), gameCharacterInstance.id])
                redirect gameCharacterInstance
            }
            '*' { respond gameCharacterInstance, [status: CREATED] }
        }
    }

    def edit(GameCharacter gameCharacterInstance) {
        respond gameCharacterInstance
    }

    @Transactional
    def update(GameCharacter gameCharacterInstance) {
        if (gameCharacterInstance == null) {
            notFound()
            return
        }

        if (gameCharacterInstance.hasErrors()) {
            respond gameCharacterInstance.errors, view:'edit'
            return
        }

        gameCharacterInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'GameCharacter.label', default: 'GameCharacter'), gameCharacterInstance.id])
                redirect gameCharacterInstance
            }
            '*'{ respond gameCharacterInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(GameCharacter gameCharacterInstance) {

        if (gameCharacterInstance == null) {
            notFound()
            return
        }

        gameCharacterInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'GameCharacter.label', default: 'GameCharacter'), gameCharacterInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'gameCharacterInstance.label', default: 'GameCharacter'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
