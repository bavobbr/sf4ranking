<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - SSFIV:AE ver. 2012 - ${tournament.name} Tournament Details</title>
</head>

<body>
<h2 class="tournament"><small>${tournament.name}</small> Tournament details</h2>

<div class="table-responsive">
  <table class="table table-striped table-hover tdetails">
    <thead>
    <tr>
      <th>Type</th>
      <th>Country</th>
      <th>Date</th>
      <th>Format</th>
      <th>Weight</th>
      <th>Share</th>
    </tr>
    </thead>
    <tr>
      <td>${tournament.tournamentType?.value}</td>
      <td>${tournament.countryCode?.name}</td>
      <td>${tournament.date?.format("MM-yyyy")}</td>
      <td>${tournament.tournamentFormat?.value}</td>
      <td>${tournament.weight}</td>
      <td>
        <a href="https://twitter.com/share" class="twitter-share-button" data-via="bavobbr" data-count="none" data-hashtags="srkrank">Tweet</a>
        <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
      </td>
    </tr>
  </table>
</div>

<h2 class="tournament"><large>found ${details.size()} rankings</large></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Place</th>
      <th>Player</th>
      <th>Character</th>
      <th>Country</th>
      <th>Score</th>
      <g:if test="${session.user != null}">
        <th>Edit</th>
      </g:if>
    </tr>
    </thead>
    <g:each in="${details}" var="result">
      <tr>
        <td>${result.rplace}</td>
        <td><g:link mapping="playerByName" controller="rankings" action="player" params="[name: result.rplayer]">${result.rplayer}</g:link></td>
        <td>
          <g:if test="${result.rchar}">
            <g:link action="index" controller="rankings" params="[pchar: result.rchar]">
              <g:img dir="images/chars" file="${result.rchar + '.png'}" width="22" height="25" alt="${result.rchar}"
                     title="${result.rchar}" class="charimg"/>
              ${result.rcharname}
            </g:link>
          </g:if>
        </td>
        <td>
          <g:if test="${result.rcountry != null}">
            <g:link controller="rankings" action="tournaments" params="[country: result.rcountry]">
              <g:img dir="images/countries" file="${result.rcountry + '.png'}" class="countryflag"/>
              ${result.rcountryname}
            </g:link>
          </g:if>
        </td>
        <td>${result.rscore}</td>
        <g:if test="${session.user != null}">
          <td><g:link controller="result" action="show" params="['id': result.resultid]">[Update result as admin]</g:link></td>
        </g:if>
      </tr>
    </g:each>
  </table>
</div>

<g:if test="${session.user != null}">
  <g:link controller="admin" action="selectTournamentVideos" params="['id': tournament.id]">[Update videos as admin]</g:link>
  <g:link controller="tournament" action="show" params="['id': tournament.id]">[Update tournament as admin]</g:link>
  <g:link controller="admin" action="playerDiffForTournament" params="['id': tournament.id]">[Diff page]</g:link>
  <g:link controller="admin" action="playerRanksBefore" params="['id': tournament.id]">[Scores before tournament]</g:link>
  <g:link controller="admin" action="playerRanksAfter" params="['id': tournament.id]">[Scores after tournament]</g:link>
</g:if>


<g:if test="${tournament.videos}">
  <h2>Tournament videos <small>found ${tournament.videos.size()} videos</small></h2>
  <g:each in="${tournament.videos}" var="video">
    <section class="row">
      <div class="span6">
        <div class="flex-video widescreen"><iframe width="280" height="157" src="//www.youtube.com/embed/${video}" frameborder="0"
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
                    });
</script>
</body>
</html>