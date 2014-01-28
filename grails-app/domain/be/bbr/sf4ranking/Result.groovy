package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class Result
{

    static constraints = {
        player nullable: false, unique: 'tournament'
        place nullable: false
        tournament nullable: false
        pcharacter nullable: false
    }

    static belongsTo = [tournament:Tournament]

    Player player
    Integer place
    CharacterType pcharacter = CharacterType.UNKNOWN
}
