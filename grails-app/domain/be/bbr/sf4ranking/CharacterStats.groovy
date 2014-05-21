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
    Integer scoreAccumulatedByTop100 = 0
    Integer decayedScoreAccumulated = 0
    Integer decayedScoreAccumulatedByTop100 = 0
    Integer rankAccumulated = 0
    Double totalUsagePercentage = 0.0
    Integer asMainInTop100 = 0
    Integer asMainInTop50 = 0
    Integer asMain = 0
    Integer asSecondary = 0
    Integer top1finishes = 0
    Integer top3finishes = 0
    Integer top8finishes = 0
    Integer top16finishes = 0
    Double spreadTop5Score = 0
    Double meanTop5Score = 0
    Double standardDeviationTop5Score = 0
    Double spreadTop5Usage = 0
    Double meanTop5Usage = 0
    Double standardDeviationTop5Usage = 0


    Player player


}
