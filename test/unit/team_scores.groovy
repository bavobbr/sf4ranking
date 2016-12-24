import groovy.json.JsonSlurper

def sf5tournaments = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/game/SF5".toURL())
def teams = [:]

def players = [:]


sf5tournaments.each { tournament ->
    println "pollling $tournament.name"
    def tournamentdata = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/id/$tournament.id".toURL())
    tournamentdata.results.each { result ->
        player = players[result.player]
        if (!player) {
            player = new JsonSlurper().parse("http://rank.shoryuken.com/api/player/id/$result.player".toURL())
            println "created player $result.playername"
            players[result.player] = player
        }
        player.teams.each { name ->
            def teamscore = teams[name]?: 0
            if (!teamscore) {
                println "created team $name"
                teams[name] = 0
            }
            teams[name] = teamscore + result.score
        }
    }
    println teams
}

teams = teams.sort { m -> m.value }
teams.each { m ->
    println "$m.key: $m.value"
}
