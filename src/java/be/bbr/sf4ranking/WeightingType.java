package be.bbr.sf4ranking;

/**
 * User: bbr Date: 2/5/14
 */
public enum WeightingType
{
    AUTO("Single Elimination"),
    FIXED("Double Elimination");

    private final String value;

    WeightingType(String value)
    {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static WeightingType fromString(String input) {
        if (input == null || input.length() == 0) return null;
        WeightingType[] types = WeightingType.values();
        for (WeightingType ct : types)
            if (ct.name().toLowerCase().equals(input.toLowerCase())) {
                return ct;
            }
        return null;
    }
}
