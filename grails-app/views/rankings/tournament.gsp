<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>SF4 World Ranking - ${tournament.name} Tournament Details</title>
</head>

<body>
<h2 class="tournament"><small> ${tournament.name}</small> Tournament details</h2>

<div class="table-responsive">
  <table class="table table-striped table-hover tdetails">
    <thead>
    <tr>
      <td>Type</td>
      <td>Country</td>
      <td>Date</td>
      <td>Format</td>
      <td>Weight</td>
    </tr>
    </thead>
    <tr>
      <td>${tournament.tournamentType?.value}</td>
      <td>${tournament.countryCode?.name}</td>
      <td>${tournament.date?.format("MM-yyyy")}</td>
      <td>${tournament.tournamentFormat?.value}</td>
      <td>${tournament.weight}</td>
    </tr>
  </table>
</div>

<h2 class="tournament"><large>found ${details.size()} rankings</large></h2>

<div class="table-responsive">
  <table class="table table-striped table-hover">
    <thead>
    <tr>
      <td>Place</td>
      <td>Player</td>
      <td>Character</td>
      <td>Country</td>
      <td>Score</td>
    </tr>
    </thead>
    <g:each in="${details}" var="result">
      <tr>
        <td>${result.rplace}</td>
        <td><g:link controller="rankings" action="player" params="['id': result.rplayerid]">${result.rplayer}</g:link></td>
        <td>
          <g:if test="${result.rchar}">
            <g:link action="index" controller="rankings" params="[pchar: result.rchar]">
              <g:img dir="images/chars" file="${result.rchar + '.png'}" width="22" height="25" alt="${result.rchar}"
                     title="${result.rchar}"/>
            </g:link>
          </g:if>
        </td>
        <td>
          <g:if test="${result.rcountry != null}">
            <g:link controller="rankings" action="tournaments" params="[country: result.rcountry]">
              <g:img dir="images/countries" file="${result.rcountry + '.png'}"/>
            </g:link>
          </g:if>
        </td>
        <td>${result.rscore}</td>
      </tr>
    </g:each>
  </table>
</div>

<g:if test="${session.user != null}">
  <g:link controller="admin" action="selectTournamentVideos" params="['id': tournament.id]">[Update videos as admin]</g:link>
</g:if>


<g:if test="${tournament.videos}">
  <h2>Tournament videos <small>found ${tournament.videos.size()} videos</small></h2>
  <g:each in="${tournament.videos}" var="video">
    <section class="row">
      <div class="span6">
        <div class="flex-video widescreen"><iframe width="560" height="315" src="//www.youtube.com/embed/${video}" frameborder="0"
                                                   allowfullscreen></iframe></div>
      </div>

    </section>
  </g:each>
</g:if>
</body>
</html>