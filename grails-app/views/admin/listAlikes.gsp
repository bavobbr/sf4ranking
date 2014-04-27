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
  <r:require modules="bootstrap"/>
  <title>Admin panel - Match finder</title>
</head>

<body>
<br/>
<ol>
  <g:each in="${players}" var="p">
    <li><b>${p.key.name}</b><i> ${p.key.mainGame} ${p.key.countryCode }</i>  merge into
    <g:each in="${p.value}" var="alt">
      <g:link controller="admin" action="mergePlayers" params="[p1: p.key.id, p2: alt.id]">[${alt.name}] </g:link>
    </g:each>
    </li>
  </g:each>
</ol>
<br/>
</body>
</html>