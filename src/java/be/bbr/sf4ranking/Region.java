package be.bbr.sf4ranking;

import java.util.ArrayList;
import java.util.List;

/**
 */
public enum Region
{
    AO("Asia"),
    LA("Latin America"),
    NA("Northern America"),
    EU("Europe"),
    GLOBAL("Global"),
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

    public static List<Region> locals() {
        List<Region> locals = new ArrayList<Region>();
        locals.add(Region.NA);
        locals.add(Region.LA);
        locals.add(Region.AO);
        locals.add(Region.EU);
        return locals;
    }

}
