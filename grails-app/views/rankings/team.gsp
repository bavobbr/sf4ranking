<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Fighting Games World Rankings - ${team.name} Team Details</title>
</head>

<body>
<h2 class="tournament"><small>${team.name}</small> Team details</h2>

<div class="table-responsive">
  <table class="table table-striped table-hover tdetails">
    <thead>
    <tr>
      <th>Name</th>
      <th>Website</th>
      <th>Twitter</th>
      <th>Players</th>
    </tr>
    </thead>
    <tr>
      <td>${team.name}</td>
      <td>
        <g:if test="${team.website}">
        <a href="${team.website}" target="_blank">${team.website}</a>
        </g:if>
      </td>
      <td>
        <g:if test="${team.twitter}">
          <g:render template="/templates/follow" model="[twitter: team.twitter]"/>
        </g:if>
      </td>
      <td>${players.size()}</td>
      <td>
        <g:render template="/templates/prettify"/>
      </td>
    </tr>
  </table>
</div>

<h2 class="tournament"><large>found ${players.size()} players</large></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Main Game</th>
      <th>Player</th>
      <th>Country</th>
      <th>Score</th>
      <g:if test="${SecurityUtils.subject.isPermitted("team")}">
        <th>Edit</th>
      </g:if>
    </tr>
    </thead>
    <g:each in="${players}" var="player">
      <tr>
        <td>${player.mainGame.value}</td>
        <td><g:link mapping="playerByName" controller="rankings" action="player" params="[name: player.name]">${player.name}</g:link></td>
        <td>
          <g:if test="${player.countryCode != null}">
            <g:link controller="rankings" action="rank" params="[country: player.countryCode.name()]">
              <g:img dir="images/countries" file="${player.countryCode.name().toLowerCase() + '.png'}" class="countryflag"/>
              ${player.countryCode.name}
            </g:link>
          </g:if>
        </td>
        <td>${player.overallScore()}</td>
        <g:if test="${SecurityUtils.subject.isPermitted("team")}">
          <td><g:link controller="player" action="show" params="['id': player.id]">[Update player]</g:link></td>
          <td><g:link controller="admin" action="removeFromTeam" params="[pid: player.id, tid: team.id]">[Remove player]</g:link></td>
        </g:if>
      </tr>
    </g:each>
  </table>
</div>

<g:if test="${SecurityUtils.subject.isPermitted("team")}">
  <g:link controller="team" action="show" params="['id': team.id]">[Update team as admin]</g:link>
</g:if>


<g:render template="/templates/prettify"/>
</body>
</html>