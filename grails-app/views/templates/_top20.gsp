<%@ page import="be.bbr.sf4ranking.Version" %>
<h4>${game.value} Top 10</h4>
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
        <td>${p.rank(game)}</td>
        <td><g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link></td>
        <td>
          <g:each in="${p.teams}" var="team">
            <g:link controller="rankings" mapping="teamByName" action="team" params="[name: team.name]">${team.shortname}</g:link>
          </g:each>
        </td>
        <td>${p.score(game)}</td>
        <td>
          <g:link action="rank" controller="rankings" params="[pchar: p.main(game), id: game.name()]"
                  data-toggle="tooltip" data-placement="top"
                  title="Filter on ${p.main(game).value}">
            <g:img dir="images/chars" file="${p.main(game).name().toLowerCase() + '.png'}" width="22" height="25"
                   alt="${p.main(game).value}"
                   class="charimg"/>
            ${p.main(game).value}
          </g:link>
        </td>
        <td>
          <g:if test="${p.countryCode}">
            <g:link controller="rankings" action="rank" params="[country: p.countryCode.name(), id: game.name()]"
                    title="Find players from ${p.countryCode.name}" data-toggle="tooltip" data-placement="top">
              <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}" class="countryflag"
                     data-toggle="tooltip" data-placement="left"/>
            </g:link>
          </g:if>
        </td>
      </tr>
    </g:each>
  </table></div>
<g:link action="rank" controller="rankings" params="['id': game.name()]">View complete ${game.value} World Rankings</g:link>