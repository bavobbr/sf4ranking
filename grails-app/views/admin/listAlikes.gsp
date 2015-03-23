<%--
  Created by IntelliJ IDEA.
  User: bbr
  Date: 1/16/14
  Time: 1:51 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews">
  <title>Admin panel - Match finder</title>
</head>

<body>
<br/>
<ol>
  <g:each in="${players}" var="p">
    <li><b>
      <g:link controller="rankings" action="player" params="[id: p.key.id]">${p.key.name}</g:link>
    </b><i>${p.key.mainGame} ${p.key.countryCode}</i>  merge from
    <g:each in="${p.value}" var="alt">
      <g:link controller="admin" action="mergePlayers" params="[p2: p.key.id, p1: alt.id]">[${alt.name}]</g:link>
    </g:each>
    </li>
  </g:each>
</ol>
<br/>
</body>
</html>