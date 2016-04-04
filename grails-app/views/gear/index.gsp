<%@ page import="be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Fighting Games World Ranking - Hardware and controllers</title>
</head>

<body>
<h2>Game Controllers</h2>
<div class="row" align="center">
        <div class="col-md-4">
            <img src="https://s3.amazonaws.com/srkranking/controllers/madcatz_family_small.jpeg" class="img-responsive"
                 alt="Mad catz controller prices" data-toggle="tooltip" data-placement="top"
                 title="Mad catz arcade stick and controller prices"/>
        </div>

        <div class="col-md-4">
            <img src="https://s3.amazonaws.com/srkranking/controllers/hori_rap5_small.jpeg" class="img-responsive"
                 alt="Hori controller prices" data-toggle="tooltip" data-placement="top"
                 title="Hori arcade stick controller prices"/>
        </div>
    <div class="col-md-4">
        <img src="https://s3.amazonaws.com/srkranking/controllers/mc_te2plus_small.jpeg" class="img-responsive"
             alt="Mad catz controller prices" data-toggle="tooltip" data-placement="top"
             title="Mad catz arcade stick and controller prices"/>
    </div>
</div>
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