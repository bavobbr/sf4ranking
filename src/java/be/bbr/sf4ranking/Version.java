package be.bbr.sf4ranking;

import org.joda.time.DateTime;

/**
 * User: bbr Date: 1/21/14
 */
public enum Version
{
    UNKNOWN("Not identified", 0, null, null),
    VANILLA("SF4", 1, new DateTime().withDate(2008, 7, 18), new DateTime().withDate(2010, 4, 27)),
    SUPER("SSF4", 1, new DateTime().withDate(2010, 4, 27), new DateTime().withDate(2011, 7, 7)),
    AE("SSF4:AE", 1, new DateTime().withDate(2011, 7, 7), new DateTime().withDate(2012, 1, 8)),
    AE2012("SSF4:AE 2012", 1, new DateTime().withDate(2012, 1, 8), new DateTime().withDate(2014, 6, 1)),
    USF4("Ultra SF4", 1, new DateTime().withDate(2014, 6, 1), new DateTime().withDate(2016, 2, 16)),
    UMVC3("Ultimate Marvel vs Capcom 3", 3, new DateTime().withDate(2011, 2, 26), new DateTime().withDate(2017, 9, 19)),
    KI("Killer Instinct", 1, new DateTime().withDate(2013, 11, 22), null),
    SKULLGIRLS("Skullgirls", 0, new DateTime().withDate(2012, 4, 15), new DateTime().withDate(2015, 12, 31)),
    BBCP("BlazBlue", 1, new DateTime().withDate(2013, 12, 1), new DateTime().withDate(2018, 6, 23)),
    IGAU("Injustice", 1, new DateTime().withDate(2013, 4, 18), new DateTime().withDate(2015, 4, 26)),
    MKX("Mortal Kombat X", 1, new DateTime().withDate(2015, 4, 26), null),
    SF5("Street Fighter 5", 1, new DateTime().withDate(2016, 2, 16), null),
    T7("Tekken 7", 1, new DateTime().withDate(2015, 7, 19), null),
    INJUSTICE2("Injustice 2", 1, new DateTime().withDate(2017, 5, 20), null),
    GGXRD("Guilty Gear Xrd", 1, new DateTime().withDate(2015, 1, 1), null),
    MVCI("Marvel Infinite", 2, new DateTime().withDate(2017, 9, 19), null),
    DBFZ("Dragon Ball Fighterz", 3, new DateTime().withDate(2018, 1, 27), null),
    BBTAG("Blazblue: Cross Tag Battle", 2, new DateTime().withDate(2018, 6, 23), null);

    private String value;
    private Integer teamSize;
    private DateTime start;
    private DateTime end;

    Version(String value, Integer teamSize, DateTime start, DateTime end)
    {

        this.value = value;
        this.teamSize = teamSize;
        this.start = start;
        this.end = end;
    }

    public String getValue()
    {
        return value;
    }

    public Integer getTeamSize()
    {
        return teamSize;
    }

    public DateTime getStart() {
        return start;
    }

    public DateTime getEnd() {
        return end;
    }

    public boolean isMultiCharacter() {
        return teamSize > 1;
    }

    public boolean isVariableCharacter() {
        return teamSize == 0;
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
            case USF4:
                return Version.USF4;
            case UMVC3:
                return Version.UMVC3;
            case KI:
                return Version.KI;
            case SKULLGIRLS:
                return Version.SKULLGIRLS;
            case IGAU:
                return Version.IGAU;
            case BBCP:
                return Version.BBCP;
            case MKX:
                return Version.MKX;
            case SF5:
                return Version.SF5;
            case T7:
                return Version.T7;
            case INJUSTICE2:
                return Version.INJUSTICE2;
            case GGXRD:
                return Version.GGXRD;
            case MVCI:
                return Version.MVCI;
            case DBFZ:
                return Version.DBFZ;
            case BBTAG:
                return Version.BBTAG;
            default:
                return Version.UNKNOWN;
        }
    }

}
