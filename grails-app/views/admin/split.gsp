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
<h2>Admin split player</h2>
<g:if test="${flash.message}">
  <div class="message" role="status">${flash.message}</div>
</g:if>
Split the selected results into a newly named player
<fieldset class="form">
  <g:form action="splitPlayers" controller="admin" name="splitForm" class="form-inline">
    <g:hiddenField name="from" value="${player.id}"/>
    <label for="to">
      <g:message message="Split to player"/>
    </label>
    <g:textField name="to" class="form-control"/>
    <p/>
    <label for="results">
      <g:message message="Results"/>
    </label>
    <g:select name="results" from="${results}" optionValue="display" multiple="multiple" optionKey="id" size="10" class="many-to-many"/>
    <button type="submit" class="btn btn-primary">Submit</button>
  </g:form>
</fieldset>
<br/>
</body>
</html>