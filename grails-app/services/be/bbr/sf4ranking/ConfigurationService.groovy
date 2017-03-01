package be.bbr.sf4ranking

import grails.transaction.NotTransactional
import grails.transaction.Transactional
import grails.util.Holders
import org.apache.shiro.SecurityUtils


class ConfigurationService
{
    static transactional = false

    @NotTransactional
    void withUniqueSession(Closure c) {
        def grailsApplication = Holders.getGrailsApplication()
        if (!grailsApplication.config.global.isUpdating) {
            grailsApplication.config.global.isUpdating = true
            def creator = SecurityUtils.subject?.principal?.toString()
            grailsApplication.config.global.isUpdatingBy = creator
            try {
                log.info "Executing in unique session"
                c()
            }
            finally
            {
                grailsApplication.config.global.isUpdating = false
                grailsApplication.config.global.isUpdatingBy = null
                log.info "Unique session is freed"
            }
        }
        else {
            log.warn "Skipped update as another one is already running by user ${grailsApplication.config.global.isUpdatingBy}"
            throw new IllegalAccessException("A data update was already running by ${grailsApplication.config.global.isUpdatingBy}, try again later")
        }
    }

}
