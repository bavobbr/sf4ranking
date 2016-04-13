package be.bbr.sf4ranking


class Hardware
{
    static constraints = {
        name nullable: false, unique: true
        description nullable: true
        website nullable: true
        buy nullable: true
        image nullable: true
        buyUK nullable: true
        buyFR nullable: true
        buyDE nullable: true
        shortname nullable: true
    }

    static mapping = {
        description type: 'text'
        buy type: 'text'
        buyUK type: 'text'
        buyFR type: 'text'
        buyDE type: 'text'
    }

    String name
    String description
    String website
    String buy
    String image

    static hasMany = [players: Player]

    String buyUK
    String buyFR
    String buyDE

    String shortname = "N/A"

    public String toString() {
        return "${name}"
    }

}
