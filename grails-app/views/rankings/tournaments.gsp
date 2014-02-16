<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - SSFIV:AE ver. 2012 - Tournaments</title>
</head>

<body>
<h2 class="tournament"><small>${tournaments.size()} Tournaments Registered</small></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Type</th>
      <th>Date</th>
      <th>Location</th>
      <th>Game</th>
      <th>Weight</th>
      <th>Video</th>
    </tr>
    </thead>
    <g:each in="${tournaments}" var="t">

      <tr>
        <td><g:link mapping="tournamentByName" controller="rankings" action="tournament" params="[name: t.name]">${t.name}</g:link></td>
        <td>${t.tournamentType?.value}</td>
        <td>${t.date?.format("yyyy-MM-dd")}</td>
        <td>
          <g:if test="${t.countryCode}">
            <g:link controller="rankings" action="tournaments" params="[country: t.countryCode.name()]">
              <g:img dir="images/countries" file="${t.countryCode.name().toLowerCase() + '.png'}" class="countryflag" />
              ${t.countryCode.name}
            </g:link>
          </g:if>
        </td>
        <td>${t.game?.value}</td>
        <td>${t.weight}</td>
        <td>
          <g:if test="${t.videos}">
            <a href="http://www.youtube.com/watch?v=${t.videos.first()}" target="_blank">Open</a>
          </g:if>
        </td>
      </tr>
    </g:each>

  </table>
</div>

<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Filter</h3>
  </div>

  <div class="panel-body">
    <g:form name="filter" controller="rankings" action="tournaments" role="form" class="form-inline" method="get">
      <g:select name="country" from="${countries}" class="form-control"/>
      <g:select name="version" from="${versions}" class="form-control"/>
      <g:select name="type" from="${types}" class="form-control"/>
      <button type="submit" class="btn btn-primary">Submit</button>
    </g:form>
  </div>
</div>


<script type="text/javascript" charset="utf-8">
  $(document).ready(function ()
                    {
                      $("#datatable").tablecloth({
                                              theme: "default",
                                              striped: true,
                                              sortable: true,
                                              condensed: true
                                            });
                    });
</script>


</body>
</html>