package be.bbr.sf4ranking;


public enum TournamentType
{
    GRAND_SLAM("Grand Slam",200),
    CHAMPIONSHIP("Championship",190),
    PREMIER_MANDATORY("Premier Mandatory",180),
    PREMIER_5("Premier 5",170),
    PREMIER_12("Premier 12",160),
    INTERNATIONAL("International",150),
    SERIES("Series",140),
    CIRCUIT("Local",130),
    TOURNAMENT_CHAMPIONS("Tournament Of Champions",60),
    UNRANKED("Unranked", 0);

    private final String value;
    // this value is used when WeightingType is FIXED, to assign a fixed weight
    private final Integer classWeight;

    TournamentType(String value, Integer classWeight)
    {
        this.value = value;
        this.classWeight = classWeight;
    }

    public String getValue() {
        return value;
    }
    public Integer getClassWeight() {
        return classWeight;
    }

    public static TournamentType fromString(String input) {
        if (input == null || input.length() == 0) return null;
        TournamentType[] types = TournamentType.values();
        for (TournamentType ct : types)
            if (ct.name().toLowerCase().equals(input.toLowerCase())) {
                return ct;
            }
        return null;
    }
}
