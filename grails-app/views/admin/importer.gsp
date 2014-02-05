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
<g:form action="importTournament" controller="admin" name="importform" role="form">
  <div class="form-group">
    <label for="tname">
      <g:message message="Name"/>
    </label>
    <g:textField name="tname" class="form-control"/>
  </div>
  <div class="form-group">
    <label for="tdate">
      <g:message message="Date"/>
    </label>
    <g:datePicker name="tdate" class="form-control" precision="day" years="${2000..2020}" value="${new Date()}"/>
  </div>
  <div class="form-group">
    <label for="tgame">
      <g:message message="Game"/>
    </label>
    <g:select name="tgame" from="${be.bbr.sf4ranking.TournamentType.values()}" class="form-control"/>
  </div>
  <div class="form-group">
    <label for="tcountry">
      <g:message message="Country"/>
    </label>
  </div>
  <div class="form-group">
  <g:select name="tcountry" from="${be.bbr.sf4ranking.CountryCode.values()}" class="form-control"/><div class="form-group">
  <label for="tresults">
    <g:message message="Results"/>
  </label>
  <g:textArea name="tresults" class="form-control"/>
  <button type="submit" class="btn btn-primary">Submit</button>
</div>
</g:form>
<br/>
</body>

</html>