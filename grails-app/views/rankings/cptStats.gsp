<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Capcom Pro Tour 2016 Stats</title>
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
      <th>Weight</th>
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
        <td>${t.weight}</td>
        <td>
            ${t.cptTournament?.value}
        </td>
          <td>${t.getCptTournament().getScore(1)}</td>
          <td>${t.getCptTournament().getPrize(1)}</td>
      </tr>
    </g:each>
  </table>
</div>
    A total of ${maxTotal} points can be scored and ${directPlaces} direct places are still open
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
            <th>Qualified</th>
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
    A total of ${pastMaxTotal} points could be scored and ${pastDirectPlaces} direct places were granted

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