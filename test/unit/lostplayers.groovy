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
def top250sf5 = getTop250Players(Version.SF5)
def top50 = getTop250Players(Version.USF4).take(50)

println top50.findAll { !(it in top250sf5) }