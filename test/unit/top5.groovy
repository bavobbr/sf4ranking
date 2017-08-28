import groovy.json.JsonSlurper
import org.joda.time.DateTime

import java.text.SimpleDateFormat

def gamename = "T7"

public List<String> getTopPlayers(String game) {
    JsonSlurper slurper = new JsonSlurper()
    def top100 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=50&offset=0".toURL())
    return top100
}

def players = getTopPlayers(gamename)

public def getPlayer(Integer id) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/id/${id}".toURL())
    return player
}

println "name, total, wins, top2, top3, top4, top6, top8, top16"


players.each {
    def p = getPlayer(it.id)
    def sf5results = p.results.findAll { it.game == gamename }
    def refdate = new DateTime()
    def startDate = refdate.minusMonths(12)
    def inWindow = sf5results.findAll {
        Date date = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(it.date)
        def tdate = new DateTime(date.time)
        return tdate.isAfter(startDate)
    }
    def total = 0
    def top1wins = 0
    def top2wins = 0
    def top3wins = 0
    def top4wins = 0
    def top6wins = 0
    def top8wins = 0
    def top16wins = 0
    inWindow.each {
        def place = it.place
        if (place == 1) top1wins++
        if (place <= 2) top2wins++
        if (place <= 3) top3wins++
        if (place <= 4) top4wins++
        if (place <= 6) top6wins++
        if (place <= 8) top8wins++
        if (place <= 16) top16wins++
        total++
    }
    def top1pct = total > 0? (top1wins / total) : 0
    def top2pct = total > 0? (top2wins / total) : 0
    def top3pct = total > 0? (top3wins / total) : 0
    def top4pct = total > 0? (top4wins / total) : 0
    def top6pct = total > 0? (top6wins / total) : 0
    def top8pct = total > 0? (top8wins / total) : 0
    def top16pct = total > 0? (top16wins / total) : 0
    println "$p.name, $total, $top1pct, $top2pct, $top3pct, $top4pct, $top6pct, $top8pct, $top16pct"
}