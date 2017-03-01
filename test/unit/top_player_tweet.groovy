import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper

public List<String> getPlayers(Version game) {
    JsonSlurper slurper = new JsonSlurper()
    return slurper.parse("http://rank.shoryuken.com/api/top?game=${game.name()}&format=json&size=40&offset=0".toURL()).collect { it.name }
}
public Map<String, String> getPlayer(String name) {
    JsonSlurper slurper = new JsonSlurper()
    def ename = URLEncoder.encode(name, "UTF-8")
    def player      = slurper.parse(("http://rank.shoryuken.com/api/player/name/"+ename).toURL())
    String main = player.rankings.SF5.main[0] - "SF5_"
    def sf5 = player.results.findAll { it.game == "SF5"}
    def best = sf5.sort { it.score }.reverse().take(3).collect { [it.place, it.tournamentname] }
    return [name: name, ename: ename, twitter: player.twitter, rank: player.rankings.SF5.rank, country: player.country, main: main.toLowerCase(), best: best]
}

def top50 = getPlayers(Version.SF5)
def data = top50.collect { getPlayer(it) }.sort { it.rank }.reverse()
data.each { p ->
    println "SF5 Top50 Year 1"
    println "${p.rank}. ${p.name} (${p.main} / ${p.country}) @${p.twitter}"
    p.best.each { t ->
        println "- (${t[0]}) ${t[1]- "- SF5"}"
    }
    println "http://rank.shoryuken.com/rankings/player/byname/${p.ename} #50of5"
    println " "
}

