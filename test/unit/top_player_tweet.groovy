import groovy.json.JsonSlurper

def players = [""]

public List<String> getPlayers(String game) {
    JsonSlurper slurper = new JsonSlurper()
    return slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=50&offset=0".toURL()).collect { it.name }
}
public Map<String, String> getPlayer(String name) {
    JsonSlurper slurper = new JsonSlurper()
    def ename = URLEncoder.encode(name, "UTF-8")
    def player      = slurper.parse(("http://rank.shoryuken.com/api/player/name/"+ename).toURL())
    String main = player.rankings.SF5.main[0] - "SF5_"
    def sf5 = player.results.findAll { it.game == "SF5"}
    def best = sf5.sort { it.score }.reverse().take(5).collect { [it.place, it.tournamentname] }
    def trendDiff = player.rankings.SF5.rank - player.rankings.SF5.trendingRank
    def trendLabel = String.format("%+d", trendDiff)
    def alltime = player.rankings.SF5.alltimeRank
    return [name: name, ename: ename, twitter: player.twitter, rank: player.rankings.SF5.rank, country: player.country, main: main.toLowerCase().capitalize(), best: best, trendDiff: trendLabel, alltime: alltime, trending: player.rankings.SF5.trendingRank]
}

def top50 = getPlayers("SF5")
def data = top50.collect { getPlayer(it) }.sort { it.rank }.reverse()
data.each { p ->
    println "SF5 best of 2017"
    println "${p.rank}. ${p.name} (${p.main} from ${p.country}) @${p.twitter}"
    println "Momentum: ${p.trendDiff}"
    p.best.each { t ->
        println "- (${t[0]}) ${t[1]- "- SF5"}"
    }
    println "http://rank.shoryuken.com/rankings/player/byname/${p.ename} #srkbo2017"
    println " "
}

