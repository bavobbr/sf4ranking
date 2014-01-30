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
  <title>Admin panel</title>
</head>

<body>
<h2>Admin import new tournament</h2>
<g:if test="${flash.message}">
  <div class="message" role="status">${flash.message}</div>
</g:if>
<fieldset class="form">
<g:form action="importTournament" controller="admin" name="importform" role="form" class="form-inline">
  <label for="tname">
    <g:message message="Name" />
  </label>
  <g:textField name="tname" class="form-control"/>
  <br/>
  <label for="tresults">
    <g:message message="Results" />
  </label>
  <g:textArea name="tresults" class="form-control"/>
  <button type="submit" class="btn btn-primary">Submit</button>
</g:form>
  </fieldset>
<br/>
</body>

</html>