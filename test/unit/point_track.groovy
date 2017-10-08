import groovy.json.JsonSlurper

import java.text.SimpleDateFormat

public def getPlayer(String id) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/name/${id}".toURL())
    return player
}

public Map<String, String> getTournament(Integer id) {
    return new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/id/$id".toURL())
}

def player = getPlayer("Infiltration")
def scores = player.results.collectEntries {
    Date date = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(it.date)
    [date, it.legacyScore]
}
scores.sort { it.key }.each {
    println "${it.key.format("dd/MM/yyyy")}, $it.value"
}