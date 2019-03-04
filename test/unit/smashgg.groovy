import groovy.json.JsonSlurper


def tournament = "never-give-up-2018"
def event = "street-fighter-v-ae-capcom-pro-tour-ranking-latam"

def url = "https://api.smash.gg/tournament/$tournament/event/$event/standings?entityType=event&expand[]=entrants&mutations=playerData&per_page=64"
def content = url.toURL().text

def data = new JsonSlurper().parseText(content)

println data

def entrants = data.items.entities.entrants
def results = entrants.collect {
    def name = it.name
    def placement = it.finalPlacement
    def smashId = it.playerIds.values().first()
    def srkplayername = null
    try {
        def srkplayer = new JsonSlurper().parse("http://rank.shoryuken.com/api/player/smash/$smashId".toURL())
        if (srkplayer) {
            srkplayername = srkplayer.name
        }
    }
    catch (e) {}
    println "$placement, $name, $smashId, $srkplayername"
    [name: name, srk: srkplayername, smash: smashId, place: placement]
}
results.sort { it.place }.each {
    def pname = it.srk?: it.name
    println "${it.place}. ${pname}"
}