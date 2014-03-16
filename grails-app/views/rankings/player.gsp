<%@ page import="be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - ${player.name} results</title>
</head>

<body>
<div style="text-align: center;">
  <h6 class="player-heading">Street Fighter World Rankings</h6><span class="glyphicon glyphicon-flash"></span>
  <h4 class="subtitle">rank.shoryuken.com</h4>

  <h1 class="player_name">${player.name}</h1>

  <h3 class="world_rank">${player.rank(Version.AE2012)}</h3>
  <span class="glyphicon glyphicon-flash"></span>
  <span class="world_rank_title">Street Fighter World Rank</span>
  <span class="glyphicon glyphicon-flash"></span>
</div>
  <center>
    <dl class="dl-horizontal player_details">
      <dt>Country</dt>
      <dd>

        <g:if test="${player.countryCode != null}">
          <g:link controller="rankings" action="rank" params="[country: player.countryCode.name()]">
            ${player.countryCode?.name}
            <g:img dir="images/countries" file="${player.countryCode.name().toLowerCase() + '.png'}"
                   alt="Find players from ${player.countryCode.name}"/>
          </g:link>
        </g:if>
      </dd>
      <dt>Teams(s)</dt>
      <dd>
        <g:each in="${player.teams}" var="team">
          <g:link mapping="teamByName" action="team" controller="rankings" params="[name: team.name]">${team.name}</g:link>
        </g:each>
      &NonBreakingSpace;
      </dd>
      <dt>Follow</dt>
      <dd>
        <g:render template="/templates/follow" model="[twitter: player.twitter]"/>
      </dd>
      <dt>Share</dt>
      <dd>
        <g:render template="/templates/share"/>
      </dd>
      <dt>SF4 Char(s)</dt>
      <dd>
        <g:each in="${chars}" var="pchar">
          <g:link action="rank" controller="rankings" params="[pchar: pchar.name()]">${pchar.value}</g:link>
        </g:each>
      </dd>

    </dl>



  <div class="table-responsive">
    <table class="tablehead" id="infotable">
      <thead>
      <tr class="stathead">
        <th>Game</th>
        <th>Rank</th>
        <th>Score</th>
        <th>Weight</th>
        <th>Tournaments played</th>
      </tr>
      </thead>
      <g:each in="${player.rankings}" var="ranking" status="index">
        <g:if test="${results[ranking.game] != null}">
          <tr>
            <td>${ranking.game}</td>
            <td>${ranking.rank}</td>
            <td>${ranking.score}</td>
            <td>${ranking.skill}</td>
            <td>${results[ranking.game]?.size()}</td>
          </tr>
        </g:if>
      </g:each>
    </table>
  </div>

  <g:each in="${results}" var="ranking" status="index">
    <h3 class="tournaments">Tournament placings <small>found [${ranking.value.size()}] ${ranking.key} tournaments for </small>${player.name}
    </h3>
    <div class="table-responsive">
      <table class="tablehead" id="datatable_${index}">
        <thead>
        <tr class="stathead">
          <th>Tournament</th>
          <th>Type</th>
          <th>Ranking</th>
          <th>Date</th>
          <th>Character</th>
          <th>Points</th>
          <g:if test="${session.user != null}">
            <th>Edit</th>
          </g:if>
        </tr>
        </thead>
        <g:each in="${ranking.value}" var="result">
          <tr>
            <td><g:link mapping="tournamentByName" controller="rankings" action="tournament" params="[name: result.tname]"
                        title="View tournament">${result.tname}</g:link></td>
            <td>${result.ttype}</td>
            <td>${result.tplace}</td>
            <td>${result.tdate}</td>
            <td>
              <g:if test="${result.tchars}">
                <g:each in="${result.tchars}" var="tchar">
                  <g:link action="rank" controller="rankings" params="[pchar: tchar.name(), id: ranking.key.name()]">
                    <g:img dir="images/chars" file="${tchar.name().toLowerCase() + '.png'}" width="22" height="25" alt="${tchar.value}"
                           title="${tchar.value}"
                           class="charimg"/>
                    ${tchar.value}
                  </g:link>
                </g:each>
              </g:if>
            </td>
            <td>${result.tscore}</td>
            <g:if test="${session.user != null}">
              <td><g:link controller="result" action="show" params="['id': ranking.value.resultid]">[Update result as admin]</g:link></td>
            </g:if>
          </tr>
        </g:each>
      </table>
    </div>
  </g:each>

  <g:if test="${session.user != null}">
    <g:link controller="admin" action="selectPlayerVideos" params="['id': player.id]">[Update videos as admin]</g:link>
    <g:link controller="player" action="show" params="['id': player.id]">[Update player as admin]</g:link>
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
  </center>
<g:render template="/templates/prettify"/>
</body>
</html>