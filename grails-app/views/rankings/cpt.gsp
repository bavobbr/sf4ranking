<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Capcom Pro Tour Rankings - ${game.value}</title>
</head>

<body>
<center>
    <h2 class="title">${game.value} Capcom Pro Tour Rankings</h2><span class="glyphicon glyphicon-flash"></span>
    <h4 class="subtitle">rank.shoryuken.com</h4>
</center>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Capcom Pro Tour Ranking</h3>
        </div>

        <div class="panel-body">
            This ranking is derived from the <a
                href="http://capcomprotour.com/rules/">Capcom Pro Tour ruleset</a>. Check out the offical site at <a
                href="http://capcomprotour.com/standings/">http://capcomprotour.com/standings/</a>. This ranking is auto-updated as soon as the tournament results are added at Shoryuken World Rankings.
        <br/>The currently qualifying players by score are indicated in the grey area!
        </div>
    </div>

<div class="table-responsive">

    <table class="tablehead" id="datatable">

        <thead>
        <tr class="stathead">
            <th>CPT Rank</th>
            <th>World Rank</th>
            <th>Name</th>
            <th>Team</th>
            <th>Character</th>
            <th>SRK Score</th>
            <th>CPT Score <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Score as granted by the Capcom Pro Tour 2015 ranking system">(?)</a></th>
            <th>Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Directly qualified for the Capcom Cup Finals">(?)</a></th>
            <th>CPT Tournaments</th>
            <th>Country</th>
        </tr>
        </thead>

        <g:each in="${players}" var="p" status="idx">

            <tr class="${p.scoreQualified() ? 'qual' : 'unqual'}">
                <td>
                    <g:if test="${idx + 1 <= 32}">
                        <b>${idx + 1}</b>
                    </g:if>
                    <g:else>
                        ${idx + 1}
                    </g:else>
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
                <td>${p.score(game)}</td>
                <td>${p.cptScore}</td>
                <td>
                    <g:if test="${p.cptQualified}">
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="30"
                             height="30"/>
                    </g:if>

                <td>${p.numResults()}</td>
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
                condensed: false})
        })
    });
</script>
</body>
</html>