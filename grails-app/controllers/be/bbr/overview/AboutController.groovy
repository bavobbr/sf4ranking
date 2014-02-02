package be.bbr.overview

import be.bbr.sf4ranking.Player
import be.bbr.sf4ranking.Result
import be.bbr.sf4ranking.Tournament

/**
 * User: bbr
 * Date: 1/22/14
 */
class AboutController
{

    def index() {
        def lowest = Tournament.list(order: "asc", sort: "date", max: 1)
        def highest = Tournament.list(order: "desc", sort: "date", max: 1)
        return [
                players: Player.count(),
                tournaments: Tournament.count(),
                results: Result.count(),
                first: lowest?.date? lowest.date.first() : null,
                last: highest?.date? highest.date.first() : null
        ]
    }
}
