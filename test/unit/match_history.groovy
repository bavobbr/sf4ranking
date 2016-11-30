import groovy.util.slurpersupport.GPathResult
import org.htmlcleaner.CleanerProperties
import org.htmlcleaner.HtmlCleaner
import org.htmlcleaner.PrettyXmlSerializer
import org.htmlcleaner.TagNode


def p1 = 39
def p2 = 138
def url = "http://www.maxoplata.net/compare/$p1/$p2"

def page = readPage(url)
def rows = parseRows(page)
println countLosses(rows)
println countWins(rows)

def parseRows(GPathResult compareResult) {
    def tds = compareResult.depthFirst().findAll { it.name() == "td" && it.children().any { it.name() == "a"} && it.text() == "SFV" }
    return tds.collect { it.parent() }
}

private Integer countWins(def rows) {
    return rows.count {
        it.td[0].text() =~ /Win/
    }
}

private Integer countLosses(def rows) {
    return rows.count {
        it.td[0].text() =~ /Loss/
    }
}

private GPathResult readPage(String url) {
    println "Reading page ${url}"
    def body = url.toURL().text.readLines()[1..-1].join("\n")
    CleanerProperties props = new CleanerProperties();
    props.setTranslateSpecialEntities(true)
    props.setTransResCharsToNCR(true)
    props.setOmitComments(true)
    TagNode tagNode = new HtmlCleaner(props).clean(body)
    def source = new PrettyXmlSerializer(props).getAsString(tagNode)
    println source

    XmlSlurper slurper = new XmlSlurper(false, false)
    slurper.setFeature("http://apache.org/xml/features/disallow-doctype-decl", false)
    slurper.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false)
    slurper.parseText(source)
    return slurper.parse(new StringReader(source))
}
