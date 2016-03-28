<%@ page import="be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Fighting Games World Ranking - Hardware and controllers</title>
</head>

<body>
<h2>Game Controllers</h2>

<div class="table-responsive">
    <table class="tablehead" id="datatable">
        <thead>
        <tr class="stathead">
            <th>Name</th>
            <th>Vendor</th>
            <th>Players</th>
            <th>Shop</th>
        </tr>
        </thead>
        <g:each in="${controllers}" var="controller">
            <tr>
                <td>
                    <g:link action="show" params="[id: controller.id]">
                        ${controller.name}
                    </g:link>
                </td>
                <td>
                    ${controller.website}
                </td>
                <td>
                    ${controller.players.size()}
                </td>
                <td>
                    <g:link action="show" params="[id: controller.id]">
                        Buy ${controller.name}
                    </g:link>
                </td>
            </tr>
        </g:each>
        <g:render template="/templates/prettify"/>
</table>
    </div>

</body>
</html>