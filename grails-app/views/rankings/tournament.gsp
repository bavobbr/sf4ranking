<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>SF4 World Ranking - ${tournament.name} Tournament Details</title>
</head>

<body>
<h2>Tournament details<small> for ${tournament.name}</small></h2>

<div class="table-responsive">
  <table class="table table-striped table-hover">
    <thead>
    <tr>
      <td>Type</td>
      <td>Country</td>
      <td>Date</td>
    </tr>
    </thead>
    <tr>
      <td>${tournament.tournamentType?.value}</td>
      <td>${tournament.countryCode?.name}</td>
      <td>${tournament.date?.format("MM-yyyy")}</td>
    </tr>
  </table>
</div>

<h2>Tournament placings <small>found ${details.size()} rankings</small></h2>

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
        <td>${result.rchar}</td>
        <td>
          <g:if test="${result.rcountry != null}">
            <g:img dir="images/countries" file="${result.rcountry + '.png'}"/>
          </g:if>
        </td>
        <td>${result.rscore}</td>
      </tr>
    </g:each>
  </table>
</div>

<g:if test="${tournament.videos}">
  <h2>Tournament videos <small>found ${tournament.videos.size()} videos</small></h2>
  <g:each in="${tournament.videos}" var="video">
    <section class="row">
      <div class="span6">
        <div class="flex-video widescreen"><iframe width="560" height="315" src="//www.youtube.com/embed/${video}" frameborder="0" allowfullscreen></iframe></div>
      </div>

    </section>
  </g:each>
</g:if>
</body>
</html>