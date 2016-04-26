package be.bbr.sf4ranking;

/**
 * User: bbr Date: 2/5/14
 */
@SuppressWarnings("Duplicates")
public enum CptTournament
{
    NONE("None"),
    RANKING("Ranking Tournament"),
    PREMIER("Premier Tournament"),
    PREMIER_SCORELESS("Premier without points"),
    QUALIFIER("Qualifier Tournament"),
    EVO("Evolution tier"),
    CC("Capcom Cup"),
    REGIONAL_FINAL("Regional Final"),
    ONLINE_EVENT("Online Event");

    private final String value;

    CptTournament(String value)
    {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static CptTournament fromString(String input) {
        if (input == null || input.length() == 0) return null;
        CptTournament[] formats = CptTournament.values();
        for (CptTournament ct : formats)
            if (ct.name().toLowerCase().equals(input.toLowerCase())) {
                return ct;
            }
        return null;
    }

    public Integer getScore(Integer place) {
        switch (this) {
            case RANKING: return getRankingScore(place);
            case PREMIER: return getPremierScore(place);
            case PREMIER_SCORELESS: return 0;
            case EVO: return getEvoScore(place);
            case QUALIFIER: return getRankingScore(place);
            case NONE: return 0;
            default: return 0;
        }
    }

    public Integer getPrize(Integer place) {
            switch (this) {
            case RANKING: return 0;
            case PREMIER: return getPremierPrize(place);
            case PREMIER_SCORELESS: return getPremierPrize(place);
            case EVO: return getEvoPrize(place);
            case QUALIFIER: return 0;
            case NONE: return 0;
            case CC: getCapcomCupPrize(place);
            default: return 0;
        }
    }

    public Integer getPrize(Integer place, CountryCode code) {
        if (code == CountryCode.JP || code == CountryCode.BR) return 0;
        switch (this) {
            case RANKING: return 0;
            case PREMIER: return getPremierPrize(place);
            case PREMIER_SCORELESS: return getPremierPrize(place);
            case EVO: return getEvoPrize(place);
            case QUALIFIER: return 0;
            case NONE: return 0;
            case CC: return getCapcomCupPrize(place);
            default: return 0;
        }
    }

    public Integer getRankingScore(Integer place) {
        switch (place) {
            case 1: return 128;
            case 2: return 64;
            case 3: return 32;
            case 4: return 16;
            case 5: return 8;
            case 6: return 8;
            case 7: return 4;
            case 8: return 4;
            case 9: return 2;
            case 10: return 2;
            case 11: return 2;
            case 12: return 2;
            case 13: return 1;
            case 14: return 1;
            case 15: return 1;
            case 16: return 1;
            default: return 0;
        }
    }

    public Integer getPremierScore(Integer place) {
        switch (place) {
            case 1: return 128*2;
            case 2: return 64*2;
            case 3: return 32*2;
            case 4: return 16*2;
            case 5: return 8*2;
            case 6: return 8*2;
            case 7: return 4*2;
            case 8: return 4*2;
            case 9: return 2*2;
            case 10: return 2*2;
            case 11: return 2*2;
            case 12: return 2*2;
            case 13: return 1*2;
            case 14: return 1*2;
            case 15: return 1*2;
            case 16: return 1*2;
            default: return 0;
        }
    }

    public Integer getEvoScore(Integer place) {
        switch (place) {
            case 1: return 128*8;
            case 2: return 64*8;
            case 3: return 32*8;
            case 4: return 16*8;
            case 5: return 8*8;
            case 6: return 8*8;
            case 7: return 4*8;
            case 8: return 4*8;
            case 9: return 2*8;
            case 10: return 2*8;
            case 11: return 2*8;
            case 12: return 2*8;
            case 13: return 1*8;
            case 14: return 1*8;
            case 15: return 1*8;
            case 16: return 1*8;
            default: return 0;
        }
    }

    public Integer getPremierPrize(Integer place) {
        switch (place) {
            case 1: return 7000;
            case 2: return 3000;
            case 3: return 1500;
            case 4: return 1000;
            case 5: return 750;
            case 6: return 750;
            case 7: return 500;
            case 8: return 500;
            default: return 0;
        }
    }

    public Integer getEvoPrize(Integer place) {
        switch (place) {
            case 1: return 20000;
            case 2: return 10000;
            case 3: return 7000;
            case 4: return 5000;
            case 5: return 2500;
            case 6: return 2500;
            case 7: return 1500;
            case 8: return 1500;
            default: return 0;
        }
    }

    public Integer getCapcomCupPrize(Integer place) {
        switch (place) {
            case 1: return 120000;
            case 2: return 60000;
            case 3: return 25000;
            case 4: return 15000;
            case 5: return 10000;
            case 6: return 10000;
            case 7: return 5000;
            case 8: return 5000;
            default: return 0;
        }
    }
}
