package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class Character
{

    static constraints = {
        characterType nullable: false
        main nullable: false
    }

    CharacterType characterType
    Boolean main = false

    static belongsTo = [result:Result]


}
