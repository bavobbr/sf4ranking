package be.bbr.sf4ranking

import groovy.transform.ToString

/**
 * User: bbr
 * Date: 4/28/14
 */
@ToString
class GameStats
{
    static constraints = {
        usageSeries maxSize: 9000
    }

    Version game = Version.UNKNOWN
    String usageSeries = ""
    Integer percentageInTop50 = 0
    Integer percentageInTop100 = 0
    Integer rankOfCharAt25Percent = 0
    Integer rankOfCharAt50Percent = 0
    Integer rankOfCharAt75Percent = 0
    Integer rankOfCharAt100Percent = 0
    Double meanOnScore = 0
    Double standardDeviationOnScore = 0
    Double varianceOnScore = 0
    Double meanOnMain = 0
    Double standardDeviationOnMain = 0
    Double varianceOnMain = 0
    Double meanOnUsage = 0
    Double standardDeviationOnUsage = 0
    Double meanOnUsagePercent = 0
    Double standardDeviationOnUsagePercent = 0
    Integer sampleSize = 0

}
