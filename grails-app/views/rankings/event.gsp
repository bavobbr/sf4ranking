<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Fighting Games World Rankings - Event ${event.name}</title>
</head>

<body>
<h2 class="tournament"><small>${event.name}</small> details</h2>

<div class="table-responsive">
  <table class="table table-striped table-hover tdetails">
    <thead>
    <tr>
      <th>Name</th>
      <th>Date</th>
      <th>Twitter</th>
      <th>Host</th>
      <th>Country</th>
      <th>Region</th>
      <th>Weight</th>
    </tr>
    </thead>
    <tr>
      <td>${event.name}</td>
      <td>
        ${event.date}
      </td>
      <td>
        <g:if test="${event.twitter}">
          <g:render template="/templates/follow" model="[twitter: event.twitter]"/>
        </g:if>
      </td>
      <td>${event.host}</td>
      <td>${event.countryCode}</td>
      <td>${event.region}</td>
      <td>${event.weight}</td>
    </tr>
  </table>
</div>

<h2 class="tournament"><large>found ${event.tournaments.size()} tournaments</large></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Game</th>
      <th>Name</th>
      <th>Weight</th>
      <th>Top 3</th>
      <g:if test="${SecurityUtils.subject.isPermitted("event")}">
        <th>Edit</th>
      </g:if>
    </tr>
    </thead>
    <g:each in="${event.tournaments}" var="tournament">
      <tr>
        <td>${tournament.game.name()}</td>
        <td><g:link mapping="tournamentByName" controller="rankings" action="tournament" params="[name: tournament.name]">${tournament.name}</g:link></td>
        <td>${tournament.weight}</td>
        <td>${tournament.results.sort {it.place}.take(3).collect { it.player.name }.join(" / ")}</td>
        <g:if test="${SecurityUtils.subject.isPermitted("event")}">
          <td><g:link controller="tournament" action="show" params="['id': tournament.id]">[Update tournament]</g:link></td>
          <td><g:link controller="admin" action="removeFromEvent" params="[eid: event.id, tid: tournament.id]">[Remove tournament]</g:link></td>
        </g:if>
      </tr>
    </g:each>
  </table>
</div>

<g:if test="${SecurityUtils.subject.isPermitted("event")}">
  <g:link controller="event" action="show" params="['id': event.id]">[Update event as admin]</g:link>
</g:if>


<g:render template="/templates/prettify"/>
</body>
</html>