<%@ page import="be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - SSFIV:AE ver. 2012 - ${team.name} Team Details</title>
</head>

<body>
<h2 class="tournament"><small>${team.name}</small> Team details</h2>

<div class="table-responsive">
  <table class="table table-striped table-hover tdetails">
    <thead>
    <tr>
      <th>Name</th>
      <th>Website</th>
      <th>Twitter</th>
      <th>Players</th>
    </tr>
    </thead>
    <tr>
      <td>${team.name}</td>
      <td>
        <g:if test="${team.website}">
        <a href="${team.website}" target="_blank">${team.website}</a>
        </g:if>
      </td>
      <td>
        <g:if test="${team.twitter}">
          <a href="https://twitter.com/${team.twitter}" class="twitter-follow-button" data-show-count="false">Follow  @${team.twitter}</a>
          <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
        </g:if>
      </td>
      <td>${players.size()}</td>
      <td>
        <a href="https://twitter.com/share" class="twitter-share-button" data-via="bavobbr" data-count="none" data-hashtags="srkrank">Tweet</a>
        <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
      </td>
    </tr>
  </table>
</div>

<h2 class="tournament"><large>found ${players.size()} players</large></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Place</th>
      <th>Player</th>
      <th>Country</th>
      <th>Score</th>
      <g:if test="${session.user != null}">
        <th>Edit</th>
      </g:if>
    </tr>
    </thead>
    <g:each in="${players}" var="player">
      <tr>
        <td>${player.rank(Version.AE2012)}</td>
        <td><g:link mapping="playerByName" controller="rankings" action="player" params="[name: player.name]">${player.name}</g:link></td>
        <td>
          <g:if test="${player.countryCode != null}">
            <g:link controller="rankings" action="index" params="[country: player.countryCode.name()]">
              <g:img dir="images/countries" file="${player.countryCode.name().toLowerCase() + '.png'}" class="countryflag"/>
              ${player.countryCode.name}
            </g:link>
          </g:if>
        </td>
        <td>${player.overallScore()}</td>
        <g:if test="${session.user != null}">
          <td><g:link controller="result" action="show" params="['id': player.id]">[Update result as admin]</g:link></td>
        </g:if>
      </tr>
    </g:each>
  </table>
</div>

<g:if test="${session.user != null}">
  <g:link controller="team" action="show" params="['id': team.id]">[Update team as admin]</g:link>
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