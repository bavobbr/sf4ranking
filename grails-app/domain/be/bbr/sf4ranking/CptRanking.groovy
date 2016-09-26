package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class CptRanking
{

    static constraints = {
        region nullable: false
        score nullable: false, editable: false
        prevScore nullable: true, editable: false
        rank nullable: true, editable: false
        prevRank nullable: true, editable: false
        qualified nullable: false, editable: true
        qualified nullable: false, editable: false
    }

    static mapping = {
        player index: 'cpt_player_idx'
        region index: 'cpt_region_idx'
    }

    Integer score = 0
    Integer prevScore = 0
    Integer rank
    Integer prevRank
    boolean qualified = false
    boolean qualifiedByScore = false
    Region region

    static belongsTo = [player:Player]

    public void snapshot() {
        prevScore = score
        prevRank = rank
    }

    public String rankDiffClass() {
        if (prevRank == null || prevRank == 0) {
            return "warning"
        } else if (player.diffCptRank(this.region) == 0) {
            return ""
        } else if (player.diffCptRank(this.region) < 0) {
            return "danger"
        } else return "success"
    }
}
