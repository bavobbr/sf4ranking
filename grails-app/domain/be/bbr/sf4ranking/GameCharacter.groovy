package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class GameCharacter implements Comparable<GameCharacter>
{

    static constraints = {
        characterType nullable: false
        main nullable: false
    }

    CharacterType characterType
    Boolean main = false

    static belongsTo = [gameTeam:GameTeam]

    public boolean equals(Object other) {
        if (!other || !(other instanceof GameCharacter)) return false
        return characterType.equals(other.characterType)
    }

    public int hashCode() {
        return characterType.hashCode()
    }

    @Override
    int compareTo(GameCharacter o) {
        return characterType <=> o.characterType
    }


}
