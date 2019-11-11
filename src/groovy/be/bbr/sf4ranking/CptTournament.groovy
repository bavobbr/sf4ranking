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
    ONLINE_EVENT("Online Event"),
    REGIONAL_OPEN("Regional Open")

    private final String value

    CptTournament(String value)
    {
        this.value = value
    }

    public String getValue() {
        return value
    }

    public static List<CptTournament> premiers() {
        List<CptTournament> premiers = new ArrayList<CptTournament>()
        premiers.add(PREMIER)
        premiers.add(PREMIER_SCORELESS)
        premiers.add(EVO)
        premiers.add(REGIONAL_FINAL)
        return premiers
    }

    public static List<CptTournament> regionals() {
        List<CptTournament> premiers = new ArrayList<CptTournament>()
        premiers.add(RANKING)
        premiers.add(ONLINE_EVENT)
        return premiers
    }

    public static List<CptTournament> regionfinals() {
        List<CptTournament> premiers = new ArrayList<CptTournament>()
        premiers.add(REGIONAL_OPEN)
        premiers.add(REGIONAL_FINAL)
        return premiers
    }


    public static CptTournament fromString(String input) {
        if (input == null || input.length() == 0) return null
        CptTournament[] formats = CptTournament.values()
        for (CptTournament ct : formats)
            if (ct.name().toLowerCase().equals(input.toLowerCase())) {
                return ct
            }
        return null
    }

    public Integer getScore(Integer place) {
        switch (this) {
            case RANKING: return getRankingScore(place)
            case ONLINE_EVENT: return getRankingScore(place)
            case PREMIER: return getPremierScore(place)
            case REGIONAL_FINAL: return getRegionalFinalScore(place)
            case REGIONAL_OPEN: return getPremierScore(place)
            case PREMIER_SCORELESS: return 0
            case EVO: return getEvoScore(place)
            case QUALIFIER: return getRankingScore(place)
            case NONE: return 0
            default: return 0
        }
    }

    public Integer getPrize(Integer place) {
        switch (this) {
            case RANKING:
                return 0
            case ONLINE_EVENT:
                return 0
            case PREMIER:
                return getPremierPrize(place)
            case PREMIER_SCORELESS:
                return getPremierPrize(place)
            case EVO:
                return getEvoPrize(place)
            case REGIONAL_FINAL:
                return getPremierPrize(place)
            case REGIONAL_OPEN:
                return getPremierPrize(place)
            case QUALIFIER:
                return getRegionalFinalPrize(place)
            case NONE:
                return 0
            case CC:
                return getCapcomCupPrize(place)
            default:
                return 0
        }
    }

    public Integer getPrize(Integer place, CountryCode code) {
        if (code == CountryCode.JP || code == CountryCode.BR) return 0
        switch (this) {
            case RANKING: return 0
            case ONLINE_EVENT: return 0
            case PREMIER: return getPremierPrize(place)
            case REGIONAL_FINAL: return getPremierPrize(place)
            case REGIONAL_OPEN: return getPremierPrize(place)
            case PREMIER_SCORELESS: return getPremierPrize(place)
            case EVO: return getEvoPrize(place)
            case QUALIFIER: return 0
            case NONE: return 0
            case CC: return getCapcomCupPrize(place)
            default: return 0
        }
    }

    public Integer getRankingScore(Integer place) {
        def scores_ranking = [[200], [100], [80], [20], [10] * 2, [5] * 2].flatten()
        return place <= scores_ranking.size()? scores_ranking[place-1] : 0
    }

    public Integer getPremierScore(Integer place) {
        def scores_premier = [[700], [350], [200], [160], [130] * 2, [100] * 2, [70] * 4, [40] * 4, [20] * 8, [10] * 8,
                              [5] * 16].flatten()
        return place <= scores_premier.size()? scores_premier[place-1] : 0
    }

    public Integer getRegionalFinalScore(Integer place) {
        return 0
    }

    public Integer getEvoScore(Integer place) {
        def scores_evo = [[1000], [500], [300], [200], [160] * 2, [130] * 2, [100] * 4, [80] * 4, [60] * 8, [50] * 8,
                          [40] * 16, [30] * 16, [20] * 32, [10] * 32, [5] * 64].flatten()
        return place <= scores_evo.size()? scores_evo[place-1] : 0
    }

    public Integer getRegionalFinalPrize(Integer place) {
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
            case 3: return 7500;
            case 4: return 5000;
            case 5: return 2500;
            case 6: return 2500;
            case 7: return 1250;
            case 8: return 1250;
            default: return 0;
        }
    }

    public Integer getCapcomCupPrize(Integer place) {
        switch (place) {
            case 1: return 120000;
            case 2: return 50000;
            case 3: return 21500;
            case 4: return 12500;
            case 5: return 9000;
            case 6: return 9000;
            case 7: return 5000;
            case 8: return 5000;
            case 9: return 2000;
            case 10: return 2000;
            case 11: return 2000;
            case 12: return 2000;
            case 13: return 1000;
            case 14: return 1000;
            case 15: return 1000;
            case 16: return 1000;
            case [17..24]: return 500;
            case [25..32]: return 250;
            default: return 0;
        }
    }
}
