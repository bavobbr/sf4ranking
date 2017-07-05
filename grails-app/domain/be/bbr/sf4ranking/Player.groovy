package be.bbr.sf4ranking

import org.apache.shiro.SecurityUtils

class Player
{
    static constraints = {
        name nullable: false, unique: true
        countryCode nullable: true
        videos nullable: true, unique: false
        wikilink nullable: true
        twitter nullable: true
        rankings nullable: false
        realname nullable: true
        alias nullable: true, unique: false, editable: true
        pictureUrl nullable: true
        description nullable: true, widget: 'textarea'
        pictureCopyright nullable: true
        hardware nullable: true
        maxoplataId nullable: true
        smashId nullable: true
        onlineId nullable: true
        twitch nullable: true
        creator nullable: true, editable: false
        cptPrize nullable: false, editable: false
        codename nullable: true, unique: true, editable: false
        simplified nullable: true, unique: false, editable: false
    }

    static mapping = {
        codename index: 'Name_Idx'
        description type: 'text'
    }

    static searchable = [only: ['name', 'twitter', 'realname', 'simplified', 'alias']]

    String name
    String codename
    String realname
    String simplified
    CountryCode countryCode
    String wikilink
    String twitter
    Integer cptTournaments = 0
    Integer cptPrize = 0
    Version mainGame = Version.UNKNOWN
    List<PlayerRanking> rankings = []
    List<CptRanking> cptRankings = []
    String creator
    String pictureUrl
    String description
    String pictureCopyright
    Hardware hardware
    String maxoplataId
    String smashId
    String onlineId
    String twitch
    String alias
    static hasMany = [videos: String, results: Result, teams: Team, rankings: PlayerRanking, cptRankings: CptRanking]

    static String pattern = /[^\dA-Za-z]/

    def beforeInsert() {
        codename = name.toUpperCase()
        simplified = codename.replaceAll(pattern, "")
        if (!creator) creator = SecurityUtils.subject?.principal?.toString()
    }

    def beforeUpdate() {
        codename = name.toUpperCase()
        simplified = codename.replaceAll(pattern, "")
    }

    Integer skill(Version game) {
        return findRanking(game)?.skill?: 0
    }

    Integer rank(Version game) {
        return findRanking(game)?.rank?: 0
    }

    Integer totalRank(Version game) {
        return findRanking(game)?.totalRank?: 0
    }

    Integer trendingRank(Version game) {
        return findRanking(game)?.trendingRank?: 0
    }

    Integer score(Version game) {
        return findRanking(game)?.score?: 0
    }

    Integer cptScore() {
        return findCptRanking(Region.GLOBAL)?.score?: 0
    }

    Integer cptScore(Region region) {
        return findCptRanking(region)?.score?: 0
    }

    Integer totalScore(Version game) {
        return findRanking(game)?.totalScore?: 0
    }

    Integer trendingScore(Version game) {
        return findRanking(game)?.trendingScore?: 0
    }

    Date snapshot(Version game) {
        return findRanking(game)?.snapshot?: null
    }

    String diff(Version game) {
        def ranking = findRanking(game)
        def newScore = ranking?.score
        def oldScore = ranking?.oldScore
        if (oldScore == null) return "-"
        Integer diff =  newScore - oldScore
        if (diff == 0) return ""
        return (diff > 0)? "+${diff}" : "${diff}"
    }

    Integer diffRank(Version game) {
        def ranking = findRanking(game)
        def newRank = ranking?.rank
        def oldRank = ranking?.oldRank
        if (oldRank == null) return null
        return oldRank - newRank
    }

    Integer diffTotalRank(Version game) {
        def ranking = findRanking(game)
        def newRank = ranking?.totalRank
        def oldRank = ranking?.rank
        if (oldRank == null || newRank == null) return null
        return oldRank - newRank
    }

    Integer diffTrendRank(Version game) {
        def ranking = findRanking(game)
        def newRank = ranking?.trendingRank
        def oldRank = ranking?.rank
        if (oldRank == null || newRank == null) return null
        return oldRank - newRank
    }

    String diffCpt(Region region) {
        def ranking = findCptRanking(region)
        def newScore = ranking?.score
        def oldScore = ranking?.prevScore
        if (oldScore == null) return "+${newScore}"
        Integer diff =  newScore - oldScore
        if (diff == 0) return "+0"
        return (diff > 0)? "+${diff}" : "${diff}"
    }

    Integer diffCptRank(Region region) {
        def ranking = findCptRanking(region)
        def newRank = ranking?.rank
        def oldRank = ranking?.prevRank
        if (oldRank == null) return null
        return oldRank - newRank
    }


    Set<CharacterType> main(Version game) {
        return findRanking(game)?.mainCharacters?: []
    }

    void applyScore(Version game, Integer score)
    {
        findOrCreateRanking(game).score = score
    }

    void applyTotalScore(Version game, Integer score)
    {
        findOrCreateRanking(game).totalScore = score
    }

    void applyTrendingScore(Version game, Integer score)
    {
        findOrCreateRanking(game).trendingScore = score
    }

    void applyRank(Version game, Integer rank)
    {
        if (rank > 0) findOrCreateRanking(game).rank = rank
        else deleteRanking(game)
    }

    void applyTotalRank(Version game, Integer rank)
    {
        if (rank > 0) findOrCreateRanking(game).totalRank = rank
        else deleteRanking(game)
    }

    void applyTrendingRank(Version game, Integer rank)
    {
        if (rank > 0) findOrCreateRanking(game).trendingRank = rank
        else deleteRanking(game)
    }

    void applySkill(Version game, Integer skill)
    {
        findOrCreateRanking(game).skill = skill
        log.info "Updated skill of $name in $game to $skill"
    }

    PlayerRanking findOrCreateRanking(Version game) {
        def ranking = findRanking(game)
        if (!ranking) {
            ranking = new PlayerRanking(score: 0, rank: 0, skill: 0, game: game)
            this.addToRankings(ranking)
        }
        return ranking
    }

    CptRanking findOrCreateCptRanking(Region region) {
        def ranking = findCptRanking(region)
        if (!ranking) {
            log.info("DO not have CPT ranking for region $region and player $name, creating...")
            ranking = new CptRanking(region: region)
            this.addToCptRankings(ranking)
        }
        return ranking
    }

    void deleteRanking(Version game) {
        def ranking = findRanking(game)
        if (ranking) {
            log.info("Deleting ranking for game $game and player $name")
            this.removeFromRankings(ranking)
        }
    }

    void deleteCptRanking(Region region) {
        def ranking = findCptRanking(region)
        if (ranking) {
            log.info("Deleting CPT ranking for region $region and player $name")
            this.removeFromCptRankings(ranking)
        }
    }

    boolean hasRanking(Version game) {
        return rankings.any { it?.game == game }
    }

    PlayerRanking findRanking(Version game) {
        return rankings.find { it?.game == game }
    }

    CptRanking findCptRanking(Region region) {
        return cptRankings.find { it?.region == region }
    }

    CptRanking cptGlobal() {
        return cptRankings.find { it?.region == Region.GLOBAL }
    }

    Integer overallScore() {
        return Version.values().inject(0) { result, item -> result + totalScore(item) }
    }

    PlayerLabel labelFor(Version game) {
        def ranking = findRanking(game)
        if (ranking == null) return PlayerLabel.NONE
        else {
            switch (ranking.rank) {
                case { it <= 10 }: return PlayerLabel.TOP10
                case { it <= 20 }: return PlayerLabel.TOP20
                case { it <= 50 }: return PlayerLabel.TOP50
                case { it <= 100 }: return PlayerLabel.TOP100
                case { it <= 250 }: return PlayerLabel.TOP250
                default: return PlayerLabel.UPCOMING
            }
        }
    }

    public String toString() {
        def props = []
        if (realname) props << realname
        if (twitter) props << twitter
        if (countryCode) props << countryCode.name()
        def meta =  props.join(", ")
        return meta? "$name ($meta)" : name
    }
}
