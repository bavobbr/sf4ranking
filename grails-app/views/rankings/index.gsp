<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - SSFIV:AE ver. 2012</title>
</head>

<body>
<g:if test="${filtered}">
  <center><h2 class="title-filtered">Street Fighter World Rankings - Filtered on ${fcountry} ${fchar}</h2><span class="glyphicon glyphicon-flash"></span>
  	<h4 class="subtitle">rank.shoryuken.com</h4></center>
</g:if>
<g:else>
  <center>
  	<h2 class="title">Street Fighter World Rankings</h2><span class="glyphicon glyphicon-flash"></span>
  	<h4 class="subtitle">rank.shoryuken.com</h4>
  </center>
</g:else>


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
      <th>Score</th>
      <th>Country</th>
    </tr>
    </thead>

    <g:each in="${players}" var="p" status="idx">

      <tr>
        <g:if test="${filtered}">
          <td>${idx + poffset + 1}</td>
        </g:if>
        <td>${p.rank}</td>
        <td><g:link controller="rankings" action="player" params="['id': p.id]">${p.name}</g:link></td>
        <td>${p.score}</td>
        <td>
          <g:if test="${p.countryCode}">
            <g:link controller="rankings" action="index" params="[country: p.countryCode.name()]">
              <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}" alt="Find players from ${p.countryCode.name}" class="countryflag"/>
              ${p.countryCode.name}
            </g:link>
          </g:if>
        </td>
      </tr>
    </g:each>

  </table></div>

<div id="pagination">
  <g:paginate total="${total}" controller="rankings" action="index" max="50" params="[country: params.country, pchar: params.pchar]"/>
</div>

<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Filter</h3>
  </div>

  <div class="panel-body">
    <g:form name="filter" controller="rankings" action="index" role="form" class="form-inline" method="get">
      <g:select name="country" from="${countries}" class="form-control" value="${fcountry}"/>
      <g:select name="pchar" from="${charnames}" class="form-control" value="${fchar}"/>
      <button type="submit" class="btn btn-primary">Submit</button>
    </g:form>
  </div>
</div>
</body>
</html>