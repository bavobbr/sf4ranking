import be.bbr.sf4ranking.CharacterType
import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper
import org.joda.time.DateTime

import java.text.SimpleDateFormat

def sf5tournaments = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/game/SF5".toURL())
def sf5chars = CharacterType.values().findAll { it.game == Version.SF5 }.collect { it.name() }
def months = []

def startdate = new DateTime().withYear(2016).withDayOfMonth(1).withMonthOfYear(1)
def current = new DateTime()
def diff = (current.monthOfYear + current.year*12) - (startdate.monthOfYear+startdate.year*12)

println "We found $diff months in between"
def refdate = startdate

diff.times { int idx ->
    def enddate = refdate.plusMonths(3)
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
                    def score = result.legacyScore
                    if (!scores[character]) scores[character] = []
                    scores[character] << score
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
    refdate = refdate.plusMonths(1)

}

def labels = months.collect { it.keySet()[0] }.collect { Date date -> new SimpleDateFormat("dd/MM/yy").format(date) }
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