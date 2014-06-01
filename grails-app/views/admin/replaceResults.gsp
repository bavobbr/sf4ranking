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
<h2>Admin replace results for ${tournament.name}</h2>
DOES NOT WORK YET, DEMO ONLY
<g:if test="${flash.message}">
  <div class="alert alert-warning">${flash.message}</div>
</g:if>
<fieldset class="form">
  <g:form action="updateTournamentResults" controller="admin" name="form" role="form" class="form-inline">
    <label for="videos">
      Results
    </label>
    <g:textArea rows="20" cols="70" name="results" class="form-control" value="${results}"/>
    <g:hiddenField name="id" value="${tournament.id}"/>
    <button type="submit" class="btn btn-primary">Submit</button>
  </g:form>
</fieldset>
</body>
</html>