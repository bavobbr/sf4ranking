package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class Hardware
{
    static constraints = {
        name nullable: false, unique: true
        description nullable: true
        website nullable: true
        buy nullable: true
    }

    static mapping = {
        description type: 'text'
    }

    String name
    String description
    String website
    String buy

    static hasMany = [players: Player]

}
