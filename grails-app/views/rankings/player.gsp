<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter 4 World Ranking - ${player.name} results</title>
</head>

<body>
<h2>Player details<small>for ${player.name}</small></h2>
<dl class="dl-horizontal">

  <dt>Skill</dt>
  <dd>${player.skill}</dd>
  <dt>Country</dt>
  <dd>
    ${player.countryCode?.name}
    <g:if test="${player.countryCode != null}">
      <g:link controller="rankings" action="index" params="[country: player.countryCode.name()]">
        <g:img dir="images/countries" file="${player.countryCode.name().toLowerCase() + '.png'}"
               alt="Find players from ${player.countryCode.name}"/>
      </g:link>
    </g:if>

  </dd>
  <dt>Score</dt>
  <dd>${player.score}</dd>
  <dt>Character used</dt>
  <dd>${chars}</dd>
  <dt>World Rank</dt>
  <dd>${player.rank}</dd>

</dl>

<h2>Tournament placings<small>found ${results.size()} SF4 rankings</small></h2>

<div class="table-responsive">
  <table class="table table-striped table-hover">
    <thead>
    <tr>
      <td>Tournament</td>
      <td>Type</td>
      <td>Ranking</td>
      <td>Date</td>
      <td>Character</td>
      <td>Points</td>
    </tr>
    </thead>
    <g:each in="${results}" var="result">
      <tr>
        <td><g:link controller="rankings" action="tournament" params="['id': result.tid]" title="View tournament">${result.tname}</g:link></td>
        <td>${result.ttype}</td>
        <td>${result.tplace}</td>
        <td>${result.tdate}</td>
        <td>
          <g:if test="${result.tchar}">
            <g:link action="index" controller="rankings" params="[pchar: result.tchar]">
              <g:img dir="images/chars" file="${result.tchar + '.png'}" width="22" height="25" alt="${result.tchar}" title="${result.tchar}"/>
              ${result.tcharname}
            </g:link>
          </g:if>

        </td>
        <td>${result.tscore}</td>
      </tr>
    </g:each>
  </table>
</div>

<g:if test="${session.user != null}">
  <g:link controller="admin" action="selectPlayerVideos" params="['id': player.id]">[Update videos as admin]</g:link>
</g:if>

<g:if test="${player.videos}">
  <h2>Player videos <small>found ${player.videos.size()} videos</small></h2>
  <g:each in="${player.videos}" var="video">
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