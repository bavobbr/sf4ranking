import be.bbr.sf4ranking.ScoringSystem
import be.bbr.sf4ranking.TournamentFormat
import be.bbr.sf4ranking.TournamentType

1.upto(64) {
    def score = ScoringSystem.getScore(it,TournamentType.GRAND_SLAM, TournamentFormat.DOUBLE_BRACKET)
    println "${it}. ${score}"
}