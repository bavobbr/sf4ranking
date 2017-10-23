<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="be.bbr.sf4ranking.CptTournament; org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>

<html>
<head>
  <meta name="layout" content="artificial"/>
  <g:if test="${game}">
  <title>SRK data - ${game.value} Tournaments</title>
  </g:if>
  <g:else>
    <title>SRK data - Tournaments</title>
  </g:else>
</head>

<body>
<h2 class="tournament">${game.value} Tournaments</h2>
${tournaments.size()} Tournaments Registered in results database.
<g:if test="${updateMessage}">
    <div class="alert alert-info alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:message message="${updateMessage}"/>

    </div>
</g:if>
<div class="table-responsive">
  <table class="tablehead table-condensed" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Type</th>
      <th>Date</th>
      <th>Location</th>
      <th>Event</th>
      <th>Weight</th>
      <th>Creator</th>
      <g:if test="${SecurityUtils.subject.isPermitted("tournament")}">
      <th>Ranking type</th>
      </g:if>
      <g:if test="${game == be.bbr.sf4ranking.Version.SF5}">
      <th>Pro Tour</th>
      </g:if>
    </tr>
    </thead>
    <g:each in="${tournaments}" var="t">

      <tr>
        <td><g:link mapping="tournamentByName" controller="rankings" action="tournament" params="[name: t.name]">${t.name}</g:link></td>
        <td>${t.tournamentType?.value}</td>
        <td>${t.date?.format("yyyy-MM-dd")}</td>
        <td>
          <g:if test="${t.countryCode}">
            <g:link controller="rankings" action="tournaments" params="[country: t.countryCode.name()]">
              <g:img dir="images/countries" file="${t.countryCode.name().toLowerCase() + '.png'}" class="countryflag" />
              ${t.countryCode.name}
            </g:link>
          </g:if>
        </td>
        <td>
      <g:if test="${t.event}">
        <g:link mapping="eventByName" controller="rankings" action="event" params="[name: t.event.name]">${t.event.name.take(20)}</g:link>
      </g:if>
        </td>
        <td>${t.weight}</td>
        <td>${t.creator}</td>
      <g:if test="${SecurityUtils.subject.isPermitted("tournament")}">
        <td>${t.weightingType}</td>
      </g:if>
        <td>
          <g:if test="${game == be.bbr.sf4ranking.Version.SF5}">
            ${t.cptTournament?.value}
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
      <g:select name="id" from="${versions}" class="form-control"/>
      <g:select name="type" from="${types}" class="form-control"/>
      <button type="submit" class="btn btn-primary">Submit</button>
    </g:form>
  </div>
</div>



</body>
</html>