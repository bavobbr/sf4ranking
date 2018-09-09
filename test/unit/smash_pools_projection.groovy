import groovy.json.JsonSlurper

def gamename = "INJUSTICE2"
def smashname = "Injustice 2"
def smashtournament = "evo-2018"
def eventname = "injustice-2"

def reddit = true

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

def files = ["evo_2018"]
def idToPool = [:]
def idToSeed = [:]
def phaseToNextPhase = [:]

def phaseToPool = [:]

def srkToPool = [:]
def srkToSmash = [:]
def smashIdToAttendee = [:]
def poolToPhase = [:]
def poolToPhaseGroup = [:]

def poolnames = [] as Set

files.each { fname ->
    def file = new File("/Users/bbr/Desktop/newsmash/${fname}.csv")
    def rows = file.readLines()
    rows.each {
        def values = it.split(",")
        values = values.collect { it.replace("\"", "") }
        def id = values[0]
        def handle = values[3].trim().toLowerCase()
        def name = values[4].trim().toLowerCase()
        def game = values[8].trim().toLowerCase()
        def pool = values[11].trim().toLowerCase()
        def phase = values[9].trim().toLowerCase()
        def seed = values[13].trim().toLowerCase()
        def phaseId = values[16].trim().toLowerCase()
        def attendeeId = values[1].trim().toLowerCase()
        phaseToPool[phase] = pool
        smashIdToAttendee[id] = attendeeId
        poolToPhase[pool] = phaseId
        poolToPhaseGroup[pool] = phase
        def nextPhase = values[15].trim().toLowerCase()
        phaseToNextPhase[phase] = nextPhase
        if (game =~ smashname.toLowerCase()) {
            if (pool) idToPool[id] = pool
            if (seed) idToSeed[id] = seed
            poolnames << pool
            println "saved $id $name $handle $pool $game $seed $phase $nextPhase"
        }
    }
}

def top = getTopPlayers(gamename)
top.each { playernode ->
    def smashid = playernode.smashId as String
    if (smashid) {
        def pool = idToPool[smashid.toLowerCase()]
        if (pool) {
            println "$playernode.name $playernode.smashId $pool"
            srkToPool[playernode.id] = pool
            srkToSmash[playernode.id] = smashid
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
def groupByPool = srkToPool.groupBy { it.value }
def groups = groupByPool.collect { poolname, data ->
    def sum = 0
    def top32Count = 0
    def top50Count = 0
    def top100Count = 0
    def top250Count = 0
    def playerdata = data.collect { srkId, pool ->
        def smash = srkToSmash[srkId]
        def player = getPlayer(srkId)
        def name = player.name
        def country = player.country
        def rank = player.rankings[gamename].rank as Integer
        def weight = player.rankings[gamename].weight
        sum = sum + weight
        def seed = idToSeed[smash]
        if (rank <= 250) top250Count++
        if (rank <= 100) top100Count++
        if (rank <= 50) top50Count++
        if (rank <= 32) top32Count++
        "${rank} $name ($country) [weight: $weight] seed $seed"
        [name, country, weight, rank, seed, smash]
    }
    [poolname, sum, playerdata.size(), top32Count, top50Count, top100Count, top250Count, playerdata]
}

def foundpools = []

if (reddit) {
    println "| pool | sum | known | top100 | player | country | weight | rank | seed"
    println "| --- | --- | --- | --- | --- | --- | --- | --- | --- "
}

groups.sort { it[1] }.reverse().each {
    def poolname = it[0]
    foundpools << poolname
    def sum = it[1]
    def topsize = it[2]
    def top32Count = it[3]
    def top50Count = it[4]
    def top100Count = it[5]
    def top250Count = it[6]
    def players = it[7]

    if (!reddit) {
        def ptexts = players.collect {
            def pname = it[0]
            def pcountry = it[1]
            def pweight = it[2]
            def prank = it[3]
            def pseed = it[4]
            def psmash = it[5]
            return "$pname ($pcountry, weight $pweight, rank: $prank, seed: $pseed)"
        }
        def pstring = ptexts.join(" / ")
        println "$poolname, $sum, $topsize, $top100Count, $pstring"
    } else {
        def first = true
        players.each {
            def pname = it[0]
            def urlname = "[$pname](http://rank.shoryuken.com/rankings/player/byname/$pname)"
            def pcountry = it[1]
            def pweight = it[2]
            def prank = it[3]
            def pseed = it[4]
            def psmash = it[5]
            //tournament/evo-2018/events/injustice-2/brackets/204947/662690

            def smashurl = "[$poolname](https://smash.gg/tournament/${smashtournament}/events/${eventname}/brackets/${poolToPhase[poolname]}/${poolToPhaseGroup[poolname]}/)"
            if (first) {
                println "|$smashurl | $sum | $topsize | $top100Count | $urlname | $pcountry | $pweight | $prank | $pseed"
                first = false
            } else {
                println "| |  |  |  | $urlname | $pcountry | $pweight | $prank | $pseed"
            }
        }

    }
}

def notfound = poolnames - foundpools
if (!reddit) {
    notfound.each {
        println "$it, 0, 0, 0"
    }
} else {
    notfound.each {
        println "| $it | 0 | 0 | 0"
    }
}