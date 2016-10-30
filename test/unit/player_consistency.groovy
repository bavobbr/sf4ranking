import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper
import org.apache.commons.math.stat.descriptive.SummaryStatistics

public List<Map> getTopPlayers(String game, Integer count) {
    JsonSlurper slurper = new JsonSlurper()
    return slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=$count&offset=0".toURL())
}
public Map getPlayer(Integer id) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/id/${id}".toURL())
    return player
}

def game = Version.UMVC3
def count = 50

def top100 = getTopPlayers(game.name(), count)
List<PlayerStatistics> pstats = top100.collect {
    def player = getPlayer(it.id)
    def results = player.results.findAll { it.game == game.name() && it.place <= 32  && it.type != "LOCAL"}
    PlayerStatistics pstats = new PlayerStatistics(name: player.name, places: results*.place)
    pstats.calculate()
    return pstats
}

pstats.sort { it.variance }.eachWithIndex { p, i ->
    print "${i+1} [$p.name] ".padRight(25)
    print "mean: $p.mean".padRight(10)
    print "deviation: ${p.deviation.round(2)}".padRight(20)
    print "variance: $p.variance".padRight(18)
    println "places: $p.places"
}

SummaryStatistics gamestats = new SummaryStatistics()
pstats.each { gamestats.addValue(it.variance) }
println "Total mean: $gamestats.mean"


class PlayerStatistics {
    String name
    Double deviation
    Integer mean
    Integer variance
    List<Integer> places

    public void calculate() {
        SummaryStatistics statistics = new SummaryStatistics()
        places.each {
            statistics.addValue(it)
        }
        deviation = statistics.standardDeviation
        mean = statistics.mean
        variance = statistics.variance
    }

}