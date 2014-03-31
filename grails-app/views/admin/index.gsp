<%--
  Created by IntelliJ IDEA.
  User: bbr
  Date: 1/16/14
  Time: 1:51 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews">
  <r:require modules="bootstrap"/>
  <title>Admin panel</title>
</head>

<body>
<h2>Admin data actions</h2>
<g:if test="${flash.message}">
  <div class="alert alert-warning">${flash.message}</div>
</g:if>
<h3>Update database</h3>
The updateAll should be triggered every time a new tournament has been imported, as the tournament needs to be weighted and players scores need to be updated.
<ul>
  <li><g:link action="importer">import a new Tournament...</g:link></li>
  <li><g:link action="updateAll">update all Tournament and Player data</g:link></li>
</ul>

<h3>Update parts of database</h3>
This is for fine-grained maintenance, usually not required.
<ul>
  <li><g:link action="merge">merge specified Players...</g:link></li>
  <li><g:link action="initializeTournamentWeights">update Tournament weights based on player skills</g:link></li>
  <li><g:link action="updateTournamentTypes">update Tournament types based on tournament weights</g:link></li>
  <li><g:link action="updatePlayerScores">calculate and update Player scores based on tournament performance</g:link></li>
  <li><g:link action="updatePlayerRank">calculate and update Player rank based on player score</g:link></li>
  <li><g:link action="updateMainCharacters">calculate and update Player main chars based on results</g:link></li>
  <li><g:link action="updateMainGames">calculate and update Player main games based on results</g:link></li>
</ul>

<h3>Export/debug</h3>
<ul>
  <li><g:link action="printPlayerRanks">print all players and their score</g:link></li>
  <li><g:link action="printTournamentSizes">print all Tournaments and player sizes</g:link></li>
  <li><g:link action="printPlayers" params="[ranked: 'true']">print all Players in the DB</g:link></li>
  <li><g:link action="printPlayers" params="[ranked: 'false']">print all unranked Players in the DB</g:link></li>
  <li><g:link action="exportTournaments">Export Tournaments and Results as JSON data...</g:link></li>
  <li><g:link action="exportPlayers">Export Players as JSON data...</g:link></li>
  <li><g:link action="exportTeams">Export Teams as JSON data...</g:link></li>
</ul>

<h2>BEWARE</h2>

One should first import all file data to initialize the database with content. Do not do it twice, it may override newer data or add the same.<br/>
If you want to restart use DELETE ALL and then do another import. This imports the data bundled with the app, not the previous export. The fix methods are supplied to apply default values for data that previously did not have it.

<ul>
  <li><g:link action="deleteAll">Delete all DB data...</g:link></li>
  <li><g:link action="importServerSideData">Import server-side JSON data</g:link></li>
  <li><g:link action="fixTournamentFormats">Do a best guess on ALL tournament formats and apply it</g:link></li>
  <li><g:link action="fixPlayerRankings">Re-adjust ALL player ranks based on tournament format</g:link></li>
</ul>
<br/>
</body>
</html>