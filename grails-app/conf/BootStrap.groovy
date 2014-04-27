import be.bbr.sf4ranking.Configuration
import be.bbr.sf4ranking.shiro.Role
import be.bbr.sf4ranking.shiro.User
import grails.plugin.searchable.SearchableService
import org.apache.shiro.crypto.hash.Sha256Hash

/**
 * Creates a default user and config if no database entries exist yet
 */
class BootStrap {

    SearchableService searchableService

    def init = { servletContext ->
        log.info "Reindexing..."
        searchableService.reindex()
        log.info "Reindexed compass"

        if (!User.first()) {
            def adminRole = new Role(name: "Administrator")
            adminRole.addToPermissions("admin")
            adminRole.addToPermissions("configuration")
            adminRole.addToPermissions("gameCharacter")
            adminRole.addToPermissions("player")
            adminRole.addToPermissions("playerRanking")
            adminRole.addToPermissions("result")
            adminRole.addToPermissions("team")
            adminRole.addToPermissions("tournament")
            adminRole.addToPermissions("user")
            adminRole.addToPermissions("role")
            adminRole.addToPermissions("gameTeam")
            adminRole.save()
            def modRole = new Role(name: "Moderator")
            modRole.addToPermissions("admin")
            modRole.addToPermissions("gameCharacter")
            modRole.addToPermissions("player")
            modRole.addToPermissions("playerRanking")
            modRole.addToPermissions("result")
            modRole.addToPermissions("team")
            modRole.addToPermissions("tournament")
            modRole.addToPermissions("role")
            modRole.addToPermissions("gameTeam")
            modRole.save()
            def user = new User(username: "init", passwordHash: new Sha256Hash("init").toHex())
            user.addToRoles(adminRole)
            user.save()
        }
        if (!Configuration.first()) {
            Configuration cfg = new Configuration()
            cfg.lastUpdateMessage = "test"
            cfg.save()
        }
    }

    def destroy = {
    }
}
