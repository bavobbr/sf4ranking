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
  <title>Admin panel</title>
</head>

<body>
<h2>Admin merge players</h2>
This will delete player 1 after copying the results to player 2. Make sure player 2 has the information he needs as only the rankings are copied, not country etc.
<g:if test="${flash.message}">
  <div class="message" role="status">${flash.message}</div>
</g:if>
<fieldset class="form">
  <g:form action="mergePlayers" controller="admin" name="mergeForm" class="form-inline">
    <label for="p1">
      <g:message message="Merge player"/>
    </label>
    <g:select name="p1" from="${players}" optionKey="id" optionValue="name" class="form-control"/>
    <label for="p2">
      <g:message message="into" />
    </label>
    <g:select name="p2" from="${players}" optionKey="id" optionValue="name" class="form-control"/>
    <button type="submit" class="btn btn-primary">Submit</button>
  </g:form>
</fieldset>
<br/>
</body>
</html>