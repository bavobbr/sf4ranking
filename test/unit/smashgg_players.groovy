import groovy.json.JsonSlurper
import groovy.transform.ToString

def tournament = "final-round-2018"
def filename = tournament.replace("-", "_")+".csv"
def url = "https://api.smash.gg/tournament/$tournament/attendees"
//https://smash.gg/api/-/gg_api./tournament/evo-2017/attendees;filter={"gamerTag":"daigo"};

@ToString
class Attendee {
    String name
    String gamertag
    Integer id
    Integer attendeeId
    Integer participantId
    String country
    String state
    String twitter
    String tag
    List<Event> events = []
}

@ToString
class Event {
    Integer id
    String name
    List<Pool> pools = []
    Integer entrantId
}

@ToString
class Pool {
    Integer id
    String name
    String group
}

List<Attendee> attendees = []
boolean hasNext = true
def page = 1
def perpage = 100
Map<String, List<Attendee>> groupByEvent = [:]

while (hasNext) {
    def apiQuery = url+"?page=$page&per_page=$perpage"
    println "parsing page $apiQuery"
    def smashdata = apiQuery.toURL().text
    def data = new JsonSlurper().parseText(smashdata)
    def attendeeNodes = data.items.entities.attendee
    def attendeesBatch = attendeeNodes.collect { node ->
        def attendee = new Attendee(name: node.player.name, id: node.player.id, gamertag: node.player.gamerTag, country: node.player.country, state: node.player.state)
        attendee.attendeeId = node.id
        attendee.twitter = node.player.twitterHandle
        attendee.tag = node.player.prefix
        attendee.events = node.events.collect {
            def evt = new Event(name: it.name, id: it.id)
            def entrant = node.entrants.find { it.eventId == evt.id }
            evt.entrantId = entrant?.id
            return evt
        }
        node.pools.each { poolnode ->
            def event = attendee.events.find { it.id == poolnode.eventId }
            event.pools << new Pool(id: poolnode.phaseGroupId, name: poolnode.phaseName, group: poolnode.groupName)
        }
        println attendee
        return attendee
    }
    attendees.addAll(attendeesBatch)
    if (attendeesBatch) { page++ }
    else { hasNext = false }
}

println "[SUMMARY]"
println attendees.size()

def countByCountry = attendees.countBy { it.country }
def groupByCountry =  attendees.groupBy { it.country }
def sortByCountry = countByCountry.sort { a, b -> b.value <=> a.value }
println sortByCountry

println "[COUNTRIES]"
sortByCountry.each {
    println "$it.key, $it.value"
}

println "[PLAYERS PER COUNTRY]"
groupByCountry.sort {a,b -> b.value.size() <=> a.value.size() }.each {
    println "$it.key: ${it.value.collect { it.gamertag?: it.name }.join(",")}"
}

attendees.each { attendee ->
    attendee.events.each { event ->
        if (!groupByEvent.containsKey(event.name)) groupByEvent[event.name] = []
        groupByEvent[event.name] << attendee
    }
}

println "[GAMES]"
groupByEvent.each {
    def countGameByCountry =  it.value.countBy { it.country }
    println "$it.key, ${it.value.size()}, ${countGameByCountry.size()}"
}

def events = groupByEvent.keySet()
println "x , players, "+events.join(",")
groupByEvent.each { eventGroup ->
    def playerIds = eventGroup.value.collect { it.id }
    def overlap = events.collect { event ->
        def otherPlayersIds = groupByEvent[event].id
        def overlappingIds = playerIds.findAll { it in otherPlayersIds }
        return overlappingIds.size()
    }
    println "$eventGroup.key,${playerIds.size()},"+overlap.join(",")
}

println "[OVERLAP %]"
println "x , players, "+events.join(",")
groupByEvent.each { eventGroup ->
    def playerIds = eventGroup.value.collect { it.id }
    def overlap = events.collect { event ->
        def otherPlayersIds = groupByEvent[event].id
        def overlappingIds = playerIds.findAll { it in otherPlayersIds }
        return ((overlappingIds.size() / playerIds.size()))
    }
    println "$eventGroup.key,${playerIds.size()},"+overlap.join(",")
}

def groupByEventSize = attendees.groupBy { it.events.size() }
groupByEventSize.sort { a, b -> a.key <=> b.key }.each {
    println "$it.key, ${it.value.size()}"
}
groupByEventSize.each {
    println "$it.key: ${it.value.gamertag.join(',')}"
}

println "[DETAIL DATA]"

def file = new File("/Users/bbr/Desktop/newsmash/$filename")
file.delete()
file.withPrintWriter { writer ->
    attendees.each { p ->
        p.events.each {
            def tokens = [p.id?: "", p.attendeeId?: "", p.tag?:"", p.gamertag?:"", p.name?:"", p.country?:"", p.state?:"", p.twitter?:"", it.name?:"", it.pools[0]?.id?:"", it.pools[0]?.name?:"", it.pools[0]?.group?:"", it.entrantId]
            def clean = tokens.collect { it.toString().replace(",","-") }.collect { it.toString().replace("\"","'") }
            def quoted = clean.collect { "\"$it\"" }
            def line = quoted.join(",")
            writer.println(line)
        }
    }
}

