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

def files = ["final_round_2018"]
def idToPool = [:]

def srkToPool = [:]

files.each { fname ->
    def file = new File("/Users/bbr/Desktop/newsmash/${fname}.csv")
    def rows = file.readLines()
    rows.each {
        def values = it.split(",")
        values = values.collect { it.replace("\"", "")}
        def id = values[0]
        def handle = values[3].trim().toLowerCase()
        def name = values[4].trim().toLowerCase()
        def game = values[8].trim().toLowerCase()
        def pool = values[11].trim().toLowerCase()
        if (game =~ smashname) {
            if (handle) idToPool[id] = pool
            if (pool) idToPool[id] = pool
            println "saved $id $name $handle $pool $game"
        }
    }
}

def top100 = getTopPlayers(gamename)
top100.each { playernode ->
    def smashid = playernode.smashId as String
    def name = playernode.name as String
    if (smashid) {
        def pool = idToPool[smashid.toLowerCase()]
        if (pool) {
            println "$playernode.name $playernode.smashId $pool"
            srkToPool[playernode.id] = pool
            return
        }
    }
}

println "matches"
srkToPool.each {
    println it
}
println srkToPool.size()

println "GROUPED"
def groupByPool =  srkToPool.groupBy { it.value }
def stacked = groupByPool.findAll {
    it.value.size() > 1
}
def groups = stacked.collect {
    def sum = 0
    def playerdata = it.value.collect { srkId, pool ->
        def player = getPlayer(srkId)
        def name = player.name
        def country = player.country
        def rank = player.rankings[gamename].rank as String
        def score = player.rankings[gamename].weight
        sum = sum+score
        "${rank.padLeft(3, "0")}. $name ($country) [weight: $score]"
    }
    def text = "[$it.key] weight: $sum"
    playerdata.each { text+="\n"+it }
    [sum, text]
}
groups.sort { a, b -> b[0] <=> a[0] }.each { item ->
    println "\n"+item[1]
}
