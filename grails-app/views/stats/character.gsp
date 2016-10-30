<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version; be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>${stats?.characterType?.shortname} Character statistics and tournament results</title>
</head>

<body>

<h2>${stats?.game?.name()} ${stats?.characterType?.shortname} statistics and tournament results</h2>
This list character usage and tournament performance statistics for ${stats?.characterType?.shortname} in ${stats?.game}.
This character is compared versus ${total} other characters in ${stats?.game?.value} (1 means best).
<div class="table-responsive">
    <table class="tablehead" id="datatable4">
        <thead>
        <tr class="stathead">
            <th>Statistic</th>
            <g:each in="${games}" var="game">
                <th>${game.key}</th>
            </g:each>
            <th>Compared to others</th>
        </tr>
        </thead>
        <tr>
            <td>Total times used</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.totalTimesUsed}</td>
            </g:each>
            <td>${relativeStats.totalTimesUsed}</td>
        </tr>
        <tr>
            <td>Total Uage Percentage</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.totalUsagePercentage?.round(1)}</td>
            </g:each>
            <td>${relativeStats.totalUsagePercentage}</td>
        </tr>
        <tr>
            <td>Used by players use as main</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.asMain}</td>
            </g:each>
            <td>${relativeStats.asMain}</td>
        </tr>
        <tr>
            <td>Used by players as secondary</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.asSecondary}</td>
            </g:each>
            <td>${relativeStats.asSecondary}</td>
        </tr>
        <tr>
            <td>Main players in top 100</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.asMainInTop100}</td></g:each>
            <td>${relativeStats.asMainInTop100}</td>
        </tr>
        <tr>
            <td>Main players in top 50</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.asMainInTop50}</td></g:each>
            <td>${relativeStats.asMainInTop50}</td>
        </tr>
        <tr>
            <td>Accumulated score</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.scoreAccumulated}</td></g:each>
            <td>${relativeStats.scoreAccumulated}</td>
        </tr>
        <tr>
            <td>Decayed accumulated score</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.decayedScoreAccumulated}</td></g:each>
            <td>${relativeStats.decayedScoreAccumulated}</td>
        </tr>
        <tr>
            <td>Accumulated score by top 100 players</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.scoreAccumulatedByTop100}</td></g:each>
            <td>${relativeStats.scoreAccumulatedByTop100}</td>
        </tr>
        <tr>
            <td>Decayed accumulated score by top 100 players</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.decayedScoreAccumulatedByTop100}</td></g:each>
            <td>${relativeStats.decayedScoreAccumulatedByTop100}</td>
        </tr>
        <tr>
            <td>Tournament wins</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.top1finishes}</td></g:each>
            <td>${relativeStats.top1finishes}</td>
        </tr>
        <tr>
            <td>Tournament top3 finishes</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.top3finishes}</td></g:each>
            <td>${relativeStats.top3finishes}</td>
        </tr>
        <tr>
            <td>Tournament top8 finishes</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.top8finishes}</td></g:each>
            <td>${relativeStats.top8finishes}</td>
        </tr>
        <tr>
            <td>Tournament top16 finishes</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.top16finishes}</td></g:each>
            <td>${relativeStats.top16finishes}</td>
        </tr>
        <tr>
            <td>Statistical spread best 5 player score</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.spreadTop5Score}</td></g:each>
            <td>${relativeStats.spreadTop5Score}</td>
        </tr>
        <tr>
            <td>Statistical mean of best 5 player score</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.meanTop5Score?.round(1)}</td></g:each>
            <td>${relativeStats.meanTop5Score}</td>
        </tr>
        <tr>
            <td>Statistical deviation of best 5 player score</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.standardDeviationTop5Score?.round(1)}</td></g:each>
            <td>${relativeStats.standardDeviationTop5Score}</td>
        </tr>
        <tr>
            <td>Statistical spread of usage by top 5 players</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.spreadTop5Usage}</td></g:each>
            <td>${relativeStats.spreadTop5Usage}</td>
        </tr>
        <tr>
            <td>Statistical mean of usage by top 5 players</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.meanTop5Usage?.round(1)}</td></g:each>
            <td>${relativeStats.meanTop5Usage}</td>
        </tr>
        <tr>
            <td>Statistical deviation of usage by top 5 players</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.standardDeviationTop5Usage?.round(1)}</td></g:each>
            <td>${relativeStats.standardDeviationTop5Usage}</td>
        </tr>
    </table>
</div>

(Note that local tournaments are excluded)<br/>
<h3>Top players</h3>

Top players using character as main
<ol>
    <g:each in="${best5}" var="p">
        <li>
            <g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link> (rank: ${p.
                rank(stats.game)})</li>
    </g:each>
</ol>
Top players that used character as secondary at least once
<ol>
    <g:each in="${best5secondaries}" var="p">
        <li>
            <g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link> (rank: ${p.
                rank(stats.game)})</li>
    </g:each>
</ol>
</p>

<h3>Character Tournament Performance</h3>
This list character usage and performance statistics for ${characterType.value} in ${game} (local tournaments included)

<div class="table-responsive">
    <table class="tablehead" id="datatable">
        <thead>
        <tr class="stathead">
            <th>Statistic</th>
            <th>Value</th>
        </tr>
        </thead>
        <tr>
            <td>Top16 finishes</td>
            <td>${top16}</td>
        </tr>
        <tr>
            <td>Top8 finishes</td>
            <td>${top8}</td>
        </tr>
        <tr>
            <td>Top3 finishes</td>
            <td>${top3}</td>
        </tr>
        <tr>
            <td>Tournament wins</td>
            <td>${top1}</td>
        </tr>
        <tr>
            <td>Total times listed</td>
            <td>${totalResults}</td>
        </tr>
        <tr>
            <td>Total tournaments used</td>
            <td>${totalTournamentsUsed}</td>
        </tr>
        <tr>
            <td>Relative occurence in results</td>
            <td>${usedPercentage}%</td>
        </tr>
    </table>
</div>

<h3>Tournament Wins</h3>
These are all the ${tournamentWins.size()} non-local circuits where ${characterType.shortname} won


<div class="table-responsive">
    <table class="tablehead" id="datatable2">
        <thead>
        <tr class="stathead">
            <th>Tournament</th>
            <th>Place</th>
            <th>Country</th>
            <th>Score</th>
            <th>Weight</th>
            <th>Class</th>
            <th>CPT</th>
            <th>Player</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${tournamentWins}" var="result">
            <tr>
                <td>
                    <g:link controller="rankings" action="tournament" params="[id: result.tournament.id]">
                        ${result.tournament.name}
                    </g:link>
                </td>
                <td>${result.place}</td>

                <td>${result.tournament.countryCode}</td>
                <td>${ScoringSystem.getScore(result.place, result.tournament.tournamentType, result.tournament.tournamentFormat)}</td>
                <td>${result.tournament.weight}</td>
                <td>${result.tournament.tournamentType.value}</td>
                <td>${result.tournament.cptTournament.value}</td>

                <td>
                    <g:link controller="rankings" action="player" params="[id: result.player.id]">
                        ${result.player.name}
                    </g:link>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<h3>Tournament results</h3>
These are all the ${tournamentAll.size()} non-local circuits where ${characterType.shortname} was listed in the top results:

<div class="table-responsive">
    <table class="tablehead" id="datatable3">
        <thead>
        <tr class="stathead">
            <th>Tournament</th>
            <th>Place</th>
            <th>Country</th>
            <th>Score</th>
            <th>Weight</th>
            <th>Class</th>
            <th>CPT</th>
            <th>Player</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${tournamentAll}" var="result">
            <tr>
                <td>
                    <g:link controller="rankings" action="tournament" params="[id: result.tournament.id]">
                        ${result.tournament.name}
                    </g:link>
                </td>
                <td>${result.place}</td>

                <td>${result.tournament.countryCode}</td>
                <td>${ScoringSystem.getScore(result.place, result.tournament.tournamentType, result.tournament.tournamentFormat)}</td>
                <td>${result.tournament.weight}</td>
                <td>${result.tournament.tournamentType.value}</td>
                <td>${result.tournament.cptTournament.value}</td>

                <td>
                    <g:link controller="rankings" action="player" params="[id: result.player.id]">
                        ${result.player.name}
                    </g:link>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

Other character results at <g:link action="index" params="[game: stats.game]">Character Statistics</g:link> page.
<script type="text/javascript" charset="utf-8">
    $(document).ready(function ()
                      {
                          $('table[id^="datatable"]').each(function (index)
                                                           {
                                                               $(this).tablecloth({
                                                                                      theme: "default",
                                                                                      striped: true,
                                                                                      sortable: true,
                                                                                      condensed: true});
                                                               //$(this).tablesorter({sortList: [[1,1]]})
                                                           })
                      });
</script>
</body>
</html>