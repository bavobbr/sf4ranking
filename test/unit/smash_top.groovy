import groovy.json.JsonSlurper

def gamename = "DBFZ"
def smashname = "Dragon Ball FighterZ"

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

def files = ["combo_breaker_2018_1"]
def smashids = []

def entries = []

files.each { fname ->
    def file = new File("/Users/bbr/Desktop/newsmash/${fname}.csv")
    def rows = file.readLines()
    rows.each {
        println it
        def values = it.split(",")
        values = values.collect { it.replace("\"", "")}
        def id = values[0]
        def game = values[8].trim().toLowerCase()
        def name = values[4].trim().toLowerCase()
        def country = values[5].trim().toLowerCase()
        if (game =~ smashname.toLowerCase()) {
            println "saved $name $id $game"
            smashids << id
        }
        if (!(game =~ /ladder/)) {
            entries << [id: id, game: game, name: name, country: country]
        }
    }
}

def top100 = getTopPlayers(gamename)

def ranks = []
def cptranks = []
def scores = []
def cptscores = []

top100.collect { playernode ->
    def smashid = playernode.smashId as String
    if (smashid && smashid in smashids) {
        def player = getPlayer(playernode.id)
        def name = player.name
        def country = player.country
        def rank = player.rankings[gamename].rank
        def cptRank = player.cptRank?: 0
        def score = player.rankings[gamename].score?: 0
        def main = (player.rankings[gamename].main[0]) - "${gamename}_"
        main = main.replace("_", " ")
        ////def main = (player.rankings[gamename].main.join("/"))
        def cptScore = player.cptScore?: 0
        //println "$rank. $name ($country) ${main.toLowerCase()} ($cptScore)"
        println "$rank. $name ($country) ${main.toLowerCase()}"
        ranks << rank
        cptranks << cptRank
        cptscores << cptScore
        scores << score
    }
}

def totalEntries = entries.size()
def totalPlayers = entries.unique { it.id }.size()
def totalCountries = entries.unique { it.country }.size()
def totalGames = entries.unique { it.game }.size()
def knownPlayers = ranks.size()
def top32Count = ranks.count { it <= 32 }
def top50Count = ranks.count { it <= 50 }
def top100Count = ranks.count { it <= 100 }
def lowestRank = ranks.min()
def top32Share = top32Count/32*100
def top50Share = top50Count/50*100
def top100Share = top100Count

def top32CountCpt = cptranks.count { it > 0 && it <= 32 }
def top50CountCpt = cptranks.count { it > 0 && it <= 50 }
def top100CountCpt = cptranks.count { it > 0 && it <= 100 }
def lowestRankCpt = cptranks.min()
def top32ShareCpt = top32CountCpt/32*100
def top50ShareCpt = top50CountCpt/50*100
def top100ShareCpt = top100CountCpt

def line = [totalEntries, totalPlayers, totalCountries, totalGames, knownPlayers,
            top32Count, top50Count, top100Count, lowestRank, top32Share, top50Share,
            top100Share, top32CountCpt, top50CountCpt, top100CountCpt, lowestRankCpt,
            top32ShareCpt, top50ShareCpt, top100ShareCpt]
def header = ["Entries", "Players", "Countries", "Games", "Top players",
              "Top32", "Top50", "Top100", "Lowest", "Top32 %",
              "Top50 %", "Top100 %", "Top32 CPT", "Top 50 CPT",
              "Top 100 CPT", "Lowest CPT", "Top32 % CPT", "Top50 % CPT", "Top 100 % CPT"]
println header.join(", ")
println line.join(", ")