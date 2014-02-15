package sf4ranking

/**
 * Only allows access to the ranking and about controller
 */
class SecurityFilters {

    def filters = {
        all(controller: 'admin|player|result|tournament|user|configuration|team') {
            before = {
                if (!session.user && actionName != "login") {
                    redirect(controller: "user", action: "login")
                    return false
                }
            }
        }
    }
}
