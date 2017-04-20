package be.bbr.sf4ranking

import groovy.util.logging.Log4j

import static java.util.Calendar.MONTH
import static java.util.Calendar.YEAR

/**
 * This class encapsulates all logic for ranks and scores to be given when a tournament is added
 * Currently all lists are 32 entries. Care should be taken to have at least that otherwise 32-player tournaments will not find data
 */
@Log4j
class ScoringSystem
{
    /**
     * This should not be used
     */
    private static final Map zero_scores = [
            "GRAND_SLAM": [0] * 64,
            "CHAMPIONSHIP": [0] * 64,
            "PREMIER_MANDATORY": [0] * 64,
            "PREMIER_5": [0] * 64,
            "PREMIER_12": [0] * 64,
            "INTERNATIONAL": [0] * 64,
            "SERIES": [0] * 64,
            "CIRCUIT": [0] * 64,
            "LOCAL": [0] * 64
    ]
    /**
     * the AUTO algorithm wont ever select CHAMPIONSHIP or TOURNAMENT_CHAMPIONS as these are reserved for Fixed LEAGUE types.
     * But adding them in anyway helps robustness
     */
    private static final Map single_scores = [
            "GRAND_SLAM": [2000, 1300, [780] * 2, [430] * 4, [240] * 8, [120] * 16, [70] * 16, [40]*16].flatten(),
            "CHAMPIONSHIP": [1500, 1050, [690] * 2, [320] * 4, [200] * 8, [100] * 16, [60] * 16, [35]*16].flatten(),
            "PREMIER_MANDATORY": [1000, 650, [390] * 2, [215] * 4, [120] * 8, [60] * 16, [40] * 16, [25]*16].flatten(),
            "PREMIER_5": [900, 585, [350] * 2, [190] * 4, [105] * 8, [50] * 16, [30] * 16, [20]*16].flatten(),
            "PREMIER_12": [470, 305, [185] * 2, [100] * 4, [55] * 8, [25] * 16, [10] * 16, [5]*16].flatten(),
            "INTERNATIONAL": [280, 180, [110] * 2, [60] * 4, [30] * 8, [15] * 16, [10] * 16, [6]*16].flatten(),
            "SERIES": [160, 95, [57] * 2, [29] * 4, [15] * 8, [7] * 16, [4] * 16, [2]*16].flatten(),
            "CIRCUIT": [70, 50, [25] * 2, [20] * 4, [10] * 8, [5] * 16, [3] * 16, [1]*16].flatten(),
            "LOCAL": [30, 20, [15] * 2, [13] * 4, [5] * 8, [2] * 16, [1] * 16, [1]*16].flatten()
    ]

    /**
     * the AUTO algorithm wont ever select CHAMPIONSHIP or TOURNAMENT_CHAMPIONS as these are reserved for Fixed LEAGUE types..
     * But adding them in anyway helps robustness
     */
    private static final Map double_scores = [
            "GRAND_SLAM": [2000, 1300, 780, 600, [430] * 2, [340] * 2, [240] * 8, [120] * 16, [70] * 16, [40]*16].flatten(),
            "CHAMPIONSHIP": [1500, 1050, 690, 500, [320] * 2, [280] * 2, [200] * 8, [100] * 16, [60] * 16, [35]*16].flatten(),
            "PREMIER_MANDATORY": [1000, 650, 390, 300, [215] * 2, [180] * 2, [120] * 8, [60] * 16, [40] * 16, [25]*16].flatten(),
            "PREMIER_5": [900, 585, 350, 250, [190] * 2, [150] * 2, [105] * 8, [50] * 16, [30] * 16, [20]*16].flatten(),
            "PREMIER_12": [470, 305, 185, 150, [100] * 2, [80] * 2, [55] * 8, [25] * 16, [10] * 16, [5]*16].flatten(),
            "INTERNATIONAL": [280, 180, 110, 80, [60] * 2, [50] * 2, [30] * 8, [15] * 16, [10] * 16, [6]*16].flatten(),
            "SERIES": [160, 95, 57, 40, [29] * 2, [24] * 2, [15] * 8, [7] * 16, [4] * 16, [2]*16].flatten(),
            "CIRCUIT": [70, 50, 30, 25, [15] * 2, [10] * 2, [8] * 8, [5] * 16, [3] * 16, [2]*16].flatten(),
            "LOCAL": [30, 20, 18, 12, [8] * 2, [6] * 2, [4] * 8, [3] * 16, [2] * 16, [1]*16].flatten(),
            "TOURNAMENT_CHAMPIONS": [100, 60, 35, 30, [20] * 2, [16] * 2, [7] * 8, [3] * 16, [5] * 16, [3]*16].flatten(),
            "ROUND_ROBIN_GROUP_STAGE": [50, 30, 18, 15, [10] * 2, [8] * 2, [3] * 8, [2] * 16, [1] * 16, [1]*16].flatten(),
    ]

    /**
     * If we select leagues always as Round Robin tournament types of WTA they are either CHAMPIONSHIP or TOURNAMENT_CHAMPIONS
     * but adding all types is safer if you want to say fixed with format league and any other type.
     */
    private static final Map league_scores = [
            "GRAND_SLAM": [2000, 1300, [780] * 2, [430] * 4, [240] * 8, [120] * 16, [70] * 16, [40]*16].flatten(),
            "CHAMPIONSHIP": [1500, 1050, 690, 620, 550, 480, 410, 340, 270, 200, 130, [70]*5, [40]*16, [30] * 16, [20]*16].flatten(),
            "PREMIER_MANDATORY": [1000, 650, [390] * 2, [215] * 4, [120] * 8, [60] * 16, [40] * 16, [25]*16].flatten(),
            "PREMIER_5": [900, 585, [350] * 2, [190] * 4, [105] * 8, [50] * 16, [30] * 16, [20]*16].flatten(),
            "PREMIER_12": [470, 305, [185] * 2, [100] * 4, [55] * 8, [25] * 16, [10] * 16, [5]*16].flatten(),
            "INTERNATIONAL": [280, 180, [110] * 2, [60] * 4, [30] * 8, [15] * 16, [10] * 16, [6]*16].flatten(),
            "SERIES": [160, 95, [57] * 2, [29] * 4, [15] * 8, [7] * 16, [4] * 16, [2]*16].flatten(),
            "CIRCUIT": [100, 60, [35] * 2, [20] * 4, [7] * 8, [3] * 16, [2] * 16, [1]*16].flatten(),
            "LOCAL": [30, 20, 18, 12, [8] * 2, [6] * 2, [4] * 8, [3] * 16, [2] * 16, [1]*16].flatten(),
            "TOURNAMENT_CHAMPIONS": [375, 255, 180, 155, 130, 105, 80, 55, 30, [5]*7, [3]*16, [2] * 16, [1]*16].flatten(),
            "ROUND_ROBIN_GROUP_STAGE": [180, 125, 90, 75, 65, 50, 40, 25, 15, [3]*7, [2]*16, [1] * 16, [1]*16].flatten(),
    ]

    /**
     * These are the logical ranks to be distributed sequentially according to the given tournament format
     */
    private static final Map ranks = [
            EXHIBITION: 1..64,
            LEAGUE: 1..64,
            UNKNOWN: 1..64,
            SINGLE_BRACKET: [1, 2, [3] * 2, [5] * 4, [9] * 8, [17] * 16, [33] * 32].flatten(),
            DOUBLE_BRACKET: [1, 2, 3, 4, [5] * 2, [7] * 2, [9] * 4, [13] * 4, [17] * 8, [25] * 8, [33] * 16, [49] * 16].flatten()
    ]

    private static final Map scores = [
            "UNKNOWN": zero_scores,
            "EXHIBITION": zero_scores,
            "SINGLE_BRACKET": single_scores,
            "DOUBLE_BRACKET": double_scores,
            "LEAGUE": league_scores
    ]

    public static Integer getScore(Integer rank, TournamentType tournamentType, TournamentFormat tournamentFormat = TournamentFormat.DOUBLE_BRACKET)
    {
        if (tournamentType == TournamentType.UNRANKED) return 0;
        Map formatscores = scores[tournamentFormat.name()]
        List typescores = formatscores[tournamentType.name()] as List
        return typescores[rank - 1] as Integer
    }

    public static Integer getLegacyScore(Integer rank, Long weight, TournamentFormat tournamentFormat = TournamentFormat.DOUBLE_BRACKET)
    {
        Map formatscores = scores[tournamentFormat.name()]
        List typescores = formatscores[TournamentType.GRAND_SLAM.name()] as List
        def score = typescores[rank - 1] as Integer
        return (score * weight / 1000) as Integer
    }

    public static Integer getDecayedScore(Date date, Integer rank, TournamentType tournamentType, TournamentFormat tournamentFormat = TournamentFormat.DOUBLE_BRACKET)
    {
        double decayFactor = 0.0
        Integer monthsAgo = getMonthsDifference(date, new Date())
        switch (monthsAgo) {
            case { monthsAgo > 24 }: decayFactor = 0.98; break
            case { monthsAgo > 23 }: decayFactor = 0.95; break
            case { monthsAgo > 22 }: decayFactor = 0.92; break
            case { monthsAgo > 21 }: decayFactor = 0.9; break
            case { monthsAgo > 20 }: decayFactor = 0.8; break
            case { monthsAgo > 19 }: decayFactor = 0.7; break
            case { monthsAgo > 18 }: decayFactor = 0.65; break
            case { monthsAgo > 17 }: decayFactor = 0.6; break
            case { monthsAgo > 16 }: decayFactor = 0.55; break
            case { monthsAgo > 15 }: decayFactor = 0.5; break
            case { monthsAgo > 14 }: decayFactor = 0.45; break
            case { monthsAgo > 13 }: decayFactor = 0.4; break
            case { monthsAgo > 12 }: decayFactor = 0.35; break
            case { monthsAgo > 11 }: decayFactor = 0.3; break
            case { monthsAgo > 10 }: decayFactor = 0.25; break
            case { monthsAgo > 9 }: decayFactor = 0.20; break
            case { monthsAgo > 8 }: decayFactor = 0.15; break
            case { monthsAgo > 7 }: decayFactor = 0.10; break
            case { monthsAgo > 6 }: decayFactor = 0.08; break
            case { monthsAgo > 5 }: decayFactor = 0.05; break
            case { monthsAgo > 4 }: decayFactor = 0.02; break
            case { monthsAgo > 3 }: decayFactor = 0.0; break
        }
        def normalScore = getScore(rank, tournamentType, tournamentFormat)
        Double decayedScore = normalScore * (1.0-decayFactor);
        return decayedScore as Integer
    }

    private static final Integer getMonthsDifference(Date date1, Date date2) {
        def (cal1, cal2) = [Calendar.instance, Calendar.instance]
        cal1.time = date1
        cal2.time = date2
        int m1 = cal1.get(YEAR) * 12 + cal1.get(MONTH)
        int m2 = cal2.get(YEAR) * 12 + cal2.get(MONTH)
        return m2 - m1 + 1
    }


    public static Integer getRank(Integer index, TournamentFormat tournamentFormat)
    {
        List typeranks = ranks[tournamentFormat.name()] as List
        return typeranks[index - 1] as Integer
    }
}
