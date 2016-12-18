import be.bbr.sf4ranking.CharacterType
import groovy.json.JsonSlurper

def ids = ["Ryan Hart", "Sako","Kazunoko", "GO1", "Mago", "Eita", "Haitani",
           "Momochi", "Daigo Umehara", "MOV", "Fuudo", "Tokido", "Yukadon",
           "XsK Samurai", "Ricki Ortiz", "Chris Tatarian", "Filipino Champ", "Julio Fuentes", "NuckleDu", "Justin Wong", "K-brad",
           "Problem X", "Mister Crimson", "Luffy", "DR Ray", "Brolynho",
           "Humanbomb", "Xian", "Phenom", "GamerBee", "Xiaohai", "Infiltration"]


def usages = ids.collectEntries {
    def player = getPlayer(it)
    println player.name
    def chars = player.results.findResults {
        if (it.game == "SF5") {
            def tournament = getTournament(it.tournament)
            if (tournament.cpt && tournament.cpt != "NONE") {
                return it.characters.flatten().collect { CharacterType.valueOf(it).shortname }
            }
        }
    }.flatten()
    return [(player.name) : chars.countBy { it }.sort { a,b -> b.value <=> a.value }]
}

def charToPlayer = [:]
usages.each {
    def chars = it.value
    def player = it.key
    chars.each {
        if (!charToPlayer[it.key]) charToPlayer[it.key] = [] as Set
        charToPlayer[it.key] << player
    }
}
charToPlayer.sort { }.each {
    println "$it.key, ${it.value.size()}, ${it.value.join(" | ")}"
}

def mains = usages.collectEntries { k, v -> [(k): v.keySet().first()] }
println "mains"
def charToPlayerMain = [:]
mains.each {
    def chars = it.value
    def player = it.key
    if (!charToPlayerMain[chars]) charToPlayerMain[chars] = [] as Set
    charToPlayerMain[chars] << player

}
charToPlayerMain.each {
    println "$it.key, ${it.value.size()}, ${it.value.join(" | ")}"
}


public Map<String, String> getPlayer(String name) {
    name = URLEncoder.encode(name)
    JsonSlurper slurper = new JsonSlurper()
    return slurper.parse("http://rank.shoryuken.com/api/player/name/${name}".toURL())
}
public Map<String, String> getTournament(Integer id) {
    return new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/id/$id".toURL())
}


