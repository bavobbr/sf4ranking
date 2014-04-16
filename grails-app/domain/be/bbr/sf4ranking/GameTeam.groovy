package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class GameTeam implements Comparable<GameTeam>
{
    static constraints = {}

    static mapping = {
        result index: 'result_idx'
    }

    static belongsTo = [result: Result]
    static hasMany = [pchars: GameCharacter]

    public String toString() {
        return "[${pchars?.join(",")}]"
    }

    public boolean equals(Object other) {
        if (!other || !(other instanceof GameTeam)) return false
        return pchars.equals(other.pchars)
    }

    public int hashCode() {
        return pchars.hashCode()
    }

    @Override
    int compareTo(GameTeam o) {
        return pchars <=> o.pchars
    }
}
