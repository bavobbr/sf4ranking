package be.bbr.sf4ranking

import groovy.transform.ToString

/**
 * User: bbr
 * Date: 4/28/14
 */
@ToString(includeNames = true)
class CharacterStats
{
    static constraints = {
        player nullable: true
        trendingPlayer nullable: true
    }

    Version game = Version.UNKNOWN
    CharacterType characterType = CharacterType.UNKNOWN
    Integer totalTimesUsed = 0
    Integer scoreAccumulated = 0
    Integer scoreAccumulatedByTop100 = 0
    Integer decayedScoreAccumulated = 0
    Integer decayedScoreAccumulatedByTop100 = 0
    Integer trendingScoreAccumulated = 0
    Integer trendingScoreAccumulatedByTop100 = 0
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
    Double spreadTop5Score = 0.0
    Double meanTop5Score = 0.0
    Double standardDeviationTop5Score = 0.0
    Double spreadTop5Usage = 0.0
    Double meanTop5Usage = 0.0
    Double standardDeviationTop5Usage = 0.0

    Integer decayedRank = 0
    Integer trendingRank = 0
    Integer alltimeRank = 0


    Player player
    Player trendingPlayer

    def beforeInsert() { convertNaN() }

    def beforeUpdate() { convertNaN() }

    public Integer diffTrendRank() {
        return decayedRank - trendingRank
    }

    private void convertNaN() {
        if (spreadTop5Score == Double.NaN) spreadTop5Score = -1.0
        if (meanTop5Score == Double.NaN) meanTop5Score = -1.0
        if (standardDeviationTop5Score == Double.NaN) standardDeviationTop5Score = -1.0
        if (spreadTop5Usage == Double.NaN) spreadTop5Usage = -1.0
        if (meanTop5Usage == Double.NaN) meanTop5Usage = -1.0
        if (standardDeviationTop5Usage == Double.NaN) standardDeviationTop5Usage = -1.0
        if (totalUsagePercentage == Double.NaN) totalUsagePercentage = -1.0
    }


}
