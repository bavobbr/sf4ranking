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
    <label for="tname">Name</label>
    <g:textField name="tname" class="form-control" placeholder="tournament name and year"/>
  </div>

  <div class="form-group">
    <label for="tdate">Date</label>
    <g:datePicker name="tdate" class="form-control" precision="day" years="${2000..2020}" value="${new Date()}"/>
  </div>

  <div class="form-group">
    <label for="tgame">Game</label>
    <g:select name="tgame" from="${be.bbr.sf4ranking.Version.values()}" class="form-control"/>
  </div>

  <div class="form-group">
    <label for="tformat">Format</label>
    <g:select name="tformat" from="${be.bbr.sf4ranking.TournamentFormat.values()}" class="form-control"/>
  </div>

  <div class="form-group">
    <label for="tcountry">Country</label>
    <g:select name="tcountry" from="${be.bbr.sf4ranking.CountryCode.values()}" class="form-control"/>
  </div>

  <div class="form-group">
    <label for="tvideos">Videos (seperated with a space)</label>
    <g:textField name="tvideos" class="form-control" placeholder="qJGSz-aQDO0 Go1vdkf-xvY"/>
  </div>

  <div class="form-group">
    <label for="tresults">Results (hover for tips, make sure the character name matches a known character type)</label>
    <g:textArea name="tresults" class="form-control" rows="20" placeholder="first player / CODY"
                title="${hint}"/>
    <button type="submit" class="btn btn-primary">Submit</button>
  </div>
</g:form>
<br/>
</body>

</html>