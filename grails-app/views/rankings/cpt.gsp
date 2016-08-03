<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Capcom Pro Tour Rankings 2016 - ${game.value}</title>
</head>

<body>
<center>
    <h2 class="title">${game.name()} Capcom Pro Tour Rankings 2016</h2>
</center>

<div class="row">
    <div class="col-md-6">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Rules</h3>
            </div>

            <div class="panel-body">
                This ${game.value} ranking follows the <a
                    href="http://capcomprotour.com/rules/">Capcom Pro Tour ruleset</a>
                <ul>
                    <li>12 qualify via Global Premier Events</li>
                    <li>4 qualify via Regional Finals, 1 player from each event</li>
                    <li>8 qualify via regional point leaderboards, top 2 from each region</li>
                    <li>8 qualify via the global point leaderboards.</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="col-md-6">

        <g:if test="${updateMessage}">

            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Updates</h3>
                </div>
                <div class="panel-body">
                    <g:message message="${updateMessage}"/>

                </div>
            </div>
        </g:if>
    </div>
</div>

<h3>Global leader board</h3>

Green means directly qualified, blue means will qualify by points in the open global spots. When a player directly qualifed or double-qualifies extra blue spots are opened. This means players on the edge can still get in by extension of blue zone.


<div class="table-responsive">

    <table class="tablehead" id="datatable">

        <thead>
        <tr class="stathead">
            <th>CPT Rank</th>
            <th>Country</th>
            <th>Name</th>
            <th>Team</th>
            <th>Character</th>
            <th>CPT Score <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Score as granted by the Capcom Pro Tour 2016 ranking system">(?)</a></th>
            <th>Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Directly qualified for the Capcom Cup Finals">(?)</a></th>
            <th>Score diff<a href="#" data-toggle="tooltip" data-placement="top"
                             title="Diff against score before update at ${lastUpdate?.format("yyyy-MM-dd")}">(?)</a>
            </th>
            <th>Rank diff<a href="#" data-toggle="tooltip" data-placement="top"
                            title="Diff against rank before update at ${lastUpdate?.format("yyyy-MM-dd")}">(?)</a></th>
            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
            <th>Fight Money<a href="#" data-toggle="tooltip" data-placement="top"
                              title="Estimated Prize money assigned by CPT budget">(?)</a></th>
        </tr>
        </thead>

        <g:each in="${players}" var="p" status="idx">

            <tr class="${p.scoreQualified ? 'qual' : 'unqual'} ${p.cptQualified ? 'direct' : 'unqual'}">
                <td class="${p.cptRank <= openSpots? 'warning' : ''}">
                    ${p.cptRank}
                </td>
                <td>
                    <g:if test="${p.countryCode}">
                        <g:link controller="rankings" action="rank"
                                params="[country: p.countryCode.name(), id: game.name()]" data-toggle="tooltip"
                                data-placement="top" title="Find players from ${p.countryCode.name}">
                            <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}"
                                   class="countryflag"/>
                            ${p.countryCode.name()}
                        </g:link>
                    </g:if>
                </td>
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
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                             height="24"/>
                    </g:if>
                    <g:elseif test="${p.scoreQualified}">
                            <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                                title="Currently player is in the qualifying spots that are assigned to the highest scoring but not directly qualified players">(?)</a>
                            </small>
                    </g:elseif>
                    <g:elseif test="${p.cptRegionalQualified}">
                        <small>regional <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Player is currently qualified for regional finals and may win a direct spot">(?)</a>
                        </small>
                    </g:elseif>
                </td>
                <td>+${p.cptScore - (p.prevCptScore ?: 0)}</td>
                <td class="${p.rankDiffClass}">
                    <g:if test="${p.rankDiff == null}">
                        <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
                    </g:if>
                    <g:elseif test="${p.rankDiff > 0}">
                        <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
                    </g:elseif>
                    <g:elseif test="${p.rankDiff < 0}">
                        <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
                    </g:elseif>
                    <g:if test="${p.rankDiff != null && p.rankDiff != 0}">
                        ${Math.abs(p.rankDiff)}
                    </g:if>
                </td>
                <td>${p.cptTournaments}</td>
                <td>$${p.cptPrize}</td>

            </tr>
        </g:each>

    </table>
The global board has ${directSpots} direct qualified players, ${extraSpots} spots opened by double qualification amounting to ${openSpots} spots of qualification
</div>


<h3>North America Regional Board</h3>
The first two non-qualified players will directly qualify for Capcom Cup. Global board ranking has precedence, so players qualifying by global points are excluded for direct qualifaction in the region.
Green means directly qualified, yellow means qualified via global. Blue players will qualify via their regional score.
Note that 1 player in regional finals will qualify directly, so that may shift down the blue zone.
<div class="table-responsive">

    <table class="tablehead" id="datatable2">

        <thead>
        <tr class="stathead">
            <th>CPT Rank</th>
            <th>World Rank</th>
            <th>Name</th>
            <th>Character</th>
            <th>Regional Score <a href="#" data-toggle="tooltip" data-placement="top"
                                  title="Score as granted by the Capcom Pro Tour 2016 ranking system for region">(?)</a>
            </th>
            <th>Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Directly qualified for the Capcom Cup Finals">(?)</a></th>
            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
            <th>Country</th>
        </tr>
        </thead>

        <g:each in="${playersNA}" var="p" status="idx">

            <tr class="${p.scoreQualifiedNA ? 'qual' : 'unqual'} ${p.scoreQualified ? 'global' : ''} ${p.cptQualified ? 'direct' : ''}">
                <td>
                    ${p.cptRankNA}
                </td>
                <td>${p.rank(game)}</td>
                <td>
                    <g:link controller="rankings" mapping="playerByName" action="player"
                            params="[name: p.name]">${p.name}</g:link>
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
                <td>${p.cptScoreNA}</td>
                <td>
                    <g:if test="${p.cptQualified}">
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                             height="24"/>
                    </g:if>
                    <g:elseif test="${p.scoreQualified}">
                        <small>global <a href="#" data-toggle="tooltip" data-placement="top"
                                         title="Player is currently qualified by global points">(?)</a>
                        </small>
                    </g:elseif>
                    <g:elseif test="${p.cptRegionalQualified}">
                        <small>regional finals <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Player is currently qualified for regional finals">(?)</a>
                        </small>
                    </g:elseif>
                    <g:elseif test="${p.scoreQualifiedNA}">
                        <small>by regional points <a href="#" data-toggle="tooltip" data-placement="top"
                                            title="Currently player is in the qualifying spots that are assigned to the highest scoring but not directly qualified players">(?)</a>
                        </small>
                    </g:elseif>
                </td>
                <td>${p.cptTournaments}</td>
                <td>
                    <g:if test="${p.countryCode}">
                        <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}"
                               class="countryflag"/>
                        ${p.countryCode.name}
                    </g:if>
                </td>
            </tr>
        </g:each>

    </table></div>


<h3>Latin America Regional Board</h3>
The first two non-qualified players will directly qualify for Capcom Cup. Global board ranking has precedence, so players qualifying by global points are excluded for direct qualifaction in the region.
Green means directly qualified, yellow means qualified via global. Blue players will qualify via their regional score.
Note that 1 player in regional finals will qualify directly, so that may shift down the blue zone.
<div class="table-responsive">

    <table class="tablehead" id="datatable3">

        <thead>
        <tr class="stathead">
            <th>CPT Rank</th>
            <th>World Rank</th>
            <th>Name</th>
            <th>Character</th>
            <th>Regional Score <a href="#" data-toggle="tooltip" data-placement="top"
                                  title="Score as granted by the Capcom Pro Tour 2016 ranking system for region">(?)</a>
            </th>
            <th>Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Directly qualified for the Capcom Cup Finals">(?)</a></th>
            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
            <th>Country</th>
        </tr>
        </thead>

        <g:each in="${playersLA}" var="p" status="idx">

            <tr class="${p.scoreQualifiedLA ? 'qual' : 'unqual'} ${p.scoreQualified ? 'global' : ''} ${p.cptQualified ? 'direct' : ''}">
                <td>
                    ${p.cptRankLA}
                </td>
                <td>${p.rank(game)}</td>
                <td>
                    <g:link controller="rankings" mapping="playerByName" action="player"
                            params="[name: p.name]">${p.name}</g:link>
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
                <td>${p.cptScoreLA}</td>
                <td>
                    <g:if test="${p.cptQualified}">
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                             height="24"/>
                    </g:if>
                    <g:elseif test="${p.scoreQualified}">
                        <small>global <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Player is currently qualified by global points">(?)</a>
                        </small>
                    </g:elseif>
                    <g:elseif test="${p.cptRegionalQualified}">
                        <small>regional finals<a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Player is currently qualified for regional finals">(?)</a>
                        </small>
                    </g:elseif>
                    <g:elseif test="${p.scoreQualifiedLA}">
                        <small>by regional points <a href="#" data-toggle="tooltip" data-placement="top"
                                            title="Currently player is in the qualifying spots that are assigned to the highest scoring but not directly qualified players">(?)</a>
                        </small>
                    </g:elseif>
                </td>
                <td>${p.cptTournaments}</td>
                <td>
                    <g:if test="${p.countryCode}">
                        <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}"
                               class="countryflag"/>
                        ${p.countryCode.name}
                    </g:if>
                </td>
            </tr>
        </g:each>

    </table></div>

<h3>Asia/Oceania Regional Board</h3>
The first two non-qualified players will directly qualify for Capcom Cup. Global board ranking has precedence, so players qualifying by global points are excluded for direct qualifaction in the region.
Green means directly qualified, yellow means qualified via global. Blue players will qualify via their regional score.
Note that 1 player in regional finals will qualify directly, so that may shift down the blue zone.
<div class="table-responsive">

    <table class="tablehead" id="datatable4">

        <thead>
        <tr class="stathead">
            <th>CPT Rank</th>
            <th>World Rank</th>
            <th>Name</th>
            <th>Character</th>
            <th>Regional Score <a href="#" data-toggle="tooltip" data-placement="top"
                                  title="Score as granted by the Capcom Pro Tour 2016 ranking system for region">(?)</a>
            </th>
            <th>Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Directly qualified for the Capcom Cup Finals">(?)</a></th>
            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
            <th>Country</th>
        </tr>
        </thead>

        <g:each in="${playersAO}" var="p" status="idx">

            <tr class="${p.scoreQualifiedAO ? 'qual' : 'unqual'} ${p.scoreQualified ? 'global' : ''} ${p.cptQualified ? 'direct' : ''}">
                <td>
                    ${p.cptRankAO}
                </td>
                <td>${p.rank(game)}</td>
                <td>
                    <g:link controller="rankings" mapping="playerByName" action="player"
                            params="[name: p.name]">${p.name}</g:link>
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
                <td>${p.cptScoreAO}</td>
                <td>
                    <g:if test="${p.cptQualified}">
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                             height="24"/>
                    </g:if>
                    <g:elseif test="${p.scoreQualified}">
                        <small>global <a href="#" data-toggle="tooltip" data-placement="top"
                                         title="Player is currently qualified by global points">(?)</a>
                        </small>
                    </g:elseif>
                    <g:elseif test="${p.cptRegionalQualified}">
                        <small>regional finals<a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Player is currently qualified for regional finals">(?)</a>
                        </small>
                    </g:elseif>
                    <g:elseif test="${p.scoreQualifiedAO}">
                        <small>by regional points <a href="#" data-toggle="tooltip" data-placement="top"
                                            title="Currently player is in the qualifying spots that are assigned to the highest scoring but not directly qualified players">(?)</a>
                        </small>
                    </g:elseif>
                </td>
                <td>${p.cptTournaments}</td>
                <td>
                    <g:if test="${p.countryCode}">
                        <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}"
                               class="countryflag"/>
                        ${p.countryCode.name}
                    </g:if>
                </td>
            </tr>
        </g:each>

    </table></div>

<h3>Europe Regional Board</h3>
The first two non-qualified players will directly qualify for Capcom Cup. Global board ranking has precedence, so players qualifying by global points are excluded for direct qualifaction in the region.
Green means directly qualified, yellow means qualified via global. Blue players will qualify via their regional score.
Note that 1 player in regional finals will qualify directly, so that may shift down the blue zone.
<div class="table-responsive">

    <table class="tablehead" id="datatable5">

        <thead>
        <tr class="stathead">
            <th>CPT Rank</th>
            <th>World Rank</th>
            <th>Name</th>
            <th>Character</th>
            <th>Regional Score <a href="#" data-toggle="tooltip" data-placement="top"
                                  title="Score as granted by the Capcom Pro Tour 2016 ranking system for region">(?)</a>
            </th>
            <th>Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Directly qualified for the Capcom Cup Finals">(?)</a></th>
            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
            <th>Country</th>
        </tr>
        </thead>

        <g:each in="${playersEU}" var="p" status="idx">

            <tr class="${p.scoreQualifiedEU ? 'qual' : 'unqual'} ${p.scoreQualified ? 'global' : ''} ${p.cptQualified ? 'direct' : ''}">
                <td>
                    ${p.cptRankEU}
                </td>
                <td>${p.rank(game)}</td>
                <td>
                    <g:link controller="rankings" mapping="playerByName" action="player"
                            params="[name: p.name]">${p.name}</g:link>
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
                <td>${p.cptScoreEU}</td>
                <td>
                    <g:if test="${p.cptQualified}">
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                             height="24"/>
                    </g:if>
                    <g:elseif test="${p.scoreQualified}">
                        <small>global <a href="#" data-toggle="tooltip" data-placement="top"
                                         title="Player is currently qualified by global points">(?)</a>
                        </small>
                    </g:elseif>
                    <g:elseif test="${p.cptRegionalQualified}">
                        <small>regional finals<a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Player is currently qualified for regional finals">(?)</a>
                        </small>
                    </g:elseif>
                    <g:elseif test="${p.scoreQualifiedEU}">
                        <small>by regional points <a href="#" data-toggle="tooltip" data-placement="top"
                                            title="Currently player is in the qualifying spots that are assigned to the highest scoring but not directly qualified players">(?)</a>
                        </small>
                    </g:elseif>
                </td>
                <td>${p.cptTournaments}</td>
                <td>
                    <g:if test="${p.countryCode}">
                        <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}"
                               class="countryflag"/>
                        ${p.countryCode.name}
                    </g:if>
                </td>
            </tr>
        </g:each>

    </table></div>

<script type="text/javascript" charset="utf-8">
    $(document).ready(function () {
        $('table[id^="datatable"]').each(function (index) {
            try {
                $(this).tablecloth({
                    theme: "default",
                    striped: false,
                    sortable: true,
                    condensed: true
                })
            }
            catch (err) {
            }
        })
    });
</script>
</body>
</html>