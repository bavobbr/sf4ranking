import groovy.json.JsonSlurper

def host = "http://localhost:8080/sf4ranking"
def sf5tournaments = new JsonSlurper().parse("$host/api/tournament/game/SF5".toURL())
def evo = sf5tournaments.findAll { it.cpt == "EVO" }
def premiers = sf5tournaments.findAll { it.cpt == "PREMIER" || it.cpt == "REGIONAL_FINAL" }
def rankings = sf5tournaments.findAll { it.cpt == "RANKING" || it.cpt == "ONLINE_EVENT" }

def process = { def id ->
        def tournament = new JsonSlurper().parse("$host/api/tournament/id/$id".toURL())
        return tournament.results.sum { it.cptScore }
}

println evo.size()
println premiers.size()
println rankings.size()

def evosum = evo.sum { process(it.id) }
def premsum = premiers.sum { process(it.id) }
def ranksum = rankings.sum { process(it.id) }

println "EVO $evosum"
println "Premier $premsum"
println "Ranking $ranksum"
println "Total: ${evosum+premsum+ranksum}"