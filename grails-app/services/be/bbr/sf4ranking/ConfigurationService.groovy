package be.bbr.sf4ranking

import grails.transaction.Transactional
import grails.util.Holders


@Transactional
class ConfigurationService
{

    void withUniqueSession(Closure c) {
        def grailsApplication = Holders.getGrailsApplication()
        if (!grailsApplication.config.global.isUpdating) {
            grailsApplication.config.global.isUpdating = true
            try {
                log.info "Executing in unique session"
                c()
            }
            finally
            {
                grailsApplication.config.global.isUpdating = false
                log.info "Unique session is freed"
            }
        }
        else {
            log.warn "Skipped update as another one is already running"
            throw new ConcurrentModificationException("A data update was already running, try again later")
        }
    }

}
