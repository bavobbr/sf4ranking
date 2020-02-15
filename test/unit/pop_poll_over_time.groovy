import groovy.json.JsonSlurper
import org.joda.time.DateTime

import java.nio.charset.StandardCharsets
import java.text.SimpleDateFormat

def files = new File("/Users/bbr/csv").listFiles().sort { it.lastModified() }.reverse()

def splitTokens = { String line ->
    String[] tokens = line.split(',(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)', -1)
    return tokens.toList()
}

def startDate = new DateTime().withDayOfMonth(1).withMonthOfYear(1).withYear(2014)

Map<DateTime, Map<String, Integer>> alldata = [:]

Set<String> allplayers = [] as HashSet


files.each {
    def map = [:]
    println it.name
    def content = it.readLines()
    def data = content[7..31]
    data.each {
        def tokens = splitTokens(it)
        def name = tokens[0]-"/"
        def count = tokens[1].replaceAll(/"/, "").replaceAll(",","").toInteger()
        map[name] = count
        allplayers.add(name)
    }
    println map
    alldata[startDate] = map
    startDate = startDate.plusMonths(3)
}

alldata.each { k, v ->
    println "$k -> $v"
    allplayers.each {
        if (!v[it]) {
            v[it] = 0
        }
    }
}

def order = alldata.keySet().sort()
def df = new SimpleDateFormat("yyyy-MM")

def header  = "name,country,img," + order.collect { df.format(it.toDate())}.join(",")
println header

allplayers.each { pname ->

    def name = URLEncoder.encode(pname, StandardCharsets.UTF_8.toString())
    def pdata = new JsonSlurper().parse("http://rank.shoryuken.com/api/player/name/$name".toURL())
    def region = pdata.country
    def img = "http://rank.shoryuken.com/static/images/countries/${region?.toLowerCase()}.png"

    def row = "$pname,$region,$img,"
    order.each {
        def map = alldata[it]
        row = row + map[pname] +","
    }
    println row
}






