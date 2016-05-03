package be.bbr.overview

class ErrorsController
{

    def index() {
        log.info "Rendering default error view"
        render view: "error"
    }

    def concurrent() {
        log.info "Rendering concurrent modification error view"
        render("Another user was updating the database: ${grailsApplication.config.global.isUpdatingBy} please try again later")
    }
}
