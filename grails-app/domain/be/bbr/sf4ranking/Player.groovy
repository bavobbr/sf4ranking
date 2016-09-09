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
        cptQualified nullable: false
        cptRegionalQualified nullable: false
        pictureUrl nullable: true
        description nullable: true, widget: 'textarea'
        pictureCopyright nullable: true
        hardware nullable: true
        maxoplataId nullable: true
        onlineId nullable: true
        twitch nullable: true

        creator nullable: true, editable: false
        cptScore nullable: true, editable: false
        cptScoreLA nullable: true, editable: false
        cptScoreNA nullable: true, editable: false
        cptScoreAO nullable: true, editable: false
        cptScoreEU nullable: true, editable: false
        prevCptScore nullable: true, editable: false
        cptRank nullable: true, editable: false
        cptRankLA nullable: true, editable: false
        cptRankNA nullable: true, editable: false
        cptRankAO nullable: true, editable: false
        cptRankEU nullable: true, editable: false
        prevCptRank nullable: true, editable: false
        cptPrize nullable: false, editable: false

        codename nullable: true, unique: true, editable: false
        simplified nullable: true, unique: false, editable: false
    }

    static mapping = {
        codename index: 'Name_Idx'
        description type: 'text'
    }

    static searchable = [only: ['name', 'twitter', 'realname', 'simplified']]

    String name
    String codename
    String realname
    String simplified
    CountryCode countryCode
    String wikilink
    String twitter
    Integer cptScore
    Integer prevCptScore
    Integer cptRank
    Integer prevCptRank
    Integer cptScoreNA
    Integer cptScoreLA
    Integer cptScoreAO
    Integer cptScoreEU
    Integer cptRankNA
    Integer cptRankLA
    Integer cptRankAO
    Integer cptRankEU
    Integer cptTournaments = 0
    Integer cptPrize = 0
    boolean cptQualified = false
    Version mainGame = Version.UNKNOWN
    List<PlayerRanking> rankings = []
    String creator
    String pictureUrl
    String description
    String pictureCopyright
    Hardware hardware
    String maxoplataId
    String onlineId
    String twitch
    boolean cptRegionalQualified = false
    static hasMany = [videos: String, results: Result, teams: Team, rankings: PlayerRanking]

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

    Integer score(Version game) {
        return findRanking(game)?.score?: 0
    }

    Integer totalScore(Version game) {
        return findRanking(game)?.totalScore?: 0
    }

    Date snapshot(Version game) {
        return findRanking(game)?.snapshot?: null
    }

    String diff(Version game) {
        def ranking = findRanking(game)
        def newRank = ranking?.rank
        def oldRank = ranking?.oldRank
        if (oldRank == null) return "-"
        Integer diff = oldRank - newRank
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

    Set<CharacterType> main(Version game) {
        return findRanking(game)?.mainCharacters?: []
    }

    void applyScore(Version game, Integer score)
    {
        if (score > 0) findOrCreateRanking(game).score = score
        else deleteRanking(game)

    }

    void applyTotalScore(Version game, Integer score)
    {
        if (score > 0) findOrCreateRanking(game).totalScore = score
        else deleteRanking(game)
    }

    void applyRank(Version game, Integer rank)
    {
        if (rank > 0) findOrCreateRanking(game).rank = rank
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

    void deleteRanking(Version game) {
        def ranking = findRanking(game)
        if (ranking) {
            this.removeFromRankings(ranking)
        }
    }

    boolean hasRanking(Version game) {
        return rankings.any { it.game == game }
    }

    PlayerRanking findRanking(Version game) {
        return rankings.find { it.game == game }
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
