import be.bbr.sf4ranking.User

class BootStrap {

    def init = { servletContext ->

        if (!(User.count() > 0)) {
            User initalUser = new User(login: "init", password: "init")
            initalUser.save()
        }
    }
    def destroy = {
    }
}
