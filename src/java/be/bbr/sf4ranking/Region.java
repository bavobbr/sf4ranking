package be.bbr.sf4ranking;

/**
 */
public enum Region
{
    AO("Asia"),
    LA("Latin America"),
    NA("Northern America"),
    EU("Europe"),
    UNKNOWN("Unknown");

    private final String value;

    Region(String value)
    {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static Region fromString(String input) {
        if (input == null || input.length() == 0) return null;
        Region[] formats = Region.values();
        for (Region ct : formats)
            if (ct.name().toLowerCase().equals(input.toLowerCase())) {
                return ct;
            }
        return null;
    }

}
