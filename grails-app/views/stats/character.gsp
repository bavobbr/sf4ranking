<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version; be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <r:require modules="bootstrap"/>
    <title>Character statistics for ${stats?.characterType}</title>
</head>

<body>

<h2>Character statistics</h2>
This list character usage and performance statistics for ${stats.characterType} in ${stats.game}
<div class="alert alert-info alert-dismissable">
    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    You can sort on the columns by clicking the header!
</div>
This character is ranked against ${total} other characters
<div class="table-responsive">
    <table class="tablehead" id="datatable">
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
            <td>totalTimesUsed</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.totalTimesUsed}</td>
            </g:each>
            <td>${relativeStats.totalTimesUsed}</td>
        </tr>
        <tr>
            <td>totalUsagePercentage</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.totalUsagePercentage?.round(1)}</td>
            </g:each>
            <td>${relativeStats.totalUsagePercentage}</td>
        </tr>
        <tr>
            <td>asMain</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.asMain}</td>
            </g:each>
            <td>${relativeStats.asMain}</td>
        </tr>
        <tr>
            <td>asSecondary</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.asSecondary}</td>
            </g:each>
            <td>${relativeStats.asSecondary}</td>
        </tr>
        <tr>
            <td>asMainInTop100</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.asMainInTop100}</td></g:each>
            <td>${relativeStats.asMainInTop100}</td>
        </tr>
        <tr>
            <td>asMainInTop50</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.asMainInTop50}</td></g:each>
            <td>${relativeStats.asMainInTop50}</td>
        </tr>
        <tr>
            <td>scoreAccumulated</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.scoreAccumulated}</td></g:each>
            <td>${relativeStats.scoreAccumulated}</td>
        </tr>
        <tr>
            <td>decayedScoreAccumulated</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.decayedScoreAccumulated}</td></g:each>
            <td>${relativeStats.decayedScoreAccumulated}</td>
        </tr>
        <tr>
            <td>scoreAccumulatedByTop100</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.scoreAccumulatedByTop100}</td></g:each>
            <td>${relativeStats.scoreAccumulatedByTop100}</td>
        </tr>
        <tr>
            <td>decayedScoreAccumulatedByTop100</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.decayedScoreAccumulatedByTop100}</td></g:each>
            <td>${relativeStats.decayedScoreAccumulatedByTop100}</td>
        </tr>
        <tr>
            <td>top1finishes</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.top1finishes}</td></g:each>
            <td>${relativeStats.top1finishes}</td>
        </tr>
        <tr>
            <td>top3finishes</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.top3finishes}</td></g:each>
            <td>${relativeStats.top3finishes}</td>
        </tr>
        <tr>
            <td>top8finishes</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.top8finishes}</td></g:each>
            <td>${relativeStats.top8finishes}</td>
        </tr>
        <tr>
            <td>top16finishes</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.top16finishes}</td></g:each>
            <td>${relativeStats.top16finishes}</td>
        </tr>
        <tr>
            <td>spreadTop5Score</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.spreadTop5Score}</td></g:each>
            <td>${relativeStats.spreadTop5Score}</td>
        </tr>
        <tr>
            <td>meanTop5Score</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.meanTop5Score?.round(1)}</td></g:each>
            <td>${relativeStats.meanTop5Score}</td>
        </tr>
        <tr>
            <td>standardDeviationTop5Score</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.standardDeviationTop5Score?.round(1)}</td></g:each>
            <td>${relativeStats.standardDeviationTop5Score}</td>
        </tr>
        <tr>
            <td>spreadTop5Usage</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.spreadTop5Usage}</td></g:each>
            <td>${relativeStats.spreadTop5Usage}</td>
        </tr>
        <tr>
            <td>meanTop5Usage</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.meanTop5Usage?.round(1)}</td></g:each>
            <td>${relativeStats.meanTop5Usage}</td>
        </tr>
        <tr>
            <td>standardDeviationTop5Usage</td>
            <g:each in="${games}" var="game">
                <td>${game.value?.standardDeviationTop5Usage?.round(1)}</td></g:each>
            <td>${relativeStats.standardDeviationTop5Usage}</td>
        </tr>
    </table>
</div>

Top players using character as main:
<ol>
    <g:each in="${best5}" var="p">
        <li>
            <g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link> ${p.
                rank(stats.game)}</li>
    </g:each>
</ol>
Top players using character as secondary:
<ol>
    <g:each in="${best5secondaries}" var="p">
        <li>
            <g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link> ${p.
                rank(stats.game)}</li>
    </g:each>
</ol>
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