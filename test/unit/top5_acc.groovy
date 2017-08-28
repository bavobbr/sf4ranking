import groovy.json.JsonSlurper
import org.joda.time.DateTime

import java.text.SimpleDateFormat

def gamename = "SF5"


public List<String> getTopPlayers(String game) {
    JsonSlurper slurper = new JsonSlurper()
    def top100 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=16&offset=0".toURL())
    return top100
}

def players = getTopPlayers(gamename)

public def getPlayer(Integer id) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/id/${id}".toURL())
    return player
}

def tournaments = [:]

players.each {
    def p = getPlayer(it.id)
    def sf5results = p.results.findAll { it.game == "SF5" }
    def refdate = new DateTime()
    def startDate = refdate.minusMonths(12)
    def inWindow = sf5results.findAll {
        Date date = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(it.date)
        def tdate = new DateTime(date.time)
        return tdate.isAfter(startDate)
    }
    inWindow.each {
        def tournament = it.tournamentname
        def place = it.place
        if (place == 1) {
            tournaments[tournament] = p.name
        }
        else {
            if (!tournaments[tournament]) {
                tournaments[tournament] = null
            }
        }
    }
}

tournaments.each {
    println it
}

def wins = tournaments.count { it.value }
def losses = tournaments.count { !it.value}
println players.name
println wins
println losses
println wins / tournaments.size()