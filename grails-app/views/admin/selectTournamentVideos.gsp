<%--
  Created by IntelliJ IDEA.
  User: bbr
  Date: 1/16/14
  Time: 1:51 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="artificial">
  <title>Admin panel</title>
</head>

<body>
<h2>Admin set tournament videos for ${tournament.name}</h2>
<g:if test="${flash.message}">
  <div class="message" role="status">${flash.message}</div>
</g:if>
<fieldset class="form">
  <g:form action="updateTournamentVideos" controller="admin" name="form" role="form" class="form-inline">
    <label for="videos">
      Videos
    </label>
    <g:textField name="videos" class="form-control" value="${tournament.videos.join(" ")}"/>
    <g:hiddenField name="id" value="${tournament.id}"/>
    <button type="submit" class="btn btn-primary">Submit</button>
  </g:form>
</fieldset>
</body>
</html>