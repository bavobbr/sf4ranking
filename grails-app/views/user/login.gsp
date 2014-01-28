<%--
  Created by IntelliJ IDEA.
  User: bbr
  Date: 1/21/14
  Time: 2:57 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews">
  <r:require modules="bootstrap"/>
  <title>Admin Login</title>
</head>

<body>

<g:form controller="user" action="login" class="form-signin" role="form">
  <h2 class="form-signin-heading">Please sign in. ${message}</h2>
  <g:textField name="login" type="text" class="form-control" placeholder="login" required="true" autofocus="true"/>
  <g:passwordField name="password" type="password" class="form-control" placeholder="Password" required="true"/>
  <button name="submit" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
</g:form>
</body>
</html>