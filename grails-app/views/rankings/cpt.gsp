<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Capcom Pro Tour Rankings - ${game.value}</title>
</head>

<body>
    <center>
        <h2 class="title">${game.value} Capcom Pro Tour Rankings</h2><span class="glyphicon glyphicon-flash"></span>
        <h4 class="subtitle">rank.shoryuken.com</h4>
    </center>

<div class="table-responsive">
  <table class="table table-condensed">
    <thead>
    <tr>

      <th>World Rank</th>
      <th>Name</th>
      <th>Team</th>
      <th>Character</th>
      <th>SRK Score</th>
      <th>CPT Score <a href="#" data-toggle="tooltip" data-placement="top" title="Score as granted by the Capcom Pro Tour 2015 ranking system">(?)</a></th>
      <th>Qualified <a href="#" data-toggle="tooltip" data-placement="top" title="Directly qualified for the Capcom Cup Finals">(?)</a></th>
      <th>CPT Tournaments</th>
      <th>Country</th>
    </tr>
    </thead>

    <g:each in="${players}" var="p" status="idx">

      <tr class="${p.scoreQualified()? 'qual':'unqual'}">
        <td>${p.rank(game)}</td>
        <td><g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link></td>
        <td>
          <g:each in="${p.teams}" var="team">
            <g:link controller="rankings" mapping="teamByName" action="team" params="[name: team.name]">${team.shortname}</g:link>
          </g:each>
        </td>
        <td>
          <g:each in="${p.main(game)}" var="mainChar">
          <g:link action="rank" controller="rankings" params="[pchar: mainChar, id: game.name()]" data-toggle="tooltip" data-placement="top" title="Filter on ${mainChar.value}">
            <g:img dir="images/chars/${Version.generalize(game).name().toLowerCase()}" file="${mainChar.name().toLowerCase() + '.png'}" width="22" height="25" alt="${mainChar.value}"
                   class="charimg"/>
          </g:link>
          </g:each>
        </td>
        <td>${p.score(game)}</td>
        <td>${p.cptScore}</td>
        <td>${p.cptQualified? "yes" : "no"}</td>
        <td>${p.numResults()}</td>
        <td>
          <g:if test="${p.countryCode}">
            <g:link controller="rankings" action="rank" params="[country: p.countryCode.name(), id: game.name()]" data-toggle="tooltip" data-placement="top" title="Find players from ${p.countryCode.name}">
              <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}" class="countryflag"/>
              ${p.countryCode.name}
            </g:link>
          </g:if>
        </td>


      </tr>
    </g:each>

  </table></div>

</body>
</html>