import groovy.json.JsonSlurper

def filedata = '''
Problem X
Luffy
Foxy Grampa
Afzal
Packz
Imstilldadaddy
Hurricane
Gibbo
Will2pac
Big fool
FairlySadPanda
Tyrant_uk
Afii
Cobelcog
Brickterium
King jae
Jester power
VF Watson
CCL
Ryan Hart
Takamura
'''


public Map<String, String> getPlayer(String name) {
    def game = "SF5"
    JsonSlurper slurper = new JsonSlurper()
    def ename = URLEncoder.encode(name, "UTF-8")
    def player = slurper.parse(("http://rank.shoryuken.com/api/player/name/"+ename).toURL())
    String main = player.rankings["$game"].main[0] - "${game}_"
    def sf5 = player.results.findAll { it.game == "$game"}
    def best = sf5.sort { it.score }.reverse().take(3).collect { [it.place, it.tournamentname] }
    return [name: name, ename: ename, twitter: player.twitter, rank: player.rankings["$game"].rank, country: player.country, main: main.toLowerCase(), best: best]
}


def top50 = filedata.readLines().collectMany { it.tokenize(",") }
println top50

def data = top50.findResults { p ->
    try { return getPlayer(p.trim()) }
    catch (e) { println "Couldnt find $p"}
}.sort { it.rank }
data.each { p ->
    def out =  "**[${p.rank}. ${p.name}](http://rank.shoryuken.com/rankings/player/byname/${p.ename})** (${p.main.capitalize()} from ${p.country})"
    if (p.twitter) {
        out = out + " [@${p.twitter}](https://twitter.com/${p.twitter})"
    }
    println out
    println " "
    p.best.each { t ->
        println "* (${t[0]}) ${t[1]- "- SF5"}"
    }
    println " "
}

