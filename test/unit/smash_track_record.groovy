import groovy.json.JsonSlurper
import groovy.transform.ToString

gamename = "SF5"
//smashgamename = "Street Fighter V"
smashtournament = "evo-2018"
datasource = "evo_2018"
smasheventid = 101722
entrantToName = [:]

class AttendeeTrackData {
    List<AttendeePool> pools = []
    String name
    Integer id
    Integer placement
}

class AttendeeTrackPool {
    AttendeeData attendee
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
class PhaseTrackSet {
    String id
    Integer phaseGroupId
    Integer winnerId
    String winnerName
    Integer loserId
    String loserName
    Integer round
    boolean winnersBracket
    boolean finished = false
    boolean win
    AttendeePool pool
    boolean complete = false
}


public def getPlayer(String name) {
    JsonSlurper slurper = new JsonSlurper()
    def player = slurper.parse("http://rank.shoryuken.com/api/player/byname/${name}".toURL())
    return player
}


public AttendeeData getAttendeedata(Integer id, String name) {
    JsonSlurper slurper = new JsonSlurper()
    def url = "https://api.smash.gg/tournament/$smashtournament/attendees/$id".toURL()
    //println "attendee url $url"
    try {
        def attendeedata = slurper.parse(url)
        def pools = attendeedata.entities.attendee[0].pools
        def entrants = attendeedata.entities.attendee[0].entrants.id
        //println "entrants: $entrants"
        //println entrantId
        def entrantData = attendeedata.entities.attendee[0].entrants.find { it.eventId == smasheventid }
        if (entrantData) {

            pools = pools.findAll { it.eventId == smasheventid }.findAll { !(it.phaseName =~ /DEATHPOOL/) }
            def poolobjects = pools.collect {
                def ap = new AttendeeTrackPool(phase: it.phaseName, id: it.phaseGroupId, pool: it.groupName, order: it.phaseOrder, projected: it.projected, entrantIds: entrants)
                return ap
            }

            def placement = entrantData?.finalPlacement
            def attendeeobject = new AttendeeTrackData(name: name, id: id, pools: poolobjects, placement: placement)
            poolobjects.each { it.attendee = attendeeobject }
            return attendeeobject
        }
        else return null
    } catch (e) {
        //println "Couldnt fetch data for $id $name: $e"
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
        def pset = new PhaseTrackSet()
        pset.id = it.bracketId
        pset.phaseGroupId = it.phaseGroupId
        pset.winnerId = it.winnerId
        pset.winnerName = entrantToName[it.winnerId]
        pset.loserId = it.loserId
        pset.loserName = entrantToName[it.loserId]
        pset.round = it.round
        if (pset.winnerId) pset.finished = true
        else pset.finished = false
        if (pset.winnerId in playerIds) pset.win = true
        if (it.midRoundText =~ /Winner/) pset.winnersBracket = true
        else pset.winnersBracket = false
        pset.pool = pool
        pset.complete = it.entrant1Id && it.entrant2Id
        return pset
    }.findAll { it.complete }
}

def file = new File("/Users/bbr/Desktop/newsmash/${datasource}.csv")
def rows = file.readLines()
attendeeMapping = rows.collectEntries {
    def values = it.split(",")
    values = values.collect { it.replace("\"", "") }
    def id = values[0]
    def attendeeId = values[1]
    [id,attendeeId]
}
entrantToName = rows.collectEntries {
    def values = it.split(",")
    values = values.collect { it.replace("\"", "") }
    def name = values[3]
    def entrantId = values[12]
    if (entrantId == "null") entrantId = "-1"
    [entrantId.toInteger(),name]
}

def players = ["Tokido"]
def top100 = players.collect { getPlayer(it) }

top100.each { playernode ->
    def smashid = playernode["smashId"] as String
    if (smashid && attendeeMapping[smashid] ) {
        println "getting data of $playernode"
        def data = getAttendeedata(smashid as Integer, playernode["name"])
        data.pools.each { pool ->
            println "Pool $pool.id $pool.phase"
            pool.sets.each { set ->
                println "[$set.winnerName beat $set.loserName]"
            }
        }
    }
}