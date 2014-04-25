package be.bbr.scaffolded

import be.bbr.sf4ranking.Result

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ResultController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Result.list(params), model:[resultInstanceCount: Result.count()]
    }

    def show(Result resultInstance) {
        respond resultInstance
    }

    def create() {
        respond new Result(params)
    }

    @Transactional
    def save(Result resultInstance) {
        if (resultInstance == null) {
            notFound()
            return
        }

        if (resultInstance.hasErrors()) {
            respond resultInstance.errors, view:'create'
            return
        }

        resultInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'resultInstance.label', default: 'Result'), resultInstance.id])
                redirect resultInstance
            }
            '*' { respond resultInstance, [status: CREATED] }
        }
    }

    def edit(Result resultInstance) {
        respond resultInstance
    }

    @Transactional
    def update(Result resultInstance) {
        if (resultInstance == null) {
            notFound()
            return
        }

        if (resultInstance.hasErrors()) {
            respond resultInstance.errors, view:'edit'
            return
        }

        resultInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Result.label', default: 'Result'), resultInstance.id])
                redirect resultInstance
            }
            '*'{ respond resultInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Result resultInstance) {

        if (resultInstance == null) {
            notFound()
            return
        }

        resultInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Result.label', default: 'Result'), resultInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'resultInstance.label', default: 'Result'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
