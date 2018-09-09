<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="artificial"/>
  <title>SRK data - Events</title>
</head>

<body>
<h2 class="tournament"><small>${events.size()} Events Registered</small></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Date</th>
      <th>Games</th>
      <th>Country</th>
      <th>Region</th>
      <th>Weight</th>
      <th>Average</th>
      <th>Contributors</th>
    </tr>
    </thead>
    <g:each in="${events}" var="event">

      <tr>
        <td><g:link mapping="eventByName" controller="rankings" action="event" params="[name: event.name]">${event.name}</g:link></td>
        <td>${event.date?.format("yyyy-MM-dd")}</td>
        <td>${event.tournaments.collect { it.game.name() }.join(", ") }</td>
        <td>${event.countryCode}</td>
        <td>${event.region}</td>
        <td>${event.weight}</td>
        <td>${event.averageWeight}</td>
        <td>${event.contributors?.split(",")?.countBy { it.trim() }?.collect { "$it.key: $it.value"}?.join(", ")}</td>
      </tr>
    </g:each>

  </table>
</div>


</body>
</html>