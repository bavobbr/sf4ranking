<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews">
  <title>Compare players</title>
</head>

<body>
<h2>Compare players</h2>
Select two players to compare to eachother.
<g:if test="${flash.message}">
  <div class="message" role="status">${flash.message}</div>
</g:if>
<fieldset class="form">
  <g:form action="compareResults" controller="stats" name="compareForm" class="form-inline" method="GET">
    <label for="p1">
      <g:message message="Compare player"/>
    </label>
    <g:select name="p1" from="${players}" optionKey="id" optionValue="name" class="form-control" value="${p1?.id}"/>
    <label for="p2">
      <g:message message="to" />
    </label>
    <g:select name="p2" from="${players}" optionKey="id" optionValue="name" class="form-control" value="${p2?.id}"/>
    <button type="submit" class="btn btn-primary">Submit</button>
  </g:form>
</fieldset>
<br/>
</body>
</html>