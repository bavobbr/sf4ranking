<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="artificial"/>
  <title>SRK data - Tournament Search</title>
</head>

<body>
<g:if test="${flash.message}">
  <div class="alert alert-warning">${flash.message}</div>
</g:if>

<h2>${tournaments? tournaments.size() : "0"} tournaments matching ${query}</h2>
<g:if test="${!(tournaments.isEmpty())}">

<div class="table-responsive">
  <table class="tablehead" id="datatable1">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Date</th>
      <th>Class</th>
      <th>Weight</th>
      <th>Country</th>
      <th>Game</th>
    </tr>
    </thead>
    <g:each in="${tournaments}" var="tournament">

      <tr>
        <td><g:link mapping="tournamentByName" controller="rankings" action="tournamentByName"
                    params="[name: tournament.name]">${tournament.name}</g:link></td>
        <td>${tournament.date}</td>
        <td>${tournament.tournamentType}</td>
        <td>${tournament.weight}</td>
        <td>${tournament.countryCode}</td>
        <td>${tournament.game.value}</td>
      </tr>
    </g:each>

  </table>
</div>
</g:if>




<h2>${events? events.size() : "0"} events matching ${query}</h2>
<g:if test="${!(events.isEmpty())}">
  <div class="table-responsive">
    <table class="tablehead" id="datatable2">
      <thead>
      <tr class="stathead">
        <th>Name</th>
        <th>Date</th>
        <th>Weight</th>
        <th>Country</th>
      </tr>
      </thead>
      <g:each in="${events}" var="event">

        <tr>
          <td><g:link mapping="eventByName" controller="rankings" action="eventByName"
                      params="[name: event.name]">${event.name}</g:link></td>
          <td>${event.date}</td>
          <td>${event.weight}</td>
          <td>${event.countryCode}</td>
        </tr>
      </g:each>

    </table>
  </div>
</g:if>


</body>
</html>