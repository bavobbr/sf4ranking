import groovy.json.JsonSlurper

def host = "http://localhost:8080/sf4ranking"
def sf5tournaments = new JsonSlurper().parse("$host/api/tournament/game/SF5".toURL())
def evo = sf5tournaments.findAll { it.cpt == "EVO" }
def premiers = sf5tournaments.findAll { it.cpt == "PREMIER" || it.cpt == "REGIONAL_FINAL" }
def rankings = sf5tournaments.findAll { it.cpt == "RANKING" || it.cpt == "ONLINE_EVENT" }

def scores_evo = [[1000], [700], [500], [400], [320] * 2, [250] * 2, [200] * 4, [160] * 4, [130] * 8, [100] * 8, [70] * 16, [40] * 16, [20] * 32, [10] * 32, [5] * 64, [1] * 64].flatten()
def scores_premier = [[400], [250], [200], [160], [130] * 2, [100] * 2, [70] * 4, [40] * 4, [20] * 8, [10] * 8, [5] * 16, [1] * 16].flatten()
def scores_ranking = [[160], [100], [70], [40], [20] * 2, [10] * 2, [5] * 4, [1] * 4].flatten()


def playerToScore = [:]

def process = { def id, def scores ->
    evo.findResults {
        def tournament = new JsonSlurper().parse("$host/api/tournament/id/$id".toURL())
        tournament.results.sort { it.place }.each {
            def score = 0
            if (it.place > scores.size()) {
                score = 0
            } else {
                score = scores[it.place]
            }
            if (!playerToScore.containsKey(it.player)) {
                playerToScore[it.player] = 0
            }
            playerToScore[it.player] = playerToScore[it.player] + score
        }
    }
}

evo.each { process(it.id, scores_evo) }
premiers.each { process(it.id, scores_premier) }
rankings.each { process(it.id, scores_ranking) }

def cpt_players = new JsonSlurper().parse("$host/api/top?cpt=true&size=512&format=json".toURL())
def iter = 0
def factor = 1.177
def results = playerToScore.sort { a, b -> b.value <=> a.value }.take(128).collect { e ->
    iter++
    def playerIndex = cpt_players.findIndexOf { it.id == e.key }+1
    def player = new JsonSlurper().parse("$host/api/player/id/${e.key}".toURL())
    def diff = 999
    if (playerIndex) {
        diff = playerIndex - iter
    }
    diff = diff<0? ""+diff : "+"+diff
    [iter+"", player.name, e.value+"", ((e.value*factor)as int)+"", playerIndex? playerIndex+"": "-", diff == "+999"? "": diff]
}

//println "2017 rank".padRight(10) + "name".padRight(16) + "2017 score".padRight(11) + "2017 adj score".padRight(11) + "2016 rank".padRight(10) + "2017 diff"
results.each { r ->
    //println r[0].padRight(10) + r[1].padRight(16) + r[2].padRight(11) + r[3].padRight(15) + r[4].padRight(10) + r[5]
    println r.join(",")
}
