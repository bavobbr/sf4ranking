package be.bbr.admin

import be.bbr.sf4ranking.User

/**
 * Simple login controller
 * Should be replaced with Shiro
 */
class UserController
{

    static scaffold = User


    def login() {
        if (request.get) {
            return // render the login view
        }
        def u = User.findByLogin(params.login)
        if (u) {
            if (u.password == params.password) {
                session.user = u
                redirect(controller: "admin")
            }
            else {
                render(view: "login", model: [message: "Password incorrect"])
            }
        }
        else {
            render(view: "login", model: [message: "User not found"])
        }
    }
}
