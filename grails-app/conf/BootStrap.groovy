import be.bbr.sf4ranking.Configuration
import be.bbr.sf4ranking.User

/**
 * Creates a default user and config if no database entries exist yet
 */
class BootStrap {

    def init = { servletContext ->

        if (!User.first()) {
            User initalUser = new User(login: "init", password: "init")
            initalUser.save()
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
