import groovy.util.slurpersupport.GPathResult
import org.htmlcleaner.CleanerProperties
import org.htmlcleaner.HtmlCleaner
import org.htmlcleaner.PrettyXmlSerializer
import org.htmlcleaner.TagNode

def tournament = "capcom-pro-tour-online-2017-asia-event-2"
def event = "street-fighter-v-singles"

private GPathResult parsePage(String text) {
    CleanerProperties props = new CleanerProperties()
    props.setTranslateSpecialEntities(true)
    props.setTransResCharsToNCR(true)
    props.setOmitComments(true)
    TagNode tagNode = new HtmlCleaner(props).clean(text)
    def source = new PrettyXmlSerializer(props).getAsString(tagNode)
    XmlSlurper slurper = new XmlSlurper(false, false)
    slurper.setFeature("http://apache.org/xml/features/disallow-doctype-decl", false)
    slurper.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false)
    return slurper.parseText(source)
}

def url = "https://smash.gg/tournament/$tournament/events/$event/standings"
def content = url.toURL().text
def xml = parsePage(content)


def players = xml.depthFirst().findAll { it.name() == "div" && it.'@class' =~ "gamertag-title-full-prefix gamertag-title"}
println players

players.each { GPathResult result ->
    def tag = result.depthFirst().find { it.name() == "span" && it."@class" == "prefix"}
    if (tag) {
        def tagtext = tag.text().trim()
        def pname = result.children().find { it instanceof String }.text()
        println(tagtext + "|" + pname.trim())
    }
    else println(result.text().trim())
}