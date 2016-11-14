<%@ page import="be.bbr.sf4ranking.Region; org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
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

Green means directly qualified, blue means will qualify by points in the open global spots. When a player directly qualifed or double-qualifies (via global points, direct and/or regional finals) extra blue spots are opened. This means players on the edge can still get in by extension of blue zone.
Any global point spots above top 8 are granted due to shifting caused by direct qualifiers and double qualifiers.

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
            <th>Qualifications <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Qualifications for the Capcom Cup Finals">(?)</a></th>
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

        <g:each in="${players}" var="p">

            <tr class="${p.cptGlobal().qualifiedByScore ? 'qual' : 'unqual'} ${p.cptGlobal()?.qualified ? 'direct' : 'unqual'}">
                <td class="${p.cptGlobal().rank <= 24? 'warning' : ''}">
                    ${p.cptGlobal().rank}
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
                <td>${p.findCptRanking(Region.GLOBAL)?.score}
                </td></td>
                <td>
                    <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                            data-content="${raw(be.bbr.overview.RankingsController.cptSummary(p))}"
                            data-html="true" data-trigger="focus">
                        info
                    </button>
                    <g:if test="${p.cptGlobal()?.qualified}">
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                             height="24"/>
                    </g:if>
                    <small>${raw(be.bbr.overview.RankingsController.cptLabel(p, Region.GLOBAL))}</small>
                </td>
                <td>${p.diffCpt(be.bbr.sf4ranking.Region.GLOBAL)}</td>
                <td class="${p.findCptRanking(Region.GLOBAL)?.rankDiffClass()}">
                    <g:if test="${p.diffCptRank(Region.GLOBAL) == null}">
                        <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
                    </g:if>
                    <g:elseif test="${p.diffCptRank(Region.GLOBAL) > 0}">
                        <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
                    </g:elseif>
                    <g:elseif test="${p.diffCptRank(Region.GLOBAL) < 0}">
                        <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
                    </g:elseif>
                    <g:if test="${p.diffCptRank(Region.GLOBAL) != null && p.diffCptRank(Region.GLOBAL) != 0}">
                        ${Math.abs(p.diffCptRank(Region.GLOBAL))}
                    </g:if>
                </td>
                <td>${p.cptTournaments}</td>
                <td>$${p.cptPrize}</td>
            </tr>
        </g:each>

    </table>
The global board has ${directSpots} direct qualified players, 8 global points spots and ${extraSpots} spots opened by double qualification amounting to ${openSpots} qualified players out of a possible 24.
</div>

<div class="row" align="center">
    <div class="col-md-12" align="center">
        <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US&adInstanceId=4999401e-3b6b-483e-855a-486935992318&storeId=fgwora-20"></script>
    </div>
</div>


<g:each in="${regionalPlayers.keySet()}" var="region" status="ridx">

<h3>${region} Regional Board</h3>
The first two non-qualified players will directly qualify for Capcom Cup. Global board ranking has precedence, so players qualifying by global points are excluded for direct qualifaction in the region.
Green means directly qualified, yellow means qualified via global. Blue players will qualify via their regional score.
Note that 1 player in regional finals will qualify directly, so that may shift down the blue zone.<br/>
<strong>Curent qualifying players:</strong>
    ${regionalPlayers[region].findAll {it.findCptRanking(region)?.qualifiedByScore}.collect { it.name }.join(" and ")}
<p>&nbsp;</p>
<div class="table-responsive">

    <table class="tablehead" id="datatable${ridx+2}">

        <thead>
        <tr class="stathead">
            <th>CPT Rank</th>
            <th>Name</th>
            <th>Character</th>
            <th>Regional Score <a href="#" data-toggle="tooltip" data-placement="top"
                                  title="Score as granted by the Capcom Pro Tour 2016 ranking system for region">(?)</a>
            </th>
            <th>Qualifications <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Qualifications for Pro Tour">(?)</a></th>
            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
            <th>Score diff<a href="#" data-toggle="tooltip" data-placement="top"
                             title="Diff against score before update at ${lastUpdate?.format("yyyy-MM-dd")}">(?)</a>
            </th>
            <th>Rank diff<a href="#" data-toggle="tooltip" data-placement="top"
                            title="Diff against rank before update at ${lastUpdate?.format("yyyy-MM-dd")}">(?)</a></th>
            <th>Country</th>
        </tr>
        </thead>

        <g:each in="${regionalPlayers[region]}" var="p" status="pidx">

            <tr class="${p.findCptRanking(region)?.qualifiedByScore ? 'qual' : 'unqual'} ${p.findCptRanking(Region.GLOBAL)?.qualifiedByScore ? 'global' : ''} ${p.findCptRanking(Region.GLOBAL)?.qualified ? 'direct' : ''}">
                <td>
                    ${p.findCptRanking(region)?.rank}
                </td>
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
                <td>${p.findCptRanking(region)?.score}
                    </td>
                <td>
                    <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                            data-content="${raw(be.bbr.overview.RankingsController.cptSummary(p))}"
                            data-html="true" data-trigger="focus">
                        info
                    </button>
                    <g:if test="${p.cptGlobal()?.qualified}">
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                             height="24"/>
                    </g:if>
                    <small>${raw(be.bbr.overview.RankingsController.cptLabel(p, region))}</small>
                </td>
                <td>${p.cptTournaments}</td>

                <td>${p.diffCpt(region)}</td>
                <td class="${p.findCptRanking(region)?.rankDiffClass()}">
                    <g:if test="${p.diffCptRank(region) == null}">
                        <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
                    </g:if>
                    <g:elseif test="${p.diffCptRank(region) > 0}">
                        <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
                    </g:elseif>
                    <g:elseif test="${p.diffCptRank(region) < 0}">
                        <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
                    </g:elseif>
                    <g:if test="${p.diffCptRank(region) != null && p.diffCptRank(region) != 0}">
                        ${Math.abs(p.diffCptRank(region))}
                    </g:if>
                </td>


                <td>
                    <g:if test="${p.countryCode}">
                        <g:img dir="images/countries" file="${p.countryCode.name().toLowerCase() + '.png'}"
                               class="countryflag"/>
                        ${p.countryCode.name}
                    </g:if>
                </td>
            </tr>
        </g:each>

    </table>
</div>

</g:each>

<div class="row" align="center">
    <div class="col-md-12" align="center">
        <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US&adInstanceId=4999401e-3b6b-483e-855a-486935992318&storeId=fgwora-20"></script>
</div>
    </div>

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