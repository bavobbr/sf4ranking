package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class Player
{
    static constraints = {
        name nullable: false, unique: true
        skill range: 0..10
        countryCode nullable: true
        codename nullable: true, unique: true
        videos nullable: true, unique: false
    }

    static mapping = {
        codename index: 'Name_Idx'
        score index: 'Score_Idx'
    }

    String name
    String codename
    Integer skill = 0
    Integer score = 0
    Integer rank = 0
    CountryCode countryCode
    static hasMany = [videos: String]

    def beforeInsert() {
        codename = name.toUpperCase()
    }

}
