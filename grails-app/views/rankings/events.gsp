<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Fighting Games World Rankings - Events</title>
</head>

<body>
<h2 class="tournament"><small>${events.size()} Events Registered</small></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Date</th>
      <th>Twitter</th>
      <th>Games</th>
      <th>Country</th>
      <th>Region</th>
      <th>Weight</th>
      <th>Host</th>
    </tr>
    </thead>
    <g:each in="${events}" var="event">

      <tr>
        <td><g:link mapping="eventByName" controller="rankings" action="event" params="[name: event.name]">${event.name}</g:link></td>
        <td>${event.date?.format("yyyy-MM-dd")}</td>
        <td>
          <g:if test="${event.twitter}">
            <a href="https://twitter.com/${event.twitter}" target="_blank">${event.twitter}</a>
          </g:if>
        </td>
        <td>${event.tournaments.collect { it.game.name() }.join(", ") }</td>
        <td>${event.countryCode}</td>
        <td>${event.region}</td>
        <td>${event.weight}</td>
        <td>${event.host}</td>
      </tr>
    </g:each>

  </table>
</div>

<g:render template="/templates/prettify"/>

</body>
</html>