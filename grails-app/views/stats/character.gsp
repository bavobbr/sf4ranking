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
  You can sort on the columns by clicking the header! WORK IN PROGRESS
</div>
This character is ranked against ${total} other characters
<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Statistic</th>
      <th>Value</th>
      <th>Compared to others</th>
    </tr>
    </thead>
    <tr>
      <td>totalTimesUsed</td>
      <td>${stats.totalTimesUsed}</td>
      <td>${relativeStats.totalTimesUsed}</td>
    </tr>
    <tr>
      <td>totalUsagePercentage</td>
      <td>${stats.totalUsagePercentage}</td>
      <td>${relativeStats.totalUsagePercentage}</td>
    </tr>
    <tr>
      <td>asMain</td>
      <td>${stats.asMain}</td>
      <td>${relativeStats.asMain}</td>
    </tr>
    <tr>
      <td>asSecondary</td>
      <td>${stats.asSecondary}</td>
      <td>${relativeStats.asSecondary}</td>
    </tr>
    <tr>
      <td>asMainInTop100</td>
      <td>${stats.asMainInTop100}</td>
      <td>${relativeStats.asMainInTop100}</td>
    </tr>
    <tr>
      <td>asMainInTop50</td>
      <td>${stats.asMainInTop50}</td>
      <td>${relativeStats.asMainInTop50}</td>
    </tr>
    <tr>
      <td>scoreAccumulated</td>
      <td>${stats.scoreAccumulated}</td>
      <td>${relativeStats.scoreAccumulated}</td>
    </tr>
    <tr>
      <td>decayedScoreAccumulated</td>
      <td>${stats.decayedScoreAccumulated}</td>
      <td>${relativeStats.decayedScoreAccumulated}</td>
    </tr>
    <tr>
      <td>scoreAccumulatedByTop100</td>
      <td>${stats.scoreAccumulatedByTop100}</td>
      <td>${relativeStats.scoreAccumulatedByTop100}</td>
    </tr>
    <tr>
      <td>decayedScoreAccumulatedByTop100</td>
      <td>${stats.decayedScoreAccumulatedByTop100}</td>
      <td>${relativeStats.decayedScoreAccumulatedByTop100}</td>
    </tr>
    <tr>
      <td>top1finishes</td>
      <td>${stats.top1finishes}</td>
      <td>${relativeStats.top1finishes}</td>
    </tr>
    <tr>
      <td>top3finishes</td>
      <td>${stats.top3finishes}</td>
      <td>${relativeStats.top3finishes}</td>
    </tr>
    <tr>
      <td>top8finishes</td>
      <td>${stats.top8finishes}</td>
      <td>${relativeStats.top8finishes}</td>
    </tr>
    <tr>
      <td>top16finishes</td>
      <td>${stats.top16finishes}</td>
      <td>${relativeStats.top16finishes}</td>
    </tr>
  </table>
</div>

Top players using character as main:
<ol>
  <g:each in="${best5}" var="p">
    <li>
      <g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link> ${p.rank(stats.game)}</li>
  </g:each>
</ol>
Top players using character as secondary:
<ol>
  <g:each in="${best5secondaries}" var="p">
    <li>
      <g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link> ${p.rank(stats.game)}</li>
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