<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Capcom Pro Tour 2017 Stats</title>
</head>

<body>


<g:if test="${coming}">
<h3 class="tournament"><small>${coming.size()} Tournaments Upcoming</small></h3>
<div class="table-responsive">
  <table class="tablehead" id="datatable1">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Date</th>
      <th>Location</th>
      <th>Region</th>
      <th>Pro Tour</th>
      <th>Max Points</th>
      <th>Max Prize</th>
    </tr>
    </thead>
    <g:each in="${coming}" var="t">
      <tr>
        <td><g:link mapping="tournamentByName" controller="rankings" action="tournament" params="[name: t.name]">${t.name}</g:link></td>
        <td>${t.date?.format("yyyy-MM-dd")}</td>
        <td>
          <g:if test="${t.countryCode}">
            <g:link controller="rankings" action="tournaments" params="[country: t.countryCode.name()]">
              <g:img dir="images/countries" file="${t.countryCode.name().toLowerCase() + '.png'}" class="countryflag" />
              ${t.countryCode.name}
            </g:link>
          </g:if>
        </td>
        <td>${t.region?.value}</td>
        <td>
            ${t.cptTournament?.value}
        </td>
          <td>${t.getCptTournament().getScore(1)}</td>
          <td>${t.getCptTournament().getPrize(1, t.countryCode)}</td>
      </tr>
    </g:each>
  </table>
</div>
    A total of <strong>${maxTotal} max global points</strong> can be scored at <strong>${pointCount} tournaments</strong> providing points, of which <strong>${rankingCount} offline ranking </strong>tournaments, <strong>${onlineTournament} online ranking </strong>tournaments<strong>, <strong>${evoTournament} EVO ranking </strong>tournaments and ${premierTournament} premiers </strong>are still open to score!
<ul>
    <li>Points available in <strong>North America: ${maxTotalNA}</strong> (of which ${maxRegionTotalNA} regional ranking)</li>
    <li>Points available in <strong>Latin America: ${maxTotalLA}</strong> (of which ${maxRegionTotalLA} regional ranking)</li>
    <li>Points available in <strong>Asia/Oceania: ${maxTotalAO}</strong> (of which ${maxRegionTotalAO} regional ranking)</li>
    <li>Points available in <strong>Europe: ${maxTotalEU}</strong> (of which ${maxRegionTotalEU} regional ranking)</li>
</ul>
</g:if>

<h3 class="tournament"><small>${played.size()} Tournaments played</small></h3>
<div class="table-responsive">
    <table class="tablehead" id="datatable2">
        <thead>
        <tr class="stathead">
            <th>Name</th>
            <th>Date</th>
            <th>Location</th>
            <th>Weight</th>
            <th>Pro Tour</th>
            <th>Win</th>
            <th>Max Points</th>
            <th>Max Prize</th>
        </tr>
        </thead>
        <g:each in="${played}" var="t">
            <tr>
                <td><g:link mapping="tournamentByName" controller="rankings" action="tournament" params="[name: t.name]">${t.name}</g:link></td>
                <td>${t.date?.format("yyyy-MM-dd")}</td>
                <td>
                    <g:if test="${t.countryCode}">
                        <g:link controller="rankings" action="tournaments" params="[country: t.countryCode.name()]">
                            <g:img dir="images/countries" file="${t.countryCode.name().toLowerCase() + '.png'}" class="countryflag" />
                            ${t.countryCode.name}
                        </g:link>
                    </g:if>
                </td>
                <td>${t.weight}</td>
                <td>
                    ${t.cptTournament?.value}
                </td>
                <td>${t.qualified()}</td>
                <td>${t.getCptTournament().getScore(1)}</td>
                <td>${t.getCptTournament().getPrize(1, t.countryCode)}</td>
            </tr>
        </g:each>

    </table>
    A total of <strong>${pastMaxTotal} points </strong>could be scored.

</div>



<h3 class="tournament"><small>Qualifying listed players by country</small></h3>
<div class="table-responsive">
    <table class="tablehead" id="datatable4">
        <thead>
        <tr class="stathead">
            <th>Country</th>
            <th>Amount</th>
            <th>Players</th>
        </tr>
        </thead>
        <g:each in="${byCountry32}" var="t">
            <tr>
                <td>${t.key}</td>
                <td>${t.value.size()}</td>
                <td>${t.value.collect { it.name }.join(", ")}</td>
            </tr>
        </g:each>
    </table>
</div>

<h3 class="tournament"><small>Qualifying listed players by region</small></h3>
<div class="table-responsive">
    <table class="tablehead" id="datatable40">
        <thead>
        <tr class="stathead">
            <th>Region</th>
            <th>Amount</th>
            <th>Players</th>
        </tr>
        </thead>
        <g:each in="${byRegion32}" var="t">
            <tr>
                <td>${t.key}</td>
                <td>${t.value.size()}</td>
                <td>${t.value.collect { it.name }.join(", ")}</td>
            </tr>
        </g:each>
    </table>
</div>

See the <g:link action="cptCharacterStats">CPT character stats </g:link> page for more info on qualifying players. Currently ${unknownTotal} spots are not known yet.


<h3 class="tournament"><small>Total listed players by country</small></h3>
<div class="table-responsive">
    <table class="tablehead" id="datatable3">
        <thead>
        <tr class="stathead">
            <th>Country</th>
            <th>Amount</th>
        </tr>
        </thead>
        <g:each in="${byCountry}" var="t">
            <tr>
                <td>${t.key}</td>
                <td>${t.value.size()}</td>
            </tr>
        </g:each>
    </table>
</div>
<g:render template="/templates/prettify"/>

</body>
</html>