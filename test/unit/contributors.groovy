import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper

def host = "http://rank.shoryuken.com"

def games = Version.values().collect { it.name() }
//def games = ["BBCP", "MVCI", "GGXRD", "SF5", "USF4", "SF4", "SSF4", "USF4", "SF4AE"]

def creators = [:]

games.each { game ->
    def tournaments = new JsonSlurper().parse("$host/api/tournament/game/$game".toURL())
    def byCreator = tournaments.groupBy { it.creator }
    tournaments.each {
        String creator = it.creator
        if (!creators.containsKey(creator)) {
            creators[creator] = []
        }
        creators[creator] << it
    }
    byCreator.each { k, v ->
        println "$game,$k,${v.size()}"
    }
}

creators.each { k, v ->
    println "$k,${v.size()}"
}
