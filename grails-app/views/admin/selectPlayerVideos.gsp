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
<h2>Admin set player videos for ${player.name}</h2>
<g:if test="${flash.message}">
  <div class="message" role="status">${flash.message}</div>
</g:if>
<fieldset class="form">
  <g:form action="updatePlayerVideos" controller="admin" name="form" role="form" class="form-inline">
    <label for="videos">
      Videos
    </label>
    <g:textField name="videos" class="form-control" value="${player.videos.join(" ")}"/>
    <g:hiddenField name="id" value="${player.id}"/>
    <button type="submit" class="btn btn-primary">Submit</button>
  </g:form>
</fieldset>
</body>
</html>