package be.bbr.sf4ranking

/**
 * User: bbr
 * Date: 4/28/14
 */
class CharacterStats
{
    static constraints = {
        player nullable: true
    }

    Version game = Version.UNKNOWN
    CharacterType characterType = CharacterType.UNKNOWN
    Integer totalTimesUsed = 0
    Integer scoreAccumulated = 0
    Integer rankAccumulated = 0
    Double totalUsagePercentage = 0.0
    Integer asMainInTop100 = 0
    Integer asMainInTop50 = 0
    Integer asMain = 0

    Player player


}
