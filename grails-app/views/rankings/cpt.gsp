<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Capcom Pro Tour Rankings 2016 - ${game.value}</title>
</head>

<body>
<center>
    <h2 class="title">${game.value} Capcom Pro Tour Rankings 2016</h2>
</center>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Rules</h3>
        </div>
        <div class="panel-body">
            This ranking follows the <a
                href="http://capcomprotour.com/rules/">Capcom Pro Tour ruleset</a>. Check out the offical site at <a
                href="http://capcomprotour.com/standings/">http://capcomprotour.com/standings/</a>. The board is auto-updated as soon as the tournament results are added at Shoryuken World Rankings.
        <br/>Currently qualifying players by score are indicated in the blue area, those in yellow area are currently in the top32 region. Those that directly qualified are invited to the season finals in December, as well as the highest 15 scoring players.
        </div>
    </div>
<g:if test="${updateMessage}">
    <div class="alert alert-info alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:message message="${updateMessage}"/>

    </div>
</g:if>

<div class="table-responsive">

    <table class="tablehead" id="datatable">

        <thead>
        <tr class="stathead">
            <th>CPT Rank</th>
            <th>World Rank</th>
            <th>Name</th>
            <th>Team</th>
            <th>Character</th>
            <th>CPT Score <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Score as granted by the Capcom Pro Tour 2016 ranking system">(?)</a></th>
            <th>Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Directly qualified for the Capcom Cup Finals">(?)</a></th>
            <th>Score diff<a href="#" data-toggle="tooltip" data-placement="top"
                             title="Diff against score before update at ${lastUpdate?.format("yyyy-MM-dd")}">(?)</a></th>
            <th>Rank diff<a href="#" data-toggle="tooltip" data-placement="top"
                            title="Diff against rank before update at ${lastUpdate?.format("yyyy-MM-dd")}">(?)</a></th>
            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
            <th>Fight Money<a href="#" data-toggle="tooltip" data-placement="top"
                            title="Estimated Prize money assigned by CPT budget">(?)</a></th>
            <th>Country</th>
        </tr>
        </thead>

        <g:each in="${players}" var="p" status="idx">

            <tr class="${p.scoreQualified() ? 'qual' : 'unqual'}">
                <td class="${p.cptRank <= 32? 'warning':''}">
                        ${p.cptRank}
                </td>
                <td>${p.rank(game)}</td>
                <td>
                    <g:link controller="rankings" mapping="playerByName" action="player"
                            params="[name: p.name]">${p.name}</g:link>
                </td>
                <td>
                    <g:each in="${p.teams}" var="team">
                        <g:link controller="rankings" mapping="teamByName" action="team"
                                params="[name: team.name]">${team.shortname}</g:link>
                    </g:each>
                </td>
                <td>
                    <g:each in="${p.main(game)}" var="mainChar">
                        <g:link action="rank" controller="rankings" params="[pchar: mainChar, id: game.name()]"
                                data-toggle="tooltip" data-placement="top" title="Filter on ${mainChar.value}">
                            <g:img dir="images/chars/${Version.generalize(game).name().toLowerCase()}"
                                   file="${mainChar.name().toLowerCase() + '.png'}" width="22" height="25"
                                   alt="${mainChar.value}"
                                   class="charimg"/>
                        </g:link>
                    </g:each>
                </td>
                <td>${p.cptScore}</td>
                <td>
                    <g:if test="${p.cptQualified}">
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </g:if>
                <g:else>
                    <g:if test="${p.scoreQualified()}">
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    </g:if>
                    <g:else>
                        <g:if test="${p.cptRank <= 32}">
                            <small>candidate <a href="#" data-toggle="tooltip" data-placement="top"
                                               title="Player can still qualify when players who currently qualify by points get a direct qualifying spot at a Premier event">(?)</a></small>
                        </g:if>
                    </g:else>
                </g:else></td>
                <td>+${p.cptScore-(p.prevCptScore?: 0)}</td>
                <td class="${p.rankDiffClass()}">
                    <g:if test="${p.rankDiff() == null}">
                        <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
                    </g:if>
                    <g:elseif test="${p.rankDiff() > 0}">
                        <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
                    </g:elseif>
                    <g:elseif test="${p.rankDiff() < 0}">
                        <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
                    </g:elseif>
                    <g:if test="${p.rankDiff() != null && p.rankDiff() != 0}">
                        ${Math.abs(p.rankDiff())}
                    </g:if>
                </td>
                <td>${p.cptTournaments}</td>
                <td>$${p.cptPrize}</td>
                <td>
                    <g:if test="${p.countryCode}">
                        <g:link controller="rankings" action="rank"
                                params="[country: p.countryCode.name(), id: game.name()]" data-toggle="tooltip"
                                data-placement="top" title="Find players from ${p.countryCode.name}">
                            <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}"
                                   class="countryflag"/>
                            ${p.countryCode.name}
                        </g:link>
                    </g:if>
                </td>

            </tr>
        </g:each>

    </table></div>


<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title">Filter</h3>
    </div>

    <div class="panel-body">
        <g:form name="filter" controller="rankings" action="cpt" role="form" class="form-inline" method="get">
            <g:select name="pcountry" from="${countries}" class="form-control" />
            <g:select name="pchar" from="${chars}" class="form-control"/>
            <button type="submit" class="btn btn-primary">Submit</button>
        </g:form>
    </div>
</div>
<script type="text/javascript" charset="utf-8">
    $(document).ready(function ()
    {
        $('table[id^="datatable"]').each(function (index)
        {
            $(this).tablecloth({
                theme: "default",
                striped: false,
                sortable: true,
                condensed: true})
        })
    });
</script>
</body>
</html>