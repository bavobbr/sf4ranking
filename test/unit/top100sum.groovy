import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper

public List<String> getTop100Players(Version game) {
    JsonSlurper slurper = new JsonSlurper()
    def top100      = slurper.parse("http://rank.shoryuken.com/api/top?game=${game.name()}&format=json&size=100&offset=0".toURL())
    return top100
}
def total = getTop100Players(Version.SF5).sum { it.score }
def totalusf4 = getTop100Players(Version.USF4).sum { it.score }

println total
println totalusf4

println (totalusf4 / total)