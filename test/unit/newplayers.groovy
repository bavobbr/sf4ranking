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
    String main = player.rankings.SF5.main[0] - "SF5_"
    return [name: name, rank: player.rankings.SF5.rank, country: player.country, main: main.toLowerCase()]
}

def top250 = getTop250Players(Version.USF4)
def top250ae = getTop250Players(Version.AE2012)
def top50 = getTop250Players(Version.SF5).take(100)

def upcoming = top50.findAll { !(it in top250) && !(it in top250ae) }
def stats = upcoming.collect { getPlayer(it) }
stats.each {
    println "${it.rank}. ${it.name} (${it.country}) ${it.main}"
}
println stats.countBy { it.main }.sort { a, b -> b.value <=> a.value }
println stats.countBy { it.country }.sort { a, b -> b.value <=> a.value }