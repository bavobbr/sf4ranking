import be.bbr.sf4ranking.TournamentType
import groovy.json.JsonSlurper
import org.joda.time.DateTime

import java.text.SimpleDateFormat

import static be.bbr.sf4ranking.TournamentType.CHAMPIONSHIP
import static be.bbr.sf4ranking.TournamentType.GRAND_SLAM
import static be.bbr.sf4ranking.TournamentType.INTERNATIONAL
import static be.bbr.sf4ranking.TournamentType.PREMIER_12
import static be.bbr.sf4ranking.TournamentType.PREMIER_5
import static be.bbr.sf4ranking.TournamentType.PREMIER_MANDATORY

def gamename = "SF5"

public def getPlayer(Integer id) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/id/${id}".toURL())
    return player
}

public Map<String, String> getTournament(Integer id) {
    return new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/id/$id".toURL())
}

def types = [GRAND_SLAM, PREMIER_5, PREMIER_12, PREMIER_MANDATORY, CHAMPIONSHIP, INTERNATIONAL].collect { it.name() }


def sf5tournaments = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/game/$gamename".toURL())
def all = sf5tournaments.findAll { it.classifier in types }

println all.size()

def windata = all.findResults {
    def data = getTournament(it.id)
    def winner = data.results.find { it.place == 1}
    if (winner) {
        return [data.name, winner.playername]
    }
    else return null
}

windata.each {
    println it
}

def groupedByWinner = windata.countBy { it[1] }
groupedByWinner.each {
    println "${it.key},${it.value}"
}