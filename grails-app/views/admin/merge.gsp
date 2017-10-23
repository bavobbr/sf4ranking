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
<h2>Admin merge players</h2>
This will delete player 1 after copying the results to player 2. Make sure player 2 has the information he needs as only the rankings are copied, not country etc.
<g:if test="${flash.message}">
  <div class="message" role="status">${flash.message}</div>
</g:if>
<fieldset class="form">
  <g:form action="mergePlayers" controller="admin" name="mergeForm" class="form-inline">
    <label for="p1">
      <g:message message="Merge player"/>
    </label>
    <div class="form-group">
      <input id="p1" class="form-control" placeholder="Find a Player" name="p1">
    </div>
    <label for="p2">
      <g:message message="into" />
    </label>
    <div class="form-group">
      <input id="p2" class="form-control" placeholder="Find a Player" name="p2">
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </g:form>
</fieldset>
<br/>
<script>
  $(function () {
    $("#p1").autocomplete({
      source: "${createLink(action: 'autocompletePlayer', controller: 'rankings')}",
      minLength: 3,
      select: function (event, ui) {
        if (ui.item) $("#p1").val(ui.item.value);

      }
    });
  });
</script>
<script>
  $(function () {
    $("#p2").autocomplete({
      source: "${createLink(action: 'autocompletePlayer', controller: 'rankings')}",
      minLength: 3,
      select: function (event, ui) {
        if (ui.item) $("#p2").val(ui.item.value);
      }
    });
  });
</script>
</body>
</html>