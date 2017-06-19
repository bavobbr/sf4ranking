import groovy.json.JsonSlurper

def filedata = '''
Forever King (Batman, Black Adam) 
Whiteboi (Scarecrow)
Slayer (Aquaman, Superman, Black Adam) vs. 
Dragon (Aquaman, Poison Ivy)
Theo (Superman) vs. 
Iluusions (Batman, Green Arrow, Deadshot, Black Adam)
Madzin (Atrocitus, Bane, Darkseid) vs. 
SonicFox (Black Adam, Darkseid)
Biohazard (Harley Quinn, Bane)
Semiij (Catwoman)
SylverRye (Batman, Aquaman)
Hayatei (Robin)
Burrito Voorhees (Black Adam, Bane)
MenaRD (Black Adam)
Tekken Master (Atrocitus, Black Adam)
Coach Steve (Atrocitus, Gorilla Grodd)
DR Gross (Green Lantern)
DJT (Green Lantern, Atrocitus)
Grr (Bane)
Foxy Grampa (Deadshot, Catwoman)
StarCharger (Catwoman)
VIKING305 (Atrocitus)
REO (Catwoman)
Scar (Superman)
Kitana Prime (Harley Quinn, Wonder Woman)
Alucard (Aquaman)
Lord Pnut (Dr. Fate)
DEG (Harley Quinn)
Rico Suave (Black Adam)
KevoDaMan1105 (Black Adam, Superman)
Buffalo (Superman)
Mattix
'''

public Map<String, String> getPlayer(String name) {
    def game = "MKX"
    JsonSlurper slurper = new JsonSlurper()
    def ename = URLEncoder.encode(name, "UTF-8")
    def player = slurper.parse(("http://rank.shoryuken.com/api/player/name/"+ename).toURL())
    String main = player.rankings["$game"].main[0] - "${game}_"
    def sf5 = player.results.findAll { it.game == "$game"}
    def best = sf5.sort { it.score }.reverse().take(3).collect { [it.place, it.tournamentname] }
    return [name: name, ename: ename, twitter: player.twitter, rank: player.rankings["$game"].rank, country: player.country, main: main.toLowerCase(), best: best]
}


def top50 = filedata.readLines().collectMany { it.tokenize("/") }
println top50

def data = top50.findResults { p ->
    try {
        def tokens = p.tokenize(/\(/)
        def name = tokens[0]
        return getPlayer(name.trim())
    }
    catch (e) { println "Couldnt parse $p due to $e"; return null}
}.sort { it.rank }
/**
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
 **/

def ps = data.collect { p ->
    "(${p.rank}) ${p.name} /${p.main.capitalize()}/ [${p.country}]"
}
ps.collate(1).each {
    println it.join(" | ")
}
