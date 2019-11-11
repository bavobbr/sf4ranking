import groovy.json.JsonSlurper

def gameversion = "DBFZ"
def smashgame = "dragon"

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

def folder = new File("/Users/bbr/Desktop/newsmash")
def files = folder.listFiles({dir, name -> name.endsWith(".csv")} as FilenameFilter)
files = files.sort { it.lastModified() }
println "Processing files in order: ${files*.name}"


def nameToId = [:]
def handleToId = [:]
def handleJoinToId = [:]
def twitterToId = [:]

def srkToId = [:]
def cache = [:]

def idToName = [:]
def idToHandle = [:]

files.sort { it.lastModified() }.each { file ->
    println "Processing $file"
    def counter = 0
    def rows = file.readLines()
    rows.each {
        def values = it.split(",")
        values = values.collect { it.replace("\"", "") }
        def id = values[0]
        def handle = values[3].trim().toLowerCase()
        def handlespaces = handle.replace("_"," ")
        def handlejoin = handlespaces.replace(" ","")
        def name = values[4].trim().toLowerCase()
        def twitter = values[7].trim().toLowerCase()
        def game = values[8].trim().toLowerCase()
        if (game =~ /melee/ || game =~ /smash/ || !(game.toLowerCase() =~ smashgame.toLowerCase())) return
        if (name) nameToId[name] = id
        if (handle) handleToId[handle] = id
        if (handlejoin) handleJoinToId[handlejoin] = id
        if (twitter) twitterToId[twitter] = id
        if (name) idToName[id] = name
        if (handle) idToHandle[id] = handle
        println "saved $id $name $handle $twitter from $file.name"
        counter++
    }
    println "IMPORTED $counter names from $file.name"
}

println nameToId.size()
println handleToId.size()
println handleJoinToId.size()
println twitterToId.size()

println nameToId
println handleToId
println handleJoinToId
println twitterToId

def top100 = getTopPlayers(gameversion)
top100.each { playernode ->
    println playernode
    def player = getPlayer(playernode.id)
    def twitter = player.twitter as String
    def name = player.name as String
    def fullname = player.fullname as String
    def smashId = player.smashId as String
    def rank = player.rankings[gameversion].rank as String
    if (smashId) {
        println "skipping existing $name $smashId"
        cache["${rank}.${name}"] = smashId
    }
    def fullnamereverse = null
    if (fullname && fullname.split(" ").size() > 1) {
        fullnamereverse = fullname.split(" ").reverse().join(" ")
    }
    if (twitter) {
        def match = twitterToId[twitter.toLowerCase()]
        if (match) {
            println "$playernode.name $playernode.twitter $match"
            srkToId["${rank}.${name}"] = match
            return
        }
    }
    if (name) {
        def match = handleToId[name.toLowerCase()]
        if (match) {
            println "$playernode.name $match"
            srkToId["${rank}.${name}"] = match
            return
        }
        else {
            match = handleJoinToId[name.toLowerCase().replace(" ", "").replace("_", "")]
            if (match) {
                println "$playernode.name $match"
                srkToId["${rank}.${name}"] = match
                return
            }
        }
    }
    if (fullname) {
        def match = nameToId[fullname.toLowerCase()]
        if (match) {
            println "$playernode.name $playernode.fullname $match"
            srkToId["${rank}.${name}"] = match
            return
        }
    }
    if (fullnamereverse) {
        def match = nameToId[fullname.toLowerCase()]
        if (match) {
            println "$playernode.name $playernode.fullname $match"
            srkToId["${rank}.${name}"] = match
            return
        }
    }
}

println "matches"
srkToId.each {
    def cached = cache[it.key]
    if (cached && cached != it.value) {
        def sname = idToName[it.value]
        def shandle = idToHandle[it.value]
        println "$it [$cached] as $sname [$shandle]"
    }
    else if (cached) {
        //println "$it (*)"
    }
    else {
        def sname = idToName[it.value]
        def shandle = idToHandle[it.value]
        println "$it as $sname [$shandle]"
    }
}
println srkToId.size()