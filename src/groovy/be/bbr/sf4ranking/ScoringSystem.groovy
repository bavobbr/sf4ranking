package be.bbr.sf4ranking

import groovy.util.logging.Log4j

/**
 * This class encapsulates all logic for ranks and scores to be given when a tournament is added
 *
 * Currently all lists are 32 entries. Care should be taken to have at least that.
 */
@Log4j
class ScoringSystem
{
    /**
     * the AUTO algorythm wont ever select CHAMPIONSHIP or TOURNAMENT_CHAMPIONS as these are reserved for Fixed LEAGUE types.
     * But adding them in anyway helps robustness
     */
    private static final Map single_scores = [
            "GRAND_SLAM": [2000, 1300, [780] * 2, [430] * 4, [240] * 8, [120] * 16].flatten(),
            "CHAMPIONSHIP": [1500, 1050, [690] * 2, [320] * 4, [200] * 8, [100] * 16].flatten(),
            "PREMIER_MANDATORY": [1000, 650, [390] * 2, [215] * 4, [120] * 8, [60] * 16].flatten(),
            "PREMIER_5": [900, 585, [350] * 2, [190] * 4, [105] * 8, [50] * 16].flatten(),
            "PREMIER_12": [470, 305, [185] * 2, [100] * 4, [55] * 8, [25] * 16].flatten(),
            "INTERNATIONAL": [280, 180, [110] * 2, [60] * 4, [30] * 8, [15] * 16].flatten(),
            "SERIES": [160, 95, [57] * 2, [29] * 4, [15] * 8, [7] * 16].flatten(),
            "CIRCUIT": [100, 60, [35] * 2, [20] * 4, [7] * 8, [3] * 16].flatten(),
    ]

    /**
     * the AUTO algorythm wont ever select CHAMPIONSHIP or TOURNAMENT_CHAMPIONS as these are reserved for Fixed LEAGUE types..
     * But adding them in anyway helps robustness
     */
    private static final Map double_scores = [
            "GRAND_SLAM": [2000, 1300, [780] * 2, [430] * 4, [240] * 8, [120] * 16].flatten(),
            "CHAMPIONSHIP": [1500, 1050, [690] * 2, [320] * 4, [200] * 8, [100] * 16].flatten(),
            "PREMIER_MANDATORY": [1000, 650, [390] * 2, [215] * 4, [120] * 8, [60] * 16].flatten(),
            "PREMIER_5": [900, 585, [350] * 2, [190] * 4, [105] * 8, [50] * 16].flatten(),
            "PREMIER_12": [470, 305, [185] * 2, [100] * 4, [55] * 8, [25] * 16].flatten(),
            "INTERNATIONAL": [280, 180, [110] * 2, [60] * 4, [30] * 8, [15] * 16].flatten(),
            "SERIES": [160, 95, [57] * 2, [29] * 4, [15] * 8, [7] * 16].flatten(),
            "CIRCUIT": [100, 60, [35] * 2, [20] * 4, [7] * 8, [3] * 16].flatten(),
            "TOURNAMENT_CHAMPIONS": [100, 60, [35] * 2, [20] * 4, [7] * 8, [3] * 16].flatten(),
    ]

    /**
     * If we select leagues always as Round Robin tournament types of WTA they are either CHAMPIONSHIP or TOURNAMENT_CHAMPIONS
     * but adding all types is safer if you want to say fixed with format league and any other type.
     */
    private static final Map league_scores = [
            "GRAND_SLAM": [2000, 1300, [780] * 2, [430] * 4, [240] * 8, [120] * 16].flatten(),
            "CHAMPIONSHIP": [1500, 1050, [690] * 2, [320] * 4, [200] * 8, [100] * 16].flatten(),
            "PREMIER_MANDATORY": [1000, 650, [390] * 2, [215] * 4, [120] * 8, [60] * 16].flatten(),
            "PREMIER_5": [900, 585, [350] * 2, [190] * 4, [105] * 8, [50] * 16].flatten(),
            "PREMIER_12": [470, 305, [185] * 2, [100] * 4, [55] * 8, [25] * 16].flatten(),
            "INTERNATIONAL": [280, 180, [110] * 2, [60] * 4, [30] * 8, [15] * 16].flatten(),
            "SERIES": [160, 95, [57] * 2, [29] * 4, [15] * 8, [7] * 16].flatten(),
            "CIRCUIT": [100, 60, [35] * 2, [20] * 4, [7] * 8, [3] * 16].flatten(),
            "TOURNAMENT_CHAMPIONS": [100, 60, [35] * 2, [20] * 4, [7] * 8, [3] * 16].flatten(),
    ]

    /**
     * These are the logical ranks to be distributed sequentially according to the given tournament format
     */
    private static final Map ranks = [
            LEAGUE: 1..32,
            UNKNOWN: 1..32,
            SINGLE_BRACKET: [1, 2, [3] * 2, [5] * 4, [9] * 8, [17] * 16].flatten(),
            DOUBLE_BRACKET: [1, 2, 3, 4, [5] * 2, [7] * 2, [9] * 4, [13] * 4, [17] * 8, [25] * 8].flatten()
    ]

    private static final Map scores = [
            "UNKNOWN": single_scores,
            "SINGLE_BRACKET": single_scores,
            "DOUBLE_BRACKET": double_scores,
            "LEAGUE": league_scores
    ]

    public static Integer getScore(Integer rank, TournamentType tournamentType, TournamentFormat tournamentFormat)
    {
        Map formatscores = scores[tournamentFormat.name()]
        List typescores = formatscores[tournamentType.name()] as List
        return typescores[rank - 1] as Integer
    }

    public static Integer getRank(Integer index, TournamentFormat tournamentFormat)
    {
        List typeranks = ranks[tournamentFormat.name()] as List
        return typeranks[index - 1] as Integer
    }
}
