import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper

public List<String> getTop200Players(Version game) {
    JsonSlurper slurper = new JsonSlurper()
    def top100      = slurper.parse("http://rank.shoryuken.com/api/top?game=${game.name()}&format=json&size=100&offset=0".toURL()).collect { it.id }
    def slice200    = slurper.parse("http://rank.shoryuken.com/api/top?game=${game.name()}&format=json&size=100&offset=100".toURL()).collect { it.id }
    def top      = top100 + slice200
    return top
}
public def getPlayer(Integer id) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/id/${id}".toURL())
    return player
}

def factor = 1.18

def top250sf5 = getTop200Players(Version.SF5)
def stats = top250sf5.collect {  p ->
    def details = getPlayer(p)
    Integer sf5score = details.rankings.SF5?.score * factor
    Integer sf4score = details.rankings.USF4?.score?: 0
    Integer diff = sf5score - sf4score
    return [id: details.id, name: details.name, sf5score: sf5score, sf4score: sf4score, diff: diff, up: diff >= 0]
}

def uptrending = stats.findAll { it.up }
def downtrending = stats.findAll { !it.up }

println "## uptrending list"
println "| Player | SF5 score | SF4 score | Performance | "
println "| ------ | --------- | --------- | ----------- | "
uptrending.sort { a, b -> b.diff <=> a.diff }.each {
    println "| [$it.name](http://rank.shoryuken.com/rankings/player/$it.id) | $it.sf5score | $it.sf4score | $it.diff |"
}

println "## downtrending list"
println "| Player | SF5 score | SF4 score | Performance | "
println "| ------ | --------- | --------- | ----------- | "
downtrending.sort { a, b -> a.diff <=> b.diff }.each {
    println "| [$it.name](http://rank.shoryuken.com/rankings/player/$it.id) | $it.sf5score | $it.sf4score | $it.diff |"
}