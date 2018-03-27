import groovy.json.JsonSlurper
import groovy.transform.ToString

gamename = "SF5"
//smashgamename = "Street Fighter V"
smashtournament = "tgu-2018"
datasource = "tgu_2018"
reddit = false
smasheventid = 84277

def extra = ["fubarduck", "jeondding", "Aziz XIV"]

class AttendeePool {
    String name
    Integer id
    String phase
    String pool
    Integer order
    boolean projected
    List<Integer> entrantIds = []
    List<PhaseSet> sets = []
    boolean finished = false
    boolean winners = false
    boolean eliminated = false
}

@ToString
class PhaseSet {
    String id
    Integer phaseGroupId
    Integer winnerId
    Integer loserId
    Integer round
    boolean winnersBracket
    boolean finished = false
    boolean win
    AttendeePool pool
}

public List<String> getTopPlayers(String game) {
    JsonSlurper slurper = new JsonSlurper()
    def top100 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=0".toURL())
    def top200 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=100".toURL())
    def top300 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=200".toURL())
    def top400 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=300".toURL())
    def top500 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=100&offset=400".toURL())
    //def top300 = slurper.parse("http://rank.shoryuken.com/api/top?game=${game}&format=json&size=50&offset=200".toURL())
    //return top100 + top200 + top300
    return top100 + top200 + top300 + top400+top500
}

public def getPlayer(String name) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/byname/${name}".toURL())
    return player
}


public List<AttendeePool> getAttendeedata(Integer id, String name) {
    JsonSlurper slurper = new JsonSlurper()
    def url = "https://api.smash.gg/tournament/$smashtournament/attendees/$id".toURL()
    //println "attendee url $url"
    try {
        def attendeedata = slurper.parse(url)
        def pools = attendeedata.entities.attendee[0].pools
        def entrants = attendeedata.entities.attendee[0].entrants.id
        //println "entrants: $entrants"
        //println entrantId
        pools = pools.findAll { it.eventId == smasheventid }
        pools.collect {
            def ap = new AttendeePool(name: name, phase: it.phaseName, id: it.phaseGroupId, pool: it.groupName, order: it.phaseOrder, projected: it.projected, entrantIds: entrants)
            return ap
        }
    } catch (e) {
        println "Couldnt fetch data for $id $name: $e"
        return null
    }
}

public List<PhaseSet> getPhaseData(Integer id, List<Integer> playerIds, AttendeePool pool) {
    //https://api.smash.gg/phase_group/178064?expand%5B%5D=sets&expand%5B%5D=standings&expand%5B%5D=selections
    JsonSlurper slurper = new JsonSlurper()
    def url = "https://api.smash.gg/phase_group/$id?expand[]=sets".toURL()
    //println "gettting $id $playerIds from $url"
    def phasedata = slurper.parse(url)
    def sets = phasedata.entities.sets
    //println sets
    def playersets = sets.findAll { it.entrant1Id in playerIds || it.entrant2Id in playerIds }
    return playersets.collect {
        def pset = new PhaseSet()
        pset.id = it.bracketId
        pset.phaseGroupId = it.phaseGroupId
        pset.winnerId = it.winnerId
        pset.loserId = it.loserId
        pset.round = it.round
        if (pset.winnerId) pset.finished = true
        else pset.finished = false
        if (pset.winnerId in playerIds) pset.win = true
        if (it.midRoundText =~ /Winner/) pset.winnersBracket = true
        else pset.winnersBracket = false
        pset.pool = pool
        return pset
    }
}

def file = new File("/Users/bbr/Desktop/newsmash/${datasource}.csv")
def rows = file.readLines()
def attendeeMapping = rows.collectEntries {
    def values = it.split(",")
    values = values.collect { it.replace("\"", "") }
    def id = values[0]
    def attendeeId = values[1]
    [id,attendeeId]
}


def top100 = getTopPlayers(gamename)
def top100b = getTopPlayers(gamename)
top100b.each { pb ->
    println "checking $pb"
    if (!top100.find { it.name == pb.name }) {
        top100.add(pb)
        println "adding $pb"
    }
}
top100 = top100.sort { it.rank }
extra.each {
    top100.add(getPlayer(it))
}
if (reddit) {
    //println "| rank | player | country | round 1 | round 2 | semis | finals |"
    println "| rank | player | country | round 1 | semis | finals |"
    //println "| ---  | --- | --- | --- | --- | --- | --- |"
    println "| ---  | --- | --- | --- | --- | --- |"
}

top100.each { playernode ->
    def smashid = playernode.smashId as String
    if (smashid && attendeeMapping[smashid] ) {
        //println "getting data of $playernode"
        def data = getAttendeedata(smashid as Integer, playernode.name)
        if (data) {
            def sorted = data.sort { it.order }
            def phases = sorted.each {
                def phase = getPhaseData(it.id, it.entrantIds, it)
                it.sets = phase
            }
            def round1 = phases.find { it.order == 1 }
            def round2 = phases.find { it.order == 2 }
            def round3 = phases.find { it.order == 3 }
            def round4 = phases.find { it.order == 4 }
            //println "[$playernode.name]"
            round1.each {
                //println it.phase
                it.sets.each {
                    //println "   win: $it.win winners: $it.winnersBracket done: $it.finished"
                }
            }
            round2.each {
                //println it.phase
                it.sets.each {
                    //println "   win: $it.win winners: $it.winnersBracket done: $it.finished"
                }
            }

            def r1done = round1?.sets?.findAll { it.finished }
            def r2done = round2?.sets?.findAll { it.finished }
            def r3done = round3?.sets?.findAll { it.finished }
            def r4done = round4?.sets?.findAll { it.finished }

            def pname = playernode.name
            //println pname

            if (r1done?.every { it.winnersBracket && it.win }) round1.winners = true
            if (r2done?.every { it.winnersBracket && it.win }) round2.winners = true
            if (r3done?.every { it.winnersBracket && it.win }) round3.winners = true
            if (r4done?.every { it.winnersBracket && it.win }) round4.winners = true

            if (round1?.sets?.any { !it.winnersBracket && it.finished }) round1.winners = false
            if (round2?.sets?.any { !it.winnersBracket && it.finished }) round2.winners = false
            if (round3?.sets?.any { !it.winnersBracket && it.finished }) round3.winners = false
            if (round4?.sets?.any { !it.winnersBracket && it.finished }) round4.winners = false

            if (round2?.sets?.size() > 0) round1.finished = true
            if (round3?.sets?.size() > 0) round2.finished = true
            if (round4?.sets?.size() > 0) round3.finished = true

            if (r1done?.findAll { !it.winnersBracket }?.any { !it.win }) round1.eliminated = true
            if (r2done?.findAll { !it.winnersBracket }?.any { !it.win }) round2.eliminated = true
            if (r3done?.findAll { !it.winnersBracket }?.any { !it.win }) round3.eliminated = true
            if (r4done?.findAll { !it.winnersBracket }?.any { !it.win }) round4.eliminated = true

            def r1state = ""
            if (round1?.sets) {
                if (reddit) {
                    if (round1.winners && round1.finished) r1state = "winners done" // winners
                    if (!round1.winners && round1.finished) r1state = "losers done" // losers
                    if (round1.winners && !round1.finished) r1state = "winners ongoing" // winners ongoing
                    if (!round1.winners && !round1.finished) r1state = "losers ongoing" // losers ongoing
                    if (round1.eliminated) r1state = "eliminated" // out
                } else {
                    if (round1.winners && round1.finished) r1state = "1000" // winners
                    if (!round1.winners && round1.finished) r1state = "250" // losers
                    if (round1.winners && !round1.finished) r1state = "500" // winners ongoing
                    if (!round1.winners && !round1.finished) r1state = "125" // losers ongoing
                    if (round1.eliminated) r1state = "-1" // out
                }
            }

            def r2state = ""
            if (round2?.sets) {
                if (reddit) {
                    if (round2.winners && round2.finished) r2state = "winners done" // winners
                    if (!round2.winners && round2.finished) r2state = "losers done" // losers
                    if (round2.winners && !round2.finished) r2state = "winners ongoing" // winners ongoing
                    if (!round2.winners && !round2.finished) r2state = "losers ongoing" // losers ongoing
                    if (round2.eliminated) r2state = "eliminated" // out
                } else {
                    if (round2.winners && round2.finished) r2state = "1000" // winners
                    if (!round2.winners && round2.finished) r2state = "250" // losers
                    if (round2.winners && !round2.finished) r2state = "500" // winners ongoing
                    if (!round2.winners && !round2.finished) r2state = "125" // losers ongoing
                    if (round2.eliminated) r2state = "-1" // out
                }

            }

            def r3state = ""
            if (round3?.sets) {
                if (reddit) {
                    if (round3.winners && round3.finished) r3state = "winners done" // winners
                    if (!round3.winners && round3.finished) r3state = "losers done" // losers
                    if (round3.winners && !round3.finished) r3state = "winners ongoing" // winners ongoing
                    if (!round3.winners && !round3.finished) r3state = "losers ongoing" // losers ongoing
                    if (round3.eliminated) r3state = "eliminated" // out
                } else {
                    if (round3.winners && round3.finished) r3state = "1000" // winners
                    if (!round3.winners && round3.finished) r3state = "250" // losers
                    if (round3.winners && !round3.finished) r3state = "500" // winners ongoing
                    if (!round3.winners && !round3.finished) r3state = "125" // losers ongoing
                    if (round3.eliminated) r3state = "-1" // out
                }

            }

            def r4state = ""
            if (round4?.sets) {
                if (reddit) {
                    if (round4.winners && round4.finished) r4state = "winners done" // winners
                    if (!round4.winners && round4.finished) r4state = "losers done" // losers
                    if (round4.winners && !round4.finished) r4state = "winners ongoing" // winners ongoing
                    if (!round4.winners && !round4.finished) r4state = "losers ongoing" // losers ongoing
                    if (round4.eliminated) r4state = "eliminated" // out
                } else {
                    if (round4.winners && round4.finished) r4state = "1000" // winners
                    if (!round4.winners && round4.finished) r4state = "250" // losers
                    if (round4.winners && !round4.finished) r4state = "500" // winners ongoing
                    if (!round4.winners && !round4.finished) r4state = "125" // losers ongoing
                    if (round4.eliminated) r4state = "-1" // out
                }

            }

            if (round1) {
                if (reddit) {
                    def name = round1.name
                    if (round1.eliminated || round2?.eliminated || round3?.eliminated || round4?.eliminated) {
                        name = "~~" + name + "~~"
                    } else if (!round1.winners || (r2done && !round2.winners) || (r3done && !round3.winners) || (r4done && !round4.winners)) {
                        name = "*" + name + "*"
                    } else if (round1.winners) {
                        name = "**" + name + "**"
                    }

                    def urlname = "[$name](http://rank.shoryuken.com/rankings/player/byname/$round1.name)"
                    def smashurl = "[(results)](https://smash.gg/tournament/${smashtournament}/attendee/${attendeeMapping[smashid]})"
                    def rank = playernode.rank

                    //println "| $rank | $urlname $smashurl | $playernode.country | ${r1state.toLowerCase()} | ${r2state.toLowerCase()} | ${r3state.toLowerCase()} | ${r4state.toLowerCase()} |"
                    println "| $rank | $urlname $smashurl | $playernode.country | ${r1state.toLowerCase()} | ${r2state.toLowerCase()} | ${r3state.toLowerCase()} |"
                } else {
                    def rank = playernode.rank
                    println "$rank, $round1.name, $playernode.country, $r1state, $r2state, $r3state, $r4state"
                }
            }
        }

    }
}