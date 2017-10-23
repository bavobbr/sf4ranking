<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial">
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

        <div class="form-group">
            <input id="p1" class="form-control" placeholder="Find a Player" name="p1" value="${p1?.name}">
        </div>
    %{--
        <g:select name="p1" from="${players}" optionKey="id" optionValue="name" class="form-control" value="${p1?.id}"/>
    --}%
        <label for="p2">
            <g:message message="to"/>
        </label>

        <div class="form-group">
            <input id="p2" class="form-control" placeholder="Find a Player" name="p2" value="${p2?.name}">
        </div>    <button type="submit" class="btn btn-primary">Submit</button>
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