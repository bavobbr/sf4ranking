<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>SF4 World Ranking - Tournaments</title>
</head>

<body>
<h2>Tournaments Registered<small> found ${tournaments.size()} tournaments</small></h2>

<div class="table-responsive">
  <table class="table table-striped table-hover">
    <thead>
    <tr>
      <td>Name</td>
      <td>Type</td>
      <td>Date</td>
      <td>Location</td>
      <td>Game</td>
      <td>Weight</td>
      <td>Video</td>
    </tr>
    </thead>
    <g:each in="${tournaments}" var="t">

      <tr>
        <td><g:link controller="rankings" action="tournament" params="['id': t.id]">${t.name}</g:link></td>
        <td>${t.tournamentType?.value}</td>
        <td>${t.date?.format("MM-yyyy")}</td>
        <td>
          <g:if test="${t.countryCode}">
            <g:link controller="rankings" action="tournaments" params="[country: t.countryCode.name()]">
              <g:img dir="images/countries" file="${t.countryCode.name().toLowerCase() + '.png'}"/>
            </g:link>
          </g:if>
        </td>
        <td>${t.game?.value}</td>
        <td>${t.weight}</td>
        <td>
          <g:if test="${t.videos}">
            <a href="http://www.youtube.com/watch?v=${t.videos.first()}" target="_blank">Open</a>
          </g:if>
        </td>
      </tr>
    </g:each>

  </table>
</div>

<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Filter</h3>
  </div>

  <div class="panel-body">
    <g:form name="filter" controller="rankings" action="tournaments" role="form" class="form-inline" method="get">
      <g:select name="country" from="${countries}" class="form-control"/>
      <g:select name="version" from="${versions}" class="form-control"/>
      <g:select name="type" from="${types}" class="form-control"/>
      <button type="submit" class="btn btn-primary">Submit</button>
    </g:form>
  </div>
</div>
</body>
</html>