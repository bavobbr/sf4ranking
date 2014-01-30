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
  <div class="message" role="status">${flash.message}</div>
</g:if>
<h2>Update</h2>
<ul>
  <li><g:link action="initializeTournamentWeights">update Tournament weights baed on player skills</g:link></li>
  <li><g:link action="updateTournamentTypes">update Tournament types based on tournament weights</g:link></li>
  <li><g:link action="updatePlayerScores">calculate and update player scores based on tournament performance</g:link></li>
  <li><g:link action="updatePlayerRank">calculate and update player rank based on player score</g:link></li>
  <li><g:link action="importer">import a new tournament...</g:link></li>
  <li><g:link action="printPlayers" params="[ranked: 'true']">print all players in the DB</g:link></li>
  <li><g:link action="printPlayers" params="[ranked: 'false']">print all unranked playersin the DB</g:link></li>
  <li><g:link action="merge">merge specified players...</g:link></li>
  <li><g:link action="exportTournaments">Export Tournaments and Results as JSON data...</g:link></li>
  <li><g:link action="exportPlayers">Export Players as JSON data...</g:link></li>

</ul>

<h2>BEWARE</h2>

One should first import all file data to initialize the database with content. Do not do it twice, it may override newer data or add the same.<br/>
If you want to restart use DELETE ALL and then do another import

<ul>
  <li><g:link action="deleteAll">Delete all DB data...</g:link></li>
  <li><g:link action="importFileData">Import all file data...</g:link></li>
</ul>
<br/>
</body>
</html>