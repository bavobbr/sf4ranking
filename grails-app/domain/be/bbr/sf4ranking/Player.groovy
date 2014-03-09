package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
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
    }

    static mapping = {
        codename index: 'Name_Idx'
        score index: 'Score_Idx'
    }

    String name
    String codename
    Integer score = 0
    Integer rank = 0
    CountryCode countryCode
    String wikilink
    String twitter
    List<PlayerRanking> rankings = []
    static hasMany = [videos: String, results: Result, teams: Team, rankings: PlayerRanking]

    def beforeInsert() {
        codename = name.toUpperCase()
    }

    Integer skill(Version game) {
        return rankings.find { it.game == game }?.skill?: 0
    }

    Integer rank(Version game) {
        return rankings.find { it.game == game }?.rank?: 0
    }

    Integer score(Version game) {
        return rankings.find { it.game == game }?.score?: 0
    }

    void applyScore(Version game, Integer score)
    {
        findOrCreateRanking(game).score = score
    }

    void applyRank(Version game, Integer rank)
    {
        findOrCreateRanking(game).rank = rank
    }

    void applySkill(Version game, Integer skill)
    {
        findOrCreateRanking(game).skill = skill
    }

    PlayerRanking findOrCreateRanking(Version game) {
        def ranking = rankings.find { it.game == game }
        if (!ranking) {
            ranking = new PlayerRanking(score: 0, rank: 0, skill: 0, game: game)
            this.addToRankings(ranking)
        }
        return ranking
    }
}
