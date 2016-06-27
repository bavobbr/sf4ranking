package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class PlayerRanking
{

    static constraints = {
        game nullable: false
        skill range: 0..100
        mainCharacters nullable: false, editable: false
        score nullable: false, editable: false
        totalScore nullable: false, editable: false
        rank nullable: false, editable: false
        oldRank nullable: true, editable: false
        oldScore nullable: true, editable: false
        snapshot nullable: true, editable: false
    }

    static mapping = {
        player index: 'player_idx'
        game index: 'game_idx'
    }

    Version game
    Integer skill = 0
    Integer score = 0
    Integer totalScore = 0
    Integer rank = 0
    Integer oldScore = null
    Integer oldRank = null
    Date snapshot = null
    Set mainCharacters = []

    static belongsTo = [player:Player]
    static hasMany = [mainCharacters: CharacterType]


}
