package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class Team
{

    static constraints = {
        name nullable: false, unique: true
        shortname nullable: false, unique: true
        website nullable: true
        twitter nullable: true
        logo nullable: true
        codename nullable: true, unique: true
    }

    String name
    String shortname
    String website
    String twitter
    String logo
    String codename

    def beforeInsert() {
        codename = name.toUpperCase()
    }

}
