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
        mainCharacters nullable: false
        oldRank nullable: true
        oldScore nullable: true
        snapshot nullable: true
    }

    static mapping = {
        player index: 'player_idx'
        game index: 'game_idx'
    }

    Version game
    Integer skill = 0
    Integer score = 0
    Integer rank = 0
    Integer oldScore = null
    Integer oldRank = null
    Date snapshot = null
    Set mainCharacters = []

    static belongsTo = [player:Player]
    static hasMany = [mainCharacters: CharacterType]


}
