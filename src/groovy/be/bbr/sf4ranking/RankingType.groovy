package be.bbr.sf4ranking


enum RankingType {

    ACTUAL("Actual", "rank"),
    ALLTIME("Alltime", "totalRank"),
    TRENDING("Trending", "trendingRank")

    String name
    String field

    public RankingType(String name, String field) {
        this.name = name
        this.field = field
    }

    public static RankingType fromString(String input) {
        if (input == null || input.length() == 0) return null
        for (RankingType rankingType : values())
            if (rankingType.name().toLowerCase().equals(input.toLowerCase())) {
                return rankingType
            }
        return null
    }

}