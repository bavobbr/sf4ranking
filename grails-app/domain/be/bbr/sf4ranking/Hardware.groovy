package be.bbr.sf4ranking


class Hardware
{
    static constraints = {
        name nullable: false, unique: true
        description nullable: true, widget: 'textarea'
        website nullable: true
        buy nullable: true, widget: 'textarea'
        image nullable: true
        buyUK nullable: true, widget: 'textarea'
        buyFR nullable: true, widget: 'textarea'
        buyDE nullable: true, widget: 'textarea'
        shortname nullable: true
        directLink nullable: true
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

    String directLink

    public String toString() {
        return "${name}"
    }

}
