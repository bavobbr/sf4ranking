<%@ page import="be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Fighting Games World Rankings</title>
</head>

<body>
  <center>
  	<h2 class="title">Fighting Games World Rankings</h2><span class="glyphicon glyphicon-flash"></span>
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
    <h4>SF4:AE 2012 Top 20</h4>
<div class="table-responsive">

  <table class="table table-striped table-hover table-condensed">
    <thead>
    <tr>
      <th>Rank</th>
      <th>Name</th>
      <th>Team</th>
      <th>Score</th>
      <th>Character</th>
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
          <g:link action="rank" controller="rankings" params="[pchar: p.main(Version.AE2012), id: Version.AE2012.name()]">
            <g:img dir="images/chars" file="${p.main(Version.AE2012).name().toLowerCase() + '.png'}" width="22" height="25" alt="${p.main(Version.AE2012).value}"
                   title="${p.main(Version.AE2012).value}"
                   class="charimg"/>
            ${p.main(Version.AE2012).value}
          </g:link>
        </td>
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
    <g:link action="rank" controller="rankings" params="['id': Version.AE2012.name()]">View all World Rankings SF4:AE 2012</g:link>
    </div>
  <div class="col-md-6">
    <h4>Killer Instinct Top 20</h4>
    <div class="table-responsive">

      <table class="table table-striped table-hover table-condensed">
        <thead>
        <tr>
          <th>Rank</th>
          <th>Name</th>
          <th>Team</th>
          <th>Score</th>
          <th>Character</th>
          <th>Country</th>
        </tr>
        </thead>

        <g:each in="${kiplayers}" var="p" status="idx">

          <tr>

            <td>${p.rank(Version.KI)}</td>
            <td><g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link></td>
            <td>
              <g:each in="${p.teams}" var="team">
                <g:link controller="rankings" mapping="teamByName" action="team" params="[name: team.name]">${team.shortname}</g:link>
              </g:each>
            </td>
            <td>${p.score(Version.KI)}</td>
            <td>
              <g:link action="rank" controller="rankings" params="[pchar: p.main(Version.KI), id: Version.KI.name()]">
                <g:img dir="images/chars" file="${p.main(Version.KI).name().toLowerCase() + '.png'}" width="22" height="25" alt="${p.main(Version.KI).value}"
                       title="${p.main(Version.KI).value}"
                       class="charimg"/>
                ${p.main(Version.KI).value}
              </g:link>
            </td>
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
    <g:link action="rank" controller="rankings" params="['id': Version.KI.name()]">View all World Rankings Killer Instinct</g:link>
  </div>
  </div>
<div class="row">
  <div class="col-md-6">
    <h4>Skullgirls Top 20</h4>
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
        <g:each in="${sgplayers}" var="p" status="idx">
          <tr>
            <td>${p.rank(Version.SKULLGIRLS)}</td>
            <td><g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link></td>
            <td>
              <g:each in="${p.teams}" var="team">
                <g:link controller="rankings" mapping="teamByName" action="team" params="[name: team.name]">${team.shortname}</g:link>
              </g:each>
            </td>
            <td>${p.score(Version.SKULLGIRLS)}</td>
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
    <g:link action="rank" controller="rankings" params="['id': Version.SKULLGIRLS.name()]">View all World Rankings Skullgirls</g:link>
  </div>

</div>
</body>
</html>