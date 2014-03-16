<%@ page import="be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking</title>
</head>

<body>
  <center>
  	<h2 class="title">Street Fighter World Rankings</h2><span class="glyphicon glyphicon-flash"></span>
  	<h4 class="subtitle">rank.shoryuken.com</h4>
  </center>

<g:if test="${updateMessage}">
<div class="alert alert-info alert-dismissable">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <g:message message="${updateMessage}"/>

</div>
</g:if>

<div class="row">
  <div class="col-md-6">
<div class="table-responsive">

  <table class="table table-striped table-hover table-condensed">
    <thead>
    <tr>
      <th>World Rank</th>
      <th>Name</th>
      <th>Team</th>
      <th>Score</th>
      <th>Country</th>
    </tr>
    </thead>

    <g:each in="${players}" var="p" status="idx">

      <tr>

        <td>${p.rank(Version.AE2012)}</td>
        <td><g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link></td>
        <td>
          <g:each in="${p.teams}" var="team">
            <g:link controller="rankings" mapping="teamByName" action="team" params="[name: team.name]">${team.shortname}</g:link>
          </g:each>
        </td>
        <td>${p.score(Version.AE2012)}</td>
        <td>
          <g:if test="${p.countryCode}">
            <g:link controller="rankings" action="rank" params="[country: p.countryCode.name()]">
              <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}" alt="Find players from ${p.countryCode.name}" class="countryflag"/>
            </g:link>
          </g:if>
        </td>
      </tr>
    </g:each>

  </table></div>
    </div>
  <div class="col-md-6">
    <div class="table-responsive">

      <table class="table table-striped table-hover table-condensed">
        <thead>
        <tr>
          <th>World Rank</th>
          <th>Name</th>
          <th>Team</th>
          <th>Score</th>
          <th>Country</th>
        </tr>
        </thead>

        <g:each in="${mvcplayers}" var="p" status="idx">

          <tr>

            <td>${p.rank(Version.UMVC3)}</td>
            <td><g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link></td>
            <td>
              <g:each in="${p.teams}" var="team">
                <g:link controller="rankings" mapping="teamByName" action="team" params="[name: team.name]">${team.shortname}</g:link>
              </g:each>
            </td>
            <td>${p.score(Version.UMVC3)}</td>
            <td>
              <g:if test="${p.countryCode}">
                <g:link controller="rankings" action="rank" params="[country: p.countryCode.name()]">
                  <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}" alt="Find players from ${p.countryCode.name}" class="countryflag"/>
                </g:link>
              </g:if>
            </td>
          </tr>
        </g:each>

      </table></div>
  </div>
  </div>
</body>
</html>