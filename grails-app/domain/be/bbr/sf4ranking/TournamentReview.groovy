package be.bbr.sf4ranking

class TournamentReview
{

    static constraints = {
        name nullable: false, unique: false
        date nullable: false
        countryCode nullable: true
        tournamentFormat nullable: false
        game nullable: false
        coverage nullable: true
        creator nullable: true
        reviewed nullable: false
        content nullable: false
    }

    static mapping = {
        content type: 'text'
    }

    String name
    Date date
    CountryCode countryCode
    TournamentFormat tournamentFormat = TournamentFormat.UNKNOWN
    Version game = Version.UNKNOWN
    String coverage = null
    String creator
    Boolean reviewed = false
    String content


    public String toString() {
        def props = []
        if (name) props << name
        if (countryCode) props << countryCode
        return props.join(", ")
    }
}
