<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Fighting Games World Rankings - Search</title>
</head>

<body>
<g:if test="${flash.message}">
  <div class="alert alert-warning">${flash.message}</div>
</g:if>

<g:if test="${!(players.isEmpty())}">
<h2>${players.size()} Players matching ${query}</h2>
<div class="table-responsive">
  <table class="tablehead" id="datatable1">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Country</th>
      <th>Main Game</th>
    </tr>
    </thead>
    <g:each in="${players}" var="player">

      <tr>
        <td><g:link mapping="playerByName" controller="rankings" action="playerByName"
                    params="[name: player.name]">${player.name}</g:link></td>
        <td>${player.countryCode}</td>
        <td>${player.mainGame}</td>
      </tr>
    </g:each>

  </table>
</div>
</g:if>



<h2>${alikes.size()} Players which sound alike ${query}</h2>

<div class="table-responsive">
  <table class="tablehead" id="datatable2">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Country</th>
      <th>Main Game</th>
    </tr>
    </thead>
    <g:each in="${alikes}" var="player">

      <tr>
        <td><g:link mapping="playerByName" controller="rankings" action="playerByName"
                    params="[name: player.name]">${player.name}</g:link></td>
        <td>${player.countryCode}</td>
        <td>${player.mainGame}</td>
      </tr>
    </g:each>

  </table>
</div>

<g:render template="/templates/prettify"/>

</body>
</html>