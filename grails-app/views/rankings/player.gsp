<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - SSFIV:AE ver. 2012 - ${player.name} results</title>
</head>

<body>
<center>
  <center>
    <h6 class="player-heading">Street Fighter World Rankings</h6><span class="glyphicon glyphicon-flash"></span>
    <h4 class="subtitle">rank.shoryuken.com</h4>
  </center>

  <h1 class="player_name">${player.name}</h1>

  <h3 class="world_rank">${player.rank}</h3>
  <span class="glyphicon glyphicon-flash"></span><span class="world_rank_title">Street Fighter World Rank</span><span
        class="glyphicon glyphicon-flash"></span>
  <dl class="dl-horizontal player_details">
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
    <dt>Character(s)</dt>
    <dd>
      <g:each in="${chars}" var="pchar">
        <g:link action="index" controller="rankings" params="[pchar: pchar.name()]">${pchar.value}</g:link>
      </g:each>
    </dd>
    <dt>Teams(s)</dt>
    <dd>
      <g:each in="${player.teams}" var="team">
        <g:link mapping="teamByName" action="team" controller="rankings" params="[name: team.name]">${team.name}</g:link>
      </g:each>
    </dd>
    <dt>Skill Weight</dt>
    <dd>${player.skill}</dd>

    <dt>Follow</dt>
    <dd>
      <g:if test="${player.twitter}">
        <a href="https://twitter.com/${player.twitter}" class="twitter-follow-button" data-show-count="false">Follow  @${player.twitter}</a>
        <script>!function (d, s, id)
        {
          var js, fjs = d.getElementsByTagName(s)[0], p = /^http:/.test(d.location) ? 'http' : 'https';
          if (!d.getElementById(id))
          {
            js = d.createElement(s);
            js.id = id;
            js.src = p + '://platform.twitter.com/widgets.js';
            fjs.parentNode.insertBefore(js, fjs);
          }
        }(document, 'script', 'twitter-wjs');</script>
      </g:if>
    </dd>

    <dt>Share</dt>
    <dd>
      <a href="https://twitter.com/share" class="twitter-share-button" data-via="bavobbr" data-count="none"
         data-hashtags="srkrank">Tweet</a>
      <script>!function (d, s, id)
      {
        var js, fjs = d.getElementsByTagName(s)[0], p = /^http:/.test(d.location) ? 'http' : 'https';
        if (!d.getElementById(id))
        {
          js = d.createElement(s);
          js.id = id;
          js.src = p + '://platform.twitter.com/widgets.js';
          fjs.parentNode.insertBefore(js, fjs);
        }
      }(document, 'script', 'twitter-wjs');</script>
    </dd>

  </dl>

  <h3 class="tournaments">Tournament placings <small>found [${results.size()}] SSFIV:AE ver. 2012 rankings for</small>${player.name}</h3>
</center>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
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
    <g:each in="${results}" var="result">
      <tr>
        <td><g:link mapping="tournamentByName" controller="rankings" action="tournament" params="[name: result.tname]"
                    title="View tournament">${result.tname}</g:link></td>
        <td>${result.ttype}</td>
        <td>${result.tplace}</td>
        <td>${result.tdate}</td>
        <td>
          <g:if test="${result.tchars}">
            <g:each in="${result.tchars}" var="tchar">
            <g:link action="index" controller="rankings" params="[pchar: tchar.name()]">
              <g:img dir="images/chars" file="${tchar.name().toLowerCase() + '.png'}" width="22" height="25" alt="${tchar.value}" title="${tchar.value}"
                     class="charimg"/>
              ${tchar.value}
            </g:link>
            </g:each>
          </g:if>
        </td>
        <td>${result.tscore}</td>
        <g:if test="${session.user != null}">
          <td><g:link controller="result" action="show" params="['id': result.resultid]">[Update result as admin]</g:link></td>
        </g:if>
      </tr>
    </g:each>
  </table>
</div>

<g:if test="${oldresults}">
  <center>
    <h3 class="tournaments">Tournament placings <small>found [${oldresults.size()}] older rankings for</small>${player.name}</h3>
  </center>

  <div class="table-responsive">
    <table class="tablehead" id="datatable2">
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
      <g:each in="${oldresults}" var="result">
        <tr>
          <td><g:link controller="rankings" action="tournament" params="['id': result.tid]"
                      title="View tournament">${result.tname}</g:link></td>
          <td>${result.ttype}</td>
          <td>${result.tplace}</td>
          <td>${result.tdate}</td>
          <td>
            <g:if test="${result.tchars}">
              <g:each in="${result.tchars}" var="tchar">
                <g:link action="index" controller="rankings" params="[pchar: tchar.name()]">
                  <g:img dir="images/chars" file="${tchar.name().toLowerCase() + '.png'}" width="22" height="25" alt="${tchar.value}" title="${tchar.value}"
                         class="charimg"/>
                  ${tchar.value}
                </g:link>
              </g:each>
            </g:if>
          </td>
          <td>${result.tscore}</td>
          <g:if test="${session.user != null}">
            <td><g:link controller="result" action="show" params="['id': result.resultid]">[Update result as admin]</g:link></td>
          </g:if>
        </tr>
      </g:each>
    </table>
  </div>
</g:if>

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

<script type="text/javascript" charset="utf-8">
  $(document).ready(function ()
                    {
                      $("#datatable").tablecloth({
                                                   theme: "default",
                                                   striped: true,
                                                   sortable: true,
                                                   condensed: false
                                                 });
                      $("#datatable2").tablecloth({
                                                    theme: "default",
                                                    striped: true,
                                                    sortable: true,
                                                    condensed: false
                                                  });
                    });
</script>
</body>
</html>