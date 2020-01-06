import groovy.json.JsonSlurper
import org.joda.time.DateTime

import java.nio.charset.StandardCharsets
import java.text.SimpleDateFormat

def baseUrl = "http://rank.shoryuken.com/api/tournament/game/"
def games = ["VANILLA", "SUPER", "AE", "AE2012", "USF4", "SF5"]

def all = []

// list all tournaments
games.each { game ->
    def path = baseUrl + game
    def tournaments = new JsonSlurper().parse(path.toURL())
    println "Scanned ${tournaments.size()} tournaments"
    all.addAll(tournaments)
}
println "Discovered ${all.size()} tournaments"

def last = new DateTime()
def current = new DateTime().withDayOfMonth(1).withMonthOfYear(1).withYear(2009)

List<Map> datamap = []
List<DateTime> enddates = []

// count totals per player for every window
while (current.isBefore(last)) {
    def enddate = current
    def startdate = current.minusMonths(6)
    println "\n[Window $startdate to $enddate]"
    def inWindow = all.findAll { Map t ->
        DateTime date = new DateTime(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(t.date).time)
        return date.isBefore(enddate) && date.isAfter(startdate)
    }.sort { it.id }

    println "${inWindow.size()} tournaments in range"
    Map<String, List> scores = [:]
    Map<String, Integer> scoreTotals = [:]

    inWindow.findResults { Map t ->
        def tournament = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/id/$t.id".toURL())
        tournament.results.each { Map result ->
            scores.putIfAbsent(result.playername, [])
            scores[result.playername] << result.legacyScore
        }
        scores.each {
            def sortedPlayerScores = it.value.sort().reverse().take(6)
            scoreTotals[it.key] = sortedPlayerScores.sum()
        }
        def sortedScores = scoreTotals.sort { e1, e2 -> e2.value <=> e1.value }.take(10)
        println "After $t.name: $sortedScores"
    }
    def sortedScores = scoreTotals.sort { e1, e2 -> e2.value <=> e1.value }.take(50)
    datamap << sortedScores
    enddates << enddate
    current = current.plusMonths(1)
}

// print ranking results
datamap.eachWithIndex { Map data, Integer idx ->
    def enddate = enddates[idx]
    println "Date $enddate: $data"
}

// collect player population seen
Set<String> population = [] as HashSet
datamap.each { data ->
    data.keySet().each {
        population.add(it)
    }
}

println "Player size is ${population.size()}"
println "Player population is $population"

//fill missing data for population
population.each { player ->
    datamap.each { data ->
        if (data[player] == null) {
            data[player] = 0
        }
    }
}

// produce CSV report
def df = new SimpleDateFormat("yyyy-MM")
def header = "player, country, img," + enddates.collect { df.format(it.toDate()) }.join(",")
println header

population.each { p ->
    def pscores = []
    enddates.eachWithIndex { d, idx ->
        def data = datamap[idx]
        pscores << data[p]
    }
    def name = URLEncoder.encode(p, StandardCharsets.UTF_8.toString())
    def pdata = new JsonSlurper().parse("http://rank.shoryuken.com/api/player/name/$name".toURL())
    def region = pdata.country
    def img = "http://rank.shoryuken.com/static/images/countries/${region?.toLowerCase()}.png"
    def csv = "$p,$region,$img," + pscores.join(",")
    println csv
}

