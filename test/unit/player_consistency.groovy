import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper

public List<Map> getTop100Players(Version game) {
    JsonSlurper slurper = new JsonSlurper()
    return slurper.parse("http://rank.shoryuken.com/api/top?game=${game.name()}&format=json&size=10&offset=0".toURL())
}
public def getPlayer(Integer id) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/id/${id}".toURL())
    return player
}


def top100 = getTop100Players(Version.SF5)
top100.each {
    println getPlayer(it.id)
}