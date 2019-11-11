import groovy.json.JsonSlurper

def gamename = "T7"
def smashname = "tekken"

public List<String> getTopPlayers(String game) {
    JsonSlurper slurper = new JsonSlurper()
    def top100 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=0".toURL())
    def top200 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=100".toURL())
    def top300 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=200".toURL())
    def top400 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=300".toURL())
    def top500 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=400".toURL())
    return top100 + top200 + top300 + top400 + top500
}

public def getPlayer(Integer id) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/id/${id}".toURL())
    return player
}

def files = ["evo_2019"]
def smashids = []

files.each { fname ->
    def file = new File("/Users/bbr/Desktop/newsmash/${fname}.csv")
    def rows = file.readLines()
    rows.each {
        def values = it.split(",")
        values = values.collect { it.replace("\"", "")}
        def id = values[0]
        def game = values[8].trim().toLowerCase()
        def name = values[4].trim().toLowerCase()
        if (game =~ smashname.toLowerCase()) {
            println "saved $name $id $game"
            smashids << id
        }
    }
}

def top100 = getTopPlayers(gamename)
top100.collect { playernode ->
    def smashid = playernode.smashId as String
    if (!smashid || !(smashid in smashids)) {
        def player = getPlayer(playernode.id)
        def name = player.name
        def country = player.country
        def rank = player.rankings[gamename].rank
        //def main = (player.rankings[gamename].main[0]) - "${gamename}_"
        def main = (player.rankings[gamename].main.join("/"))
        def cptScore = player.cptScore
        //println "$rank. $name ($country) ${main.toLowerCase()} ($cptScore)"
        println "$rank. $name ($country) ${main.toLowerCase()}"
    }
}