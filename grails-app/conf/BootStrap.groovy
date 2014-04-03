import be.bbr.sf4ranking.Configuration
import be.bbr.sf4ranking.shiro.Role
import be.bbr.sf4ranking.shiro.User
import org.apache.shiro.crypto.hash.Sha256Hash

/**
 * Creates a default user and config if no database entries exist yet
 */
class BootStrap {

    def init = { servletContext ->

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
            adminRole.save()
            def user = new User(username: "init", passwordHash: new Sha256Hash("init").toHex())
            user.addToRoles(adminRole)
            user.save()
        }
        if (!Configuration.first()) {
            Configuration cfg = new Configuration()
            cfg.lastUpdateMessage = """
  Currently the database is focusing on SSF4:AE 2012 edition, listing all high-profile tournaments of 2012 and 2013. As a result this ranking reflects the most all-round tournament players of Street Fighter 4: Arcade Edition 2012.
  As soon as more tournaments are added in different games, new rankings will be made per game.<br/>
  The database and website is still in beta-phase and subject to change on user feedback. Feedback is very much appreciated via the social links provided at every page!<br/>
  UPDATE: Now allows you to search players by character, and to filter region by clicking flags.
"""
            cfg.save()
        }
    }

    def destroy = {
    }
}
