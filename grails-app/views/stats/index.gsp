<%@ page import="be.bbr.sf4ranking.Version; be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - SSFIV:AE ver. 2012 - FAQ</title>
</head>

<body>

<h2>Stats</h2>
<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Character</th>
      <th>Times used</th>
      <th>Score accumulated</th>
      <th>Rank accumulated</th>
      <th>Usage %</th>
    </tr>
    </thead>
    <g:each in="${results}" var="cstat">
      <tr>
        <td>${cstat.characterType.value}</td>
        <td>${cstat.timesUsed}</td>
        <td>${cstat.scoreAccumulated}</td>
        <td>${cstat.rankAccumulated}</td>
        <td>${cstat.usagePercentage?.round(2)}</td>

    </g:each>

  </table>
</div>
Do a new analyse on
<ol>
<g:each in="${Version.values()}" var="game">
  <li><g:link controller="stats" action="analyze" params="[game:game.name()]">${game.name()}</g:link> </li>
</g:each>

</ol>
<g:render template="/templates/prettify"/>
</body>
</html>