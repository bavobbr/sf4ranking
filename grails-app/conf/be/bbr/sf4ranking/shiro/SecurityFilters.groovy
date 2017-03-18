package be.bbr.sf4ranking.shiro

/**
 * Generated by the Shiro plugin. This filters class protects all URLs
 * via access control by convention.
 */
class SecurityFilters {
    def filters = {
        all(controller: 'admin|player|result|tournament|user|configuration|team|role|playerRanking|gameCharacter|gameTeam|hardware|query|tournamentReview') {
            before = {
                // Ignore direct views (e.g. the default main index page).
                if (!controllerName) return true

                // Access control by convention.
                accessControl()
            }
        }
    }
}
