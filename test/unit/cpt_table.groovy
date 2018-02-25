import groovy.json.JsonSlurper

def cptstats = new JsonSlurper().parse("http://localhost:8080/sf4ranking/api/top?cpt=true&size=64&format=json".toURL())
cptstats.sort {it.cptRank}.each {
    println "$it.cptRank, $it.cptRankPrev, $it.name, $it.country, $it.cptScore, $it.cptScorePrev"
}
