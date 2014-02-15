<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter World Ranking - SSFIV:AE ver. 2012 - Teams</title>
</head>

<body>
<h2 class="tournament"><small>${teams.size()} Teams Registered</small></h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Website</th>
      <th>Twitter</th>
    </tr>
    </thead>
    <g:each in="${teams}" var="t">

      <tr>
        <td><g:link controller="rankings" action="team" params="['id': t.id]">${t.name}</g:link></td>
        <td>${t.website}</td>
        <td>${t.twitter}</td>
      </tr>
    </g:each>

  </table>
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