import be.bbr.sf4ranking.CharacterType
import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper
import org.joda.time.DateTime

import java.text.SimpleDateFormat

def sf5tournaments = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/game/SF5".toURL())
def sf5chars = CharacterType.values().findAll { it.game == Version.SF5 }.collect { it.name() }
def months = []

def s1 = new DateTime().withDate(2016, 1, 1)
def s2 = new DateTime().withDate(2016, 12, 20)
def s2b = new DateTime().withDate(2017, 5, 31)
def s3 = new DateTime().withDate(2018, 1, 16)
def s3b = new DateTime().withDate(2018, 4, 15)
def end = new DateTime()

//List<List<Date>> periods = [[s1, s2], [s2, s2b], [s2b, s3], [s3, s3b], [s3b, end]]
List<List<Date>> periods = [[s1, s2], [s2, s3], [s3, end]]

periods.each { List<Date> period ->
    def refdate = period[0]
    def enddate = period[1]
    def inWindow = sf5tournaments.findAll {
        DateTime date = new DateTime(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(it.date).time)
        return date.isBefore(enddate) && date.isAfter(refdate)
    }
    println "Discovered ${inWindow.size()} tournaments in window $refdate to $enddate"

    def winners = { tournaments ->
        tournaments.findResults {
            def tournament = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/id/$it.id".toURL())
            def scores = [:]
            tournament.results.each { result ->
                result.characters.each {
                    def character = it.first()
                    def score = result.legacyScore / result.characters.size()
                    println "Score for $character is ${result.legacyScore} divided by size ${result.characters.size()}"
                    if (!scores[character]) scores[character] = []
                    scores[character] << score.toInteger()
                }
            }
            return scores
        }
    }

    def characterResults = winners(inWindow)
    def summedPerCharacter = characterResults.collect {
        it.collectEntries { [(it.key): it.value.sum()] }
    }

    summedPerCharacterPerTournament = sf5chars.collectEntries { sf5char ->
        bychar = summedPerCharacter.findResults { it[sf5char] }
        [(sf5char): bychar.sum()]
    }
    months << [(refdate): summedPerCharacterPerTournament]
}

def labels = months.collect { it.keySet()[0] }.collect { DateTime date -> new SimpleDateFormat("dd/MM/yy").format(new Date(date.millis)) }
labels.add(0, "")
println labels.join(",")

sf5chars.each { name ->
    print name-"SF5_"+","
    def ranks = months.collect {
        def charResults = it.values()[0]
        def sortedResult = charResults.sort { a, b -> b.value <=> a.value }
        def index = sortedResult.findIndexOf { it.key ==  name } + 1
        if (!sortedResult[name]) {
            return "-"
        }
        else {
            return index
        }
    }
    println ranks.join(",")
}

println labels.join(",")
sf5chars.each { name ->
    print name-"SF5_"+","
    def ranks = months.collect {
        def charResults = it.values()[0]
        def sortedResult = charResults.sort { a, b -> b.value <=> a.value }
        def total = sortedResult.find { it.key ==  name }.value
        if (!sortedResult[name]) {
            return "-"
        }
        else {
            return total
        }
    }
    println ranks.join(",")
}

println("|" + labels.join("|"))
println("|" + labels.collect {" *** "}.join("|") )
sf5chars.each { name ->
    print name-"SF5_"+","
    def ranks = months.collect {
        def charResults = it.values()[0]
        def sortedResult = charResults.sort { a, b -> b.value <=> a.value }
        def index = sortedResult.findIndexOf { it.key ==  name } + 1
        if (!sortedResult[name]) {
            return "-"
        }
        else {
            return index
        }
    }
    println("|" + ranks.join("|"))
}