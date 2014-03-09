package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class PlayerRanking
{

    static constraints = {
        game nullable: false
        score nullable: false
        rank nullable: false
        skill range: 0..10

    }

    static mapping = {
        player index: 'Player_Idx'
        game index: 'game_idx'
    }

    Version game
    Integer skill = 0
    Integer score = 0
    Integer rank = 0

    static belongsTo = [player:Player]


}
