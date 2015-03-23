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
  <title>Admin panel - DELETE ALL</title>
</head>

<body>
<fieldset class="form">
  <g:form action="deleteAll" controller="admin" name="deleteForm" class="form-inline">
    <label for="confirm">
      <g:message message="Delete all data?"/>
    </label>
    <g:textField name="confirm" class="form-control"/>
    <button type="submit" class="btn btn-primary">Submit</button>
  </g:form>
</fieldset>
<br/>
</body>
</html>