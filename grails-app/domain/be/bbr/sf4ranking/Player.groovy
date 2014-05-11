package be.bbr.sf4ranking

import org.apache.shiro.SecurityUtils


class Player
{
    static constraints = {
        name nullable: false, unique: true
        countryCode nullable: true
        codename nullable: true, unique: true
        videos nullable: true, unique: false
        wikilink nullable: true
        twitter nullable: true
        rankings nullable: false
        creator nullable: true
    }

    static mapping = {
        codename index: 'Name_Idx'
    }

    static searchable = [only: ['name', 'twitter']]

    String name
    String codename
    CountryCode countryCode
    String wikilink
    String twitter
    Version mainGame = Version.UNKNOWN
    List<PlayerRanking> rankings = []
    String creator
    static hasMany = [videos: String, results: Result, teams: Team, rankings: PlayerRanking]

    def beforeInsert() {
        codename = name.toUpperCase()
        if (!creator) creator = SecurityUtils.subject?.principal?.toString()

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
        return Version.values().inject(0) { result, item -> result + score(item) }
    }

    public String toString() {
        return "$name, $countryCode, ${rankings.size()}"
    }
}
