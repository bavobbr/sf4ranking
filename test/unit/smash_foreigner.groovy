import groovy.transform.Canonical
import groovy.transform.ToString
import groovy.transform.TupleConstructor

def file = new File("/Users/bbr/Desktop/newsmash/socal_regionals_2018.csv")

@TupleConstructor
@ToString
class Foreigner {
    String id
    String handle
    String name
    String twitter
    String game
    String country
    String attendeeId
}

def rows = file.readLines()
List<Foreigner> attendees = []
rows.each {
    def values = it.split(",")
    values = values.collect { it.replace("\"", "") }
    def id = values[0]
    def handle = values[3].trim().toLowerCase()
    def name = values[4].trim().toLowerCase()
    def twitter = values[7].trim().toLowerCase()
    def game = values[8].trim().toLowerCase()
    def country = values[5]
    def attendeeId = values[12]
    def foreigner = new Foreigner(id, handle, name, twitter, game, country, attendeeId)
    attendees << foreigner
}
println "IMPORTED names from $file"

def byGame = attendees.groupBy { it.game }
byGame.each {
    println "$it.key ${it.value.size()}"
}

byGame.each {
    def usa = it.value.count { it.country in ["United States", "US", "", "None"]}
    def diff = it.value.size() - usa
    def percentage = diff/usa
    println "$it.key,${it.value.size()},${usa},${diff},${percentage}"
}
