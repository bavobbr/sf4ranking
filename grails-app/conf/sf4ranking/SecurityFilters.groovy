package sf4ranking

class SecurityFilters {

    def filters = {
        all(controller: 'admin|player|result|tournament|user') {
            before = {
                if (!session.user && actionName != "login") {
                    redirect(controller: "user", action: "login")
                    return false
                }
            }
        }
    }
}
