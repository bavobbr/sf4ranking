package be.bbr.sf4ranking;

/**
 * User: bbr Date: 2/5/14
 */
public enum TournamentFormat
{
    UNKNOWN("Not identified"),
    SINGLE_BRACKET("Single Elimination"),
    DOUBLE_BRACKET("Double Elimination"),
    LEAGUE("League");

    private final String value;

    TournamentFormat(String value)
    {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static TournamentFormat fromString(String input) {
        if (input == null || input.length() == 0) return null;
        TournamentFormat[] formats = TournamentFormat.values();
        for (TournamentFormat ct : formats)
            if (ct.name().toLowerCase().equals(input.toLowerCase())) {
                return ct;
            }
        return null;
    }
}
