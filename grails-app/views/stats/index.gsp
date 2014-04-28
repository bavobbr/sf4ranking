<%@ page import="be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
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
        <td>${cstat.characterType}</td>
        <td>${cstat.timesUsed}</td>
        <td>${cstat.scoreAccumulated}</td>
        <td>${cstat.rankAccumulated}</td>
        <td>${cstat.usagePercentage}</td>

    </g:each>

  </table>
</div>
<g:render template="/templates/prettify"/>

</body>
</html>