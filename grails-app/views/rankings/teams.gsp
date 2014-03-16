<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - Teams</title>
</head>

<body>
<h2 class="tournament"><small>${teams.size()} Teams Registered</small></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Website</th>
      <th>Team Size</th>
      <th>Team Score</th>
    </tr>
    </thead>
    <g:each in="${teams}" var="t">

      <tr>
        <td><g:link mapping="teamByName" controller="rankings" action="team" params="[name: t.name]">${t.name}</g:link></td>
        <td>
          <g:if test="${t.website}">
            <a href="${t.website}" target="_blank">${t.website}</a>
          </g:if>
        </td>
        <td>${t.teamSize}</td>
        <td>${t.teamScore}</td>
      </tr>
    </g:each>

  </table>
</div>

<g:render template="/templates/prettify"/>

</body>
</html>