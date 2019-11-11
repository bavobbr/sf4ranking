package be.bbr.sf4ranking

import be.bbr.sf4ranking.smash.SmashAttendee
import be.bbr.sf4ranking.smash.SmashEvent
import be.bbr.sf4ranking.smash.SmashPool
import be.bbr.sf4ranking.smash.SmashSeeding
import be.bbr.sf4ranking.smash.SmashTournament
import groovy.json.JsonSlurper

class SmashService {

    QueryService queryService

    private List<Player> getTopPlayers(Version game, Integer amount) {
        def players = queryService.findPlayers(null, null, amount, 0, game, RankingType.WEIGHT)
        return players
    }

    private Player getPlayer(Integer id) {
        return Player.findById(id)
    }

    public SmashTournament analyze(Version gamename, String smashname, String tournament, String mappings) {

        try {
            JsonSlurper slurper = new JsonSlurper()
            def testUrl = "https://api.smash.gg/tournament/$tournament".toURL()
            def testData = slurper.parse(testUrl)
            if (!testData) return null
        }
        catch (e) {
            log.error("Could not locate tournament $tournament", e)
            return null
        }


        def url = "https://api.smash.gg/tournament/$tournament/attendees"

        def phaseCache = [:]

        def getPhaseData = { Integer id ->
            if (phaseCache[id]) {
                return phaseCache[id]
            } else {
                JsonSlurper slurper = new JsonSlurper()
                def phaseurl = "https://api.smash.gg/phase_group/$id?expand[]=seeds&expand[]=groups".toURL()
                def phasedata = slurper.parse(phaseurl)
                phaseCache[id] = phasedata
                return phasedata
            }
        }

        List<SmashAttendee> attendees = []
        boolean hasNext = true
        def page = 1
        def perpage = 100

        while (hasNext) {
            def apiQuery = url + "?page=$page&per_page=$perpage"
            println "parsing page $apiQuery"
            def smashdata = apiQuery.toURL().text
            def data = new JsonSlurper().parseText(smashdata)
            def attendeeNodes = data.items.entities.attendee
            def attendeesBatch = attendeeNodes.collect { node ->
                def attendee = new SmashAttendee(name: node.player?.name, id: node.player?.id, gamertag: node.player?.gamerTag, country: node.player?.country, state: node.player?.state)
                attendee.attendeeId = node.id
                attendee.twitter = node.player?.twitterHandle
                attendee.tag = node.player?.prefix
                attendee.events = node.events?.collect {
                    def evt = new SmashEvent(name: it.name, id: it.id)
                    def entrant = node.entrants.find { it.eventId == evt.id }
                    evt.entrantId = entrant?.id
                    return evt
                }
                node.pools?.each { poolnode ->
                    def event = attendee.events.find { it.id == poolnode.eventId }
                    if (poolnode.phaseOrder == 1 || poolnode.phaseName == "Phase 1" || poolnode.phaseName == "Pools") {
                        def poolobj = new SmashPool(id: poolnode.phaseGroupId, name: poolnode.phaseName, group: poolnode.groupName, phaseId: poolnode.phaseId)
                        event.pools << poolobj
    /*                    def phasedata = getPhaseData(poolnode.phaseGroupId)
                        def entrantdata = phasedata.entities.seeds.find { it.entrantId == event.entrantId }
                        def groupdata = phasedata.entities.groups
                        event.seed = entrantdata.seedNum
                        poolobj.phaseSeed = entrantdata.groupSeedNum
                        poolobj.nextPhase = groupdata.winnersTargetPhaseId*/
                    }
                }
                println attendee
                return attendee
            }
            attendees.addAll(attendeesBatch.findAll { it.name && it.attendeeId })
            if (attendeesBatch) {
                page++
            } else {
                hasNext = false
            }
        }

        def gameAttendees = []

        println "Found ${attendees.size()} attendees"

        attendees.each {
            println it
            if (it.events.name.any { it.toLowerCase() =~ smashname.toLowerCase() }) {
                println "saved $it.id $it.name"
                gameAttendees << it
            }
        }

        def primarytop100 = getTopPlayers(gamename, 100)

        def nameToId = mappings?.readLines()?.collectEntries {
            def tokens = it.split(",")
            return [(tokens[0].toLowerCase()):tokens[1]]
        }
        if (!nameToId) nameToId = [:]
        primarytop100.each { p ->
            def lowername = p.name.toLowerCase()
            if (lowername in nameToId) {
                println "Overriding smash ID for $p and id $p.smashId with ${nameToId[lowername]}"
                p.smashId = nameToId[lowername]
            }
        }

        List<Player> topAttendees = []

        primarytop100.each { playernode ->
            def smashid = playernode.smashId as String
            if (smashid && smashid.toInteger() in gameAttendees.id) {
                def player = getPlayer(playernode.id as Integer)
                def name = player.name
                def country = player.countryCode
                def rank = player.rank(gamename)
                def main = (player.findRanking(gamename).mainCharacters[0].toString()) - "${gamename}_"
                main = main.replace("_", " ")
                println "$rank. $name ($country) ${main.toLowerCase()}"
                topAttendees << playernode
            }
        }
        SmashSeeding seeding = new SmashSeeding(players: topAttendees, game: gamename, event: smashname)
        SmashTournament smashTournament = new SmashTournament(tournament: tournament, seeding: seeding, attendees: attendees)
        return smashTournament
    }

}
