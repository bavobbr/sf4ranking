<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - SSFIV:AE ver. 2012 - ${tournament.name} Tournament Diff Details</title>
</head>

<body>
<h2 class="tournament"><small>${tournament.name}</small> Tournament diff details</h2>

<div class="table-responsive">
  <table class="table table-striped table-hover tdetails">
    <thead>
    <tr>
      <th>Type</th>
      <th>Country</th>
      <th>Date</th>
      <th>Format</th>
      <th>Weight</th>
      <th>Format</th>
      <th>Ranked</th>
      <th>Weighting</th>
    </tr>
    </thead>
    <tr>
      <td>${tournament.tournamentType?.value}</td>
      <td>${tournament.countryCode?.name}</td>
      <td>${tournament.date?.format("MM-yyyy")}</td>
      <td>${tournament.tournamentFormat?.value}</td>
      <td>${tournament.weight}</td>
      <td>${tournament.tournamentFormat}</td>
      <td>${tournament.ranked}</td>
      <td>${tournament.weightingType}</td>
    </tr>
  </table>
</div>

<h2 class="tournament"><large>found ${players.size()} rankings</large></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Player</th>
      <th>Score before</th>
      <th>Score after</th>
      <th>Rank before</th>
      <th>Rank after</th>
      <th>Score diff</th>
      <th>Rank diff</th>
      <th>Edit</th>
    </tr>
    </thead>
    <g:each in="${players}" var="result">
      <tr>
        <td><g:link mapping="playerByName" controller="rankings" action="player" params="[name: result.name]">${result.name}</g:link></td>
        <td>${result.score}</td>
        <td>${result.scoreAfter}</td>
        <td>${result.rank}</td>
        <td>${result.rankAfter}</td>
        <td>${result.scoreDiff}</td>
        <td>${result.rankDiff}</td>
        <td><g:link controller="player" action="show" params="['id': result.id]">[Update player as admin]</g:link></td>
      </tr>
    </g:each>
  </table>
</div>

  <g:link controller="admin" action="selectTournamentVideos" params="['id': tournament.id]">[Update videos as admin]</g:link>
  <g:link controller="tournament" action="show" params="['id': tournament.id]">[Update tournament as admin]</g:link>
  <g:link controller="admin" action="playerDiffForTournament" params="['id': tournament.id]">[Diff page]</g:link>
  <g:link controller="admin" action="playerRanksBefore" params="['id': tournament.id]">[Scores before tournament]</g:link>
  <g:link controller="admin" action="playerRanksAfter" params="['id': tournament.id]">[Scores after tournament]</g:link>


<script type="text/javascript" charset="utf-8">
  $(document).ready(function ()
                    {
                      $("#datatable").tablecloth({
                                                   theme: "default",
                                                   striped: true,
                                                   sortable: true,
                                                   condensed: false
                                                 });
                    });
</script>
</body>
</html>