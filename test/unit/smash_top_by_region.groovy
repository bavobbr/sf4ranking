import be.bbr.sf4ranking.CountryCode
import groovy.json.JsonSlurper

def gamename = "GGXRD"
def smashname = "Guilty Gear Xrd REV2"
def smashtournament = "evo-2018"
def useCpt = false


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
def smashids = []
def smashIdToPool = [:]
def smashIdToAttendee = [:]

files.each { fname ->
    def file = new File("/Users/bbr/Desktop/newsmash/${fname}.csv")
    def rows = file.readLines()
    rows.each {
        def values = it.split(",")
        values = values.collect { it.replace("\"", "")}
        def id = values[0]
        def game = values[8].trim().toLowerCase()
        def name = values[4].trim().toLowerCase()
        def pool = values[11].trim().toLowerCase()
        def attendeeId = values[1].trim().toLowerCase()
        if (game =~ smashname.toLowerCase()) {
            println "saved $name $id $game"
            smashids << id
            smashIdToPool[id] = pool
            smashIdToAttendee[id] = attendeeId
        }
    }
}

def top100 = getTopPlayers(gamename)

def results = top100.findResults { playernode ->
    def smashid = playernode.smashId as String
    if (smashid && smashid in smashids) {
        def player = getPlayer(playernode.id)
        def name = player.name
        def country = player.country
        def rank = player.rankings[gamename].rank
        def score = player.rankings[gamename].score
        def weight = player.rankings[gamename].weight
        def main = (player.rankings[gamename].main[0]) - "${gamename}_"
        def teams = player.teams.join(" / ")
        main = main.replace("_", " ")
        ////def main = (player.rankings[gamename].main.join("/"))
        def cptRank = player.cptRank
        //println "$rank. $name ($country) ${main.toLowerCase()} ($cptScore)"
        println "$rank. $name ($country) ${main.toLowerCase()}"
        def countryCode = country as CountryCode
        def region = null
        if (countryCode) region = countryCode.region
        return [region, rank, name, countryCode, main.toLowerCase(), score, weight, cptRank, teams, smashid]
    }
    return null
}

def groupByRegion = results.groupBy { it[0] }
groupByRegion.each { def region, players ->
    println "\n[$region]"
    println "----"
    println " "
    if (useCpt) {
        println "| rank | name | pool | team | country | main | srk score | cpt rank | weight |"
        println "| ---- | ---- | -----| --- | ------- | ----- | --------- | ------ | --- |"
    } else {
        println "| rank | name | pool | team | country | main | srk score | weight |"
        println "| ---- | ---- | -----| --- | ------- | ----- | ---------  | --- |"
    }

    //println "---- | ---- | -----| ------- | ----- | --------- | ------ | --------"
    players.sort { it[1] }.take(100).each {
        def srkrank = it[1]
        def name = it[2]
        def urlname = "[$name](http://rank.shoryuken.com/rankings/player/byname/$name)"
        def country = it[3]
        def pchar = it[4]
        def srkscore = it[5]
        def weight = it[6]
        def cptRank = it[7]
        def teams = it[8]
        if (teams && teams.size() > 16) {
            teams = teams[0..16]
        }

        def smashId = it[9]
        def details = "country: $country, char: $pchar, cpt: $cptRank, weight: ${weight}"
        def attendeeId = smashIdToAttendee[smashId]
        def poolId = smashIdToPool[smashId]
        def smashurl = "[$poolId](https://smash.gg/tournament/${smashtournament}/attendee/${attendeeId})"

        //print "${srkrank}. ".padLeft(5)
        //print "$name".padRight(20)
        //println details
        if (useCpt) {
            println "| $srkrank | $urlname | $smashurl | ${teams} | $country | $pchar | $srkscore | $cptRank | $weight |"
        } else {
            println "| $srkrank | $urlname | $smashurl | ${teams} | $country | $pchar | $srkscore | $weight |"
        }
    }

}