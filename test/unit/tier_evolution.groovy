import be.bbr.sf4ranking.CharacterType
import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper

import java.text.DateFormat
import java.text.SimpleDateFormat

def sf5tournaments = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/game/SF5".toURL())
def sf5chars = CharacterType.values().findAll { it.game == Version.SF5 }.collect { it.name() }
def months = []

8.times { int idx ->
    def refdate = new Date(116, idx+1, 1)
    def enddate = refdate.plus(90)
    def inWindow = sf5tournaments.findAll {
        Date date = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(it.date)
        return date.before(enddate) && date.after(refdate) && it.cpt != "NONE"
    }
    println "Discovered ${inWindow.size()} tournaments in window $refdate to $enddate"

    def winners = { tournaments ->
        tournaments.findResults {
            def tournament = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/id/$it.id".toURL())
            def scores = [:]
            tournament.results.each { result ->
                result.characters.each {
                    def character = it.first()
                    def score = result.cptScore
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
}

def labels = months.collect { it.keySet()[0] }
labels.add(0, "")
println labels.join(",")

sf5chars.each { name ->
    print name+","
    def ranks = months.collect {
        def charResults = it.values()[0]
        def sortedResult = charResults.sort { a, b -> b.value <=> a.value }
        sortedResult.findIndexOf { it.key ==  name } + 1
    }
    println ranks.join(",")
}