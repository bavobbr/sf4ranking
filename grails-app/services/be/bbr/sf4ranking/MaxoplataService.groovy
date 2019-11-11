package be.bbr.sf4ranking

import grails.plugin.cache.Cacheable
import groovy.util.slurpersupport.GPathResult
import org.htmlcleaner.CleanerProperties
import org.htmlcleaner.HtmlCleaner
import org.htmlcleaner.PrettyXmlSerializer
import org.htmlcleaner.TagNode


/**
 * Queries towards Maxoplata site
 */
class MaxoplataService
{

    @Cacheable("maxoplataCompare")
    Map<Version, Map<Player, Integer>> comparePlayers(Player p1, Player p2) {
        try {
            def url = "https://www.fgcbattles.com/compare/$p1.maxoplataId/$p2.maxoplataId"
            def page = parsePage(url)
            return Version.values().collectEntries {
                def maxoplataLabels = convertGameLabel(it)
                def rows = parseRows(page, maxoplataLabels)
                def p1wins = countWins(rows)
                def p1losses = countLosses(rows)
                [(it): [p1: p1wins, p2: p1losses]]
            }
        }
        catch (e) {
            log.error("The requested HTML parsing for $p1 and $p2 failed:")
            log.error(e)
            return null
        }
    }


    def parseRows(GPathResult compareResult, List<String> labels) {
        def tds = compareResult.depthFirst().findAll { it.name() == "td" && it.children().any { it.name() == "a"} && labels.contains(it.text()) }
        return tds.collect { it.parent() }
    }

    private List<String> convertGameLabel(Version version) {
        switch (version) {
            case Version.SF5: return ["SFV", "SFV:S2", "SFVAE"]
            case Version.MKX: return ["MKX", "MKXL"]
            case Version.UMVC3: return ["MvC3","UMvC3"]
            case Version.IGAU: return ["Injustice"]
            case Version.USF4: return ["USF4"]
            case Version.AE2012: return ["SSF4AEv2012"]
            case Version.AE: return ["SSF4AE"]
            case Version.SUPER: return ["SSF4"]
            case Version.VANILLA: return ["SF4"]
            case Version.SKULLGIRLS: return ["SG"]
            case Version.BBCP: return ["BB:CPE", "BB:CP", "BB:CF"]
            case Version.KI: return ["KI"]
            case Version.T7: return ["T7"]
            case Version.DBFZ: return ["DBFZ"]
            case Version.BBTAG: return ["BB:CTB"]
            case Version.INJUSTICE2: return ["Injustice 2"]
            case Version.MK11: return ["MK11"]
            default: return [version.name()]
        }
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

    @Cacheable("maxoplataCompareUrl")
    private String readPage(String url) {
        log.info("Reading from external URL: $url")
        def body = new URL(url).text
        log.info("Data read from external URL, ${body.size()} characters")
        return body
    }

    private GPathResult parsePage(String url) {
        def body = readPage(url)
        CleanerProperties props = new CleanerProperties()
        props.setTranslateSpecialEntities(true)
        props.setTransResCharsToNCR(true)
        props.setOmitComments(true)
        TagNode tagNode = new HtmlCleaner(props).clean(body)
        def source = new PrettyXmlSerializer(props).getAsString(tagNode)
        log.info("Data cleaned:\n$source")
        XmlSlurper slurper = new XmlSlurper(false, false)
        slurper.setFeature("http://apache.org/xml/features/disallow-doctype-decl", false)
        slurper.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false)
        log.info("Data parsing to gpath")
        return slurper.parseText(source)
    }

}
