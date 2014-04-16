package be.bbr.sf4ranking;

/**
 * User: bbr Date: 1/21/14
 */
public enum Version
{
    UNKNOWN("Not identified"),
    VANILLA("SF4"),
    SUPER("SSF4"),
    AE("SSF4:AE"),
    AE2012("SSF4:AE 2012"),
    USF4("Ultra SF4"),
    UMVC3("Ultimate Marvel vs Capcom 3"),
    KI("Killer Instinct"), SKULLGIRLS("Skullgirls"),
    IGAU("Injustice");

    private String value;

    Version(String value)
    {
        this.value = value;
    }

    public String getValue()
    {
        return value;
    }

    public static Version fromString(String input)
    {
        if (input == null || input.length() == 0) return null;
        Version[] games = Version.values();
        for (Version ct : games)
            if (ct.name().toLowerCase().equals(input.toLowerCase()))
            {
                return ct;
            }
        return null;
    }

    public static Version generalize(Version game)
    {
        switch (game)
        {
            case VANILLA:
            case SUPER:
            case AE:
            case AE2012:
                return Version.AE2012;
            case UMVC3:
                return Version.UMVC3;
            case KI:
                return Version.KI;
            case SKULLGIRLS:
                return Version.SKULLGIRLS;
            case IGAU:
                return Version.IGAU;
            default:
                return Version.UNKNOWN;
        }
    }

}
