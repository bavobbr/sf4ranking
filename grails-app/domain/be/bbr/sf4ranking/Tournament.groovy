package be.bbr.sf4ranking


class Tournament
{

    static constraints = {
        name nullable: false, unique: true
        weight range: 0..200
        date nullable: false
        countryCode nullable: true
        tournamentType nullable: true
        tournamentFormat nullable: false
        weightingType nullable: false
        game nullable: false
        codename nullable: true, unique: true
        videos nullable: true, unique: false
        challonge nullable: true
        ranked nullable: false
    }

    String name
    String codename
    Long weight
    Date date
    CountryCode countryCode
    TournamentType tournamentType
    TournamentFormat tournamentFormat = TournamentFormat.UNKNOWN
    Version game = Version.UNKNOWN
    WeightingType weightingType = WeightingType.AUTO
    String challonge
    Boolean ranked = true

    static hasMany = [videos: String, results: Result]

    def beforeInsert() {
        codename = name.toUpperCase()
    }

    public String toString() {
        return "$name, $countryCode, ${game.name()}"
    }
}
