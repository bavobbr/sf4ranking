import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper


public List<String> getTop250Players(Version game) {
    JsonSlurper slurper = new JsonSlurper()
    def top100      = slurper.parse("http://rank.shoryuken.com/api/top?game=${game.name()}&format=json&size=100&offset=0".toURL()).collect { it.name }
    def slice200    = slurper.parse("http://rank.shoryuken.com/api/top?game=${game.name()}&format=json&size=100&offset=100".toURL()).collect { it.name }
    def slice250    = slurper.parse("http://rank.shoryuken.com/api/top?game=${game.name()}&format=json&size=50&offset=200".toURL()).collect { it.name }
    def top250      = top100 + slice200 + slice250
    return top250
}

public List<String> getTopPlayers(Integer size, Version game) {
    JsonSlurper slurper = new JsonSlurper()
    return slurper.parse("http://rank.shoryuken.com/api/top?game=${game.name()}&format=json&size=${size}&offset=0".toURL()).collect { it.name }
}


def compareWith = [Version.SUPER, Version.AE2012, Version.USF4, Version.SF5, Version.MKX, Version.KI, Version.BBCP, Version.IGAU, Version.SKULLGIRLS]



def matrix = compareWith.collectEntries { base ->
    def top100_base = getTopPlayers(100, base)
    def overlap = compareWith.collectEntries { game ->
        def top100_other = getTop250Players(game)
        def players = top100_base.findAll { it in top100_other }
        println "GAME $base vs $game"
        println "${players.size()} in top 100: " + players
        [(game.name()): players.size()]
    }
    println overlap
    [(base.name()), overlap]
}
println matrix

println "game,"+compareWith.collect{ it.name()}.join(",")
matrix.each { game, data ->
    println game + ","+compareWith.collect { data[it.name()] }.join(",")
}