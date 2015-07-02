<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Fighting Games World Rankings - ${game.value}</title>
</head>

<body>
<g:if test="${filtered}">
    <center><h2 class="title-filtered">${game.value} World Rankings - Filtered on ${fcountry} ${fchar}</h2><span class="glyphicon glyphicon-flash"></span>
        <h4 class="subtitle">rank.shoryuken.com</h4></center>
</g:if>
<g:else>
    <center>
        <h2 class="title">${game.value} World Rankings</h2><span class="glyphicon glyphicon-flash"></span>
        <h4 class="subtitle">rank.shoryuken.com</h4>
    </center>
</g:else>


<g:if test="${fchar && !ffiltermain}">
  <div class="alert alert-info">
  When filtering on a character all players that used the character are listed, even if it is not their main. If you are looking for the best player, use the filter main checkbox on the bottom of the page
  </div>
</g:if>
<g:if test="${updateMessage}">
  <div class="alert alert-info alert-dismissable">
    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    <g:message message="${updateMessage}"/>

  </div>
</g:if>

<div class="table-responsive">

  <table class="table table-striped table-hover table-condensed">
    <thead>
    <tr>
      <g:if test="${filtered}">
        <th>Index</th>
      </g:if>
      <th>World Rank</th>
      <th>Name</th>
      <th>Team</th>
      <th>Character</th>
      <th>Score</th>
      <th>Base Score <a href="#" data-toggle="tooltip" data-placement="top" title="The actual score earned per tournament becomes progressively less over time. This value reflects the score without decay.">(?)</a></th>
      <th>Tournaments</th>
      <th>Country</th>
      <g:if test="${snapshot != null}">
        <th>Rank Diff <a href="#" data-toggle="tooltip" data-placement="top" title="Rank difference between now and ${snapshot?.format("yyyy-MM-dd")}">(?)</a></th>
      </g:if>
    <g:if test="${SecurityUtils.subject.isPermitted("player")}">
        <th>Handle</th>
        <th>Twitter</th>
        <th>Skill</th>
    </g:if>
    </tr>
    </thead>

    <g:each in="${players}" var="p" status="idx">

      <tr>
        <g:if test="${filtered}">
          <td>${idx + poffset + 1}</td>
        </g:if>
        <td>${p.rank(game)}</td>
        <td><g:link controller="rankings" mapping="playerByName" action="player" params="[name: p.name]">${p.name}</g:link></td>
        <td>
          <g:each in="${p.teams}" var="team">
            <g:link controller="rankings" mapping="teamByName" action="team" params="[name: team.name]">${team.shortname}</g:link>
          </g:each>
        </td>
        <td>
          <g:each in="${p.main(game)}" var="mainChar">
          <g:link action="rank" controller="rankings" params="[pchar: mainChar, id: game.name()]" data-toggle="tooltip" data-placement="top" title="Filter on ${mainChar.value}">
            <g:img dir="images/chars/${Version.generalize(game).name().toLowerCase()}" file="${mainChar.name().toLowerCase() + '.png'}" width="22" height="25" alt="${mainChar.value}"
                   class="charimg"/>
          </g:link>
          </g:each>
        </td>
        <td>${p.score(game)}</td>
        <td>${p.totalScore(game)}</td>
        <td>${p.numResults()}
          <g:if test="${p.cptQualified}">
            <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                 height="25"/>
          </g:if>
        </td>
        <td>
          <g:if test="${p.countryCode}">
            <g:link controller="rankings" action="rank" params="[country: p.countryCode.name(), id: game.name()]" data-toggle="tooltip" data-placement="top" title="Find players from ${p.countryCode.name}">
              <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}" class="countryflag"/>
              ${p.countryCode.name}
            </g:link>
          </g:if>
        </td>
        <g:if test="${snapshot != null}">
          <td>${p.diff(game)}</td>
        </g:if>
        <g:if test="${SecurityUtils.subject.isPermitted("player")}">
          <td>
            ${p.realname}
          </td>
          <td>
            ${p.twitter}
          </td>
        </g:if>
        <g:if test="${SecurityUtils.subject.isPermitted("player")}">
          <td>
            <g:link controller="player" action="edit" params="[id:p.id]">${p.skill(game)}</g:link>
          </td>
        </g:if>


      </tr>
    </g:each>

  </table></div>

<div id="pagination">
  <g:paginate total="${total}" controller="rankings" action="rank" max="50" params="[country: params.country, pchar: params.pchar, id: game.name()]"/>
</div>

<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Filter</h3>
  </div>

  <div class="panel-body">
    <g:form name="filter" controller="rankings" action="rank" role="form" class="form-inline" method="get">
      <g:select name="country" from="${countries}" class="form-control" value="${fcountry}"/>
      <g:select name="pchar" from="${charnames}" class="form-control" value="${fchar}"/>
      <g:checkBox name="filtermain" class="form-control" value="${ffiltermain}"/>
      <g:hiddenField name="id" value="${game.name()}"/> Only search on main char
      <button type="submit" class="btn btn-primary">Submit</button>
    </g:form>
  </div>
</div>
</body>
</html>