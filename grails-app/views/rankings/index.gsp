<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>SF4 World Ranking - SSF4:AE 2012</title>
</head>

<body>
<h2>SF4 World Ranking</h2>


<div class="alert alert-info alert-dismissable">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  Currently the database is focusing on SSF4:AE 2012 edition, listing all high-profile tournaments of 2012 and 2013. As a result this ranking reflects the most all-round tournament players of Street Fighter 4: Arcade Edition 2012.
  As soon as more tournaments are added in different games, new rankings will be made per game.<br/>
  The database and website is still in beta-phase and subject to change on user feedback. Feedback is very much appreciated via the social links provided at every page!
</div>

  <div class="table-responsive">

    <table class="table table-striped table-hover table-condensed">
      <thead>
      <tr>
        <g:if test="${filtered}">
          <td>Index</td>
        </g:if>
        <td>World Rank</td>
        <td>Name</td>
        <td>Score</td>
        <td>Country</td>
      </tr>
      </thead>

      <g:each in="${players}" var="p" status="idx">

        <tr>
          <g:if test="${filtered}">
            <td>${idx + 1}</td>
          </g:if>
          <td>${p.rank}</td>
          <td><g:link controller="rankings" action="player" params="['id': p.id]">${p.name}</g:link></td>
          <td>${p.score}</td>
          <td>
            <g:if test="${p.countryCode}">
              <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}"/>
            </g:if>
          </td>
        </tr>
      </g:each>

    </table></div>
<div id="pagination">
<g:paginate total="${total}" controller="rankings" action="index" max="50" params="[country:params.country]"/>
</div>

<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Filter</h3>
  </div>

  <div class="panel-body">
    <g:form name="filter" controller="rankings" action="index" role="form" class="form-inline" method="get">
      <g:select name="country" from="${countries}" class="form-control"/>
      <button type="submit" class="btn btn-primary">Submit</button>
    </g:form>
  </div>
</div>
</body>
</html>