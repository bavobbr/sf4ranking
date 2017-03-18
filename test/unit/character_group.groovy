import groovy.json.JsonSlurper

def tid = 1448
def url = "http://rank.shoryuken.com/api/tournament/id/$tid"

def tdata = new JsonSlurper().parse(url.toURL())
def charlist = tdata.results.collect {
    it.characters.first().first()
}
def counts = charlist.countBy { it }
counts.sort { a1, a2 -> a2.value <=> a1.value}.each { k, v ->
    println "${k-'SF5_'}: ${v}"
}