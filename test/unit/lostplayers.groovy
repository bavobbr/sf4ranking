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
public Map<String, String> getPlayer(String name) {
    JsonSlurper slurper = new JsonSlurper()
    def player      = slurper.parse("http://rank.shoryuken.com/api/player/name/${name}".toURL())
    String main = player.rankings.USF4.main[0] - "SF5_"
    return [name: name, rank: player.rankings.USF4.rank, country: player.country, main: main.toLowerCase()]
}

def top250sf5 = getTop250Players(Version.SF5)
def top50 = getTop250Players(Version.USF4).take(75)

def lost = top50.findAll { !(it in top250sf5) }

def stats = lost.collect { getPlayer(it) }
stats.each {
    println "${it.rank}. ${it.name} (${it.country}) ${it.main}"
}
println stats.countBy { it.main }.sort { a, b -> b.value <=> a.value }
println stats.countBy { it.country }.sort { a, b -> b.value <=> a.value }