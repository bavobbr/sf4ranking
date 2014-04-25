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
  <title>Admin panel - Orphaned players</title>
</head>

<body>
<br/>
<ol>
<g:each in="${players}" var="p">
  <li>${p.name} <g:link controller="player" action="show" params="[id:p.id]">edit</g:link> </li>
</g:each>
</ol>
<br/>
</body>
</html>