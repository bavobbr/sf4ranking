package be.bbr.overview

import be.bbr.sf4ranking.CharacterType
import be.bbr.sf4ranking.CountryCode
import be.bbr.sf4ranking.DataService
import be.bbr.sf4ranking.TournamentFormat
import be.bbr.sf4ranking.TournamentReview
import be.bbr.sf4ranking.Version


/**
 */
class SubmitController {

    DataService dataService

    /**
     * Manual data import and manipulation
     */
    def index() {
        def suggestedName = "tournament"
        def suggestedDate = new Date()
        def suggestedSource = "URL"
        def suggestedCountry = CountryCode.US
        def example = "player1 (team1char1/team1char2,team2char1/team2char3)\nplayer2 (team1char1,team1char2)\nplayer3 (team1char1/team2char1)\nplayer4"
        return [hint: example, suggestedName: suggestedName, suggestedDate: suggestedDate, suggestedSource: suggestedSource, suggestedCountry: suggestedCountry]
    }

    def list() {
        def toReview = TournamentReview.findAllByReviewed(false)
        def reviewed = TournamentReview.findAllByReviewed(true)
        return [toReview: toReview, reviewed: reviewed]
    }

    def review() {
        if (!params.answer.trim().equalsIgnoreCase("ryu")) {
            render "Please answer the captcha correctly. Use browser BACK button to retry"
        }
        String tname = params.tname
        Date tdate = new Date(params.tdate_year.toInteger() - 1900, params.tdate_month.toInteger() - 1, params.tdate_day.toInteger())
        TournamentFormat tformat = TournamentFormat.fromString(params.tformat)
        CountryCode tcountry = CountryCode.fromString(params.tcountry)
        Version tgame = Version.fromString(params.tgame)
        String results = params.tresults
        String coverage = params.tcoverage
        String creator = params.tcreator
        if (!tname || !tdate || !tgame || tgame == Version.UNKNOWN || !creator) {
            flash.message = "Name, game, date, tournament type, results and creator are mandatory. Use browser BACK button to correct!"
            render view: "index"
            return
        }
        def review = saveReview(tname, results, tdate, tformat, tcountry, tgame, coverage, creator)
        if (review.hasErrors()) {
            render("Errors found during SAVE:<br/>${review.errors.collect { it.allErrors}}<br/>Use browser BACK to correct")
        }
        redirect(controller: "submit", action: "showreview", params: [id: review.id])
    }

    def showreview() {
        [review: TournamentReview.get(params.id)]
    }

    private TournamentReview saveReview(String tname, String results, Date date, TournamentFormat format, CountryCode country, Version game, String coverage, String creator) {
        TournamentReview review = new TournamentReview(
                name: tname,
                countryCode: country,
                date: date,
                weight: 1, game: game,
                tournamentFormat: format,
                coverage: coverage,
                reviewed: false,
                content: results,
                creator: creator
        )
        review.save()
        log.info("Saved tournament " + review)
        return review
    }

    def validateResults()
    {
        def content = params.content
        def type = params.type
        def game = Version.fromString(params.game)
        List<String> feedback = dataService.validateResults(content, game, type)
        log.info "rendering $feedback"
        render(contentType: "text/html") {
            div {
                feedback.each {
                    p(it)
                }
            }
        }
        log.info "rendered $feedback"
    }

    def renderCharacterNames() {
        def game = Version.fromString(params.game);
        def names = CharacterType.values().findAll { it.game == Version.generalize(game) }
        log.info "rendering $game"
        render(contentType: "text/html") {
            if (game == Version.UNKNOWN) {
                p("Please select a game first")
            }
            ul {
                names.each {
                    li("${it.name()} / ${it.getValue()} / ${it.getShortname()}")
                }
            }
        }
        log.info "rendered $game"
    }

    def example() {
        def text = '''
Place players in <b>order of result, one per line</b>. Remove team names and keep player name clean. Add the used characters after the player name using
brackets. Multiple characters are seperated by ',' and characters are put as team using '/'.<br/>
Before submitting, <b>try out validation</b>. This will tell if the system recognizes the name, and may suggest alternatives. The character names can be found
using the 'List characters' button. Example:<br/>&nbsp;
<p><i>
Daigo Umehara (Ryu)<br/>
Justin Wong (Chun)<br/>
Nuckledu (Guile, Decapre)<br/>
Player with no known chars<br/>
NYChrisG (Morrigan/Doctor Doom/Vergil)<br/>
Filipino Champ (Doctor Doom/Magneto/Dormammu, Doctor Doom/Akuma/Hulk)<br/>
Sako (elena)<br/>
Kazunoko (Yun, evil ryu)</i>
</p>&nbsp;<p>
This example will create a 8 man tournament result. The Marvel character names are added as example of teams.</p>
'''
        render(text)
    }
}
