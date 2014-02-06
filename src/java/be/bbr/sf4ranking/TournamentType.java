package be.bbr.sf4ranking;


public enum TournamentType
{
    GRAND_SLAM("Grand Slam"),
    CHAMPIONSHIP("Championship"),
    PREMIER_MANDATORY("Premier Mandatory"),
    PREMIER_5("Premier 5"),
    PREMIER_12("Premier 12"),
    INTERNATIONAL("International"),
    SERIES("Series"),
    CIRCUIT("Circuit"),
    TOURNAMENT_CHAMPIONS("Tournament Of Champions");

    private final String value;

    TournamentType(String value)
    {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
