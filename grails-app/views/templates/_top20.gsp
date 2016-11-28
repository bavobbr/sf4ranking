<%@ page import="be.bbr.sf4ranking.Version" %>
<h4>${game.value} Top 10</h4>
<div>
  <table class="table table-striped table-hover table-condensed table-responsive">
    <thead>
    <tr>
      <th>Rank</th>
      <th>Name</th>
      <th>Sponsor</th>
      <th>Team</th>
      <th>Country</th>
    </tr>
    </thead>
    <g:each in="${players}" var="p" status="idx">
      <tr class="top10table">
        <td>${p.rank(game)}</td>
        <td><g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">
          <div class="top10table">${p.name}</div>
        </g:link></td>
        <td>
          <g:each in="${p.teams}" var="team">
            <g:link controller="rankings" mapping="teamByName" action="team" params="[name: team.name]">${team.shortname}</g:link>
          </g:each>
        </td>
        <td>
          <g:each in="${p.main(game)}" var="mainChar">
          <g:link action="rank" controller="rankings" params="[pchar: mainChar.name(), id: game.name()]"
                  data-toggle="tooltip" data-placement="top"
                  title="Filter on ${mainChar.value}">
            <g:img dir="images/chars/${Version.generalize(game).name().toLowerCase()}" file="${mainChar.name().toLowerCase() + '.png'}" width="22" height="25"
                   alt="${mainChar.value}"
                   class="charimg"/>
          </g:link>
          </g:each>
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
View <g:link action="rank" controller="rankings" params="['id': game.name()]" class="toplink">current ${game.value} </g:link> /
<g:link action="rank" controller="rankings" params="['id': game.name(), alltime: true]" class="toplink">all-time ${game.value} </g:link> World Rankings