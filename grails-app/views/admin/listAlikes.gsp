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
    <li>${p.key} <=> ${p.value}</li>
  </g:each>
</ol>
<br/>
</body>
</html>