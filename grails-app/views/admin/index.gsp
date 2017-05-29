<%--
  Created by IntelliJ IDEA.
  User: bbr
  Date: 1/16/14
  Time: 1:51 PM
--%>

<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews">
  <title>Admin panel</title>
</head>

<body>
<h2>Admin data actions</h2>
<g:if test="${flash.message}">
  <div class="alert alert-warning">${flash.message}</div>
</g:if>
<g:if test="${isUpdating}">
  <div class="alert alert-warning">The rankings are currently being updated by ${isUpdatingBy}! Please wait to edit data</div>
</g:if>
<h3>Data input</h3>
<ul>
<li><g:link action="importer">import a new Tournament...</g:link></li>
<li><g:link action="clearCache">Clear caches (use after updating stuff)</g:link></li>
  </ul>


<h3>Weighting</h3>
The updateAll should be triggered every time a new tournament has been imported, as the tournament needs to be weighted and players scores need to be updated.
<ul>
  <g:each in="${Version.values()}" var="game">
    <li><g:link action="updateAll" params="[game: game]">update all data for ${game}</g:link></li>
  </g:each>

</ul>

<h3>Update parts of database</h3>
This is for fine-grained maintenance, usually not required.
<br/>Bulk edit allows you to easily edit meta-data of the top100 players. These should be as complete as possible.
<ul>
  <li><g:link action="merge">merge specified Players...</g:link></li>
  <g:each in="${Version.values()}" var="value">
    <li><g:link action="bulkedit" params="[game: value.name()]">bulk edit Players of ${value}</g:link></li>
  </g:each>
  <g:if test="${SecurityUtils.subject.hasRole("Administrator")}">
    <li><g:link action="initializeTournamentWeights">update Tournament weights based on player skills</g:link></li>
    <li><g:link action="updateTournamentTypes">update Tournament types based on tournament weights</g:link></li>
    <li><g:link action="resetProTour">Reset Pro Tour data</g:link></li>
    <li><g:link action="updatePlayerScores">calculate and update Player scores based on tournament performance</g:link></li>
    <li><g:link action="updatePlayerRank">calculate and update Player rank based on player score</g:link></li>
    <li><g:link action="updateMainCharacters">calculate and update Player main chars based on results</g:link></li>
    <li><g:link action="updateProTour">calculate and update Player CPT</g:link></li>
  </g:if>
  <li><g:link action="updateMainGames">calculate and update Player main games based on results</g:link></li>
</ul>

<h3>Auto-update player weights</h3>
This will completely recalculcate player weights based on their current ranking.</br>
This follows a logarythmic distribution and considers the highest of either actual rank or alltime rank for every player.
<ul>
  <g:each in="${Version.values()}" var="value">
    <li><g:link action="autoFillSkill" params="[game: value.name()]">Autofill skill of ${value.name()}</g:link></li>
  </g:each>
</ul>


<g:if test="${SecurityUtils.subject.hasRole("Administrator")}">
  <h3>Snapshots</h3>
  Store state for comparison in the ranking diffs
  <ul>
    <g:each in="${Version.values()}" var="value">
      <li><g:link action="snapshot" params="[game: value.name()]">take a snapshot of ${value.name()}</g:link></li>
    </g:each>
  </ul>
</g:if>

<h3>Export/debug</h3>
<ul>
  <li><g:link action="printPlayerRanks">print all players and their score</g:link></li>
  <li><g:link action="printTournamentSizes">print all Tournaments and player sizes</g:link></li>
  <li><g:link action="printEvents">print all Events</g:link></li>
  <li><g:link action="printPlayers" params="[ranked: 'true']">print all Players in the DB</g:link></li>
  <li><g:link action="printPlayers" params="[ranked: 'false']">print all unranked Players in the DB</g:link></li>
  <li><g:link action="exportTournaments">Export Tournaments and Results as JSON data...</g:link></li>
  <li><g:link action="exportPlayers">Export Players as JSON data...</g:link></li>
  <li><g:link action="exportTeams">Export Teams as JSON data...</g:link></li>
  <li><g:link action="exportHardware">Export Hardware as JSON data...</g:link></li>
<g:if test="${SecurityUtils.subject.hasRole("Administrator")}">
  <li><g:link action="listOrphanedPlayers">manage all orphaned Players in the DB</g:link></li>
  <li><g:link action="listAlikes">manage possible duplicate players</g:link></li>
</g:if>
</ul>

<g:if test="${SecurityUtils.subject.hasRole("Administrator")}">
  <h2>BEWARE</h2>

  One should first import all file data to initialize the database with content. Do not do it twice, it may override newer data or add the same.<br/>
  If you want to restart use DELETE ALL and then do another import. This imports the data bundled with the app, not the previous export. The fix methods are supplied to apply default values for data that previously did not have it.

  <ul>
    <li><g:link action="deleteAll">Delete all DB data...</g:link></li>
    <li><g:link action="importServerSideData">Import server-side JSON data</g:link></li>
    <li><g:link action="mergeSkills">Merge USF4 skill ratings into other SF4 games</g:link></li>
    <li><g:link action="findSkillDeviations">FindSkillDeviations</g:link></li>
    <li><g:link action="rollupEvents">rollupEvents</g:link></li>
  </ul>
  <br/>
</g:if>
</body>
</html>