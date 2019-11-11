<%@ page import="be.bbr.sf4ranking.RankingType; org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial"/>
    <g:if test="${rankingType == be.bbr.sf4ranking.RankingType.ALLTIME}">
        <title>SRK data - ${game.value} All-time player rankings</title>
    </g:if>
    <g:elseif test="${rankingType == be.bbr.sf4ranking.RankingType.TRENDING}">
        <title>SRK data - ${game.value} Trending player rankings</title>
    </g:elseif>
    <g:else><title>SRK data - ${game.value} World Rankings</title>
    </g:else>

</head>

<body>

<g:if test="${fchar && !ffiltermain}">
    <div class="alert alert-info">
        When filtering on a character all players that used the character are listed, even if it is not their main. If you are looking for the best player, use the filter main checkbox on the bottom of the page
    </div>
</g:if>
<g:if test="${updateMessage}">
    <div class="alert alert-info alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:message message="${updateMessage}"/>

    </div>
</g:if>
<div><p>
    <g:if test="${rankingType == be.bbr.sf4ranking.RankingType.ALLTIME}">
        This ranking is based on all tournaments results from ${game.name()}. The best 18 results of these are summed to form the lifetime score.
        The importance of tournaments is sorted by weight only, based on player skill attending.
        If you would like to see how a player did the last 12 months of ${game.value} you can find a ranking on the <g:link
            controller="rankings" action="rank" params="[rankingType: RankingType.ACTUAL.name(), id: game.name()]">Actual Ranking</g:link> page.
    </g:if>
    <g:elseif test="${rankingType == be.bbr.sf4ranking.RankingType.TRENDING}">
        This ranking is based on only recent tournaments results from ${game.name()}. The best 12 results of the last 6 months are summed to form the trending score.
        The importance of tournaments is qualified by class, based on player skill attending.
        If you would like to see how a player did the last 12 months of ${game.value} you can find a ranking on the <g:link
            controller="rankings" action="rank" params="[rankingType: RankingType.ACTUAL.name(), id: game.name()]">Actual Ranking</g:link> page.
    </g:elseif>
    <g:else>
        This ranking is based on tournaments results of the latest 12 months using the official tournament scoring detailed on <g:link
            controller="about">FAQ</g:link>. The list is updated every week. The tournaments are judged by class, in a sliding window of the last 12 months. You can find an unlimited ranking based on pure tournament weight on the
        <g:link controller="rankings" action="rank" params="[rankingType: RankingType.ALLTIME.name(), id: game.name()]">All-time Ranking</g:link> page, and a short-time trend via the <g:link controller="rankings" action="rank" params="[rankingType: RankingType.TRENDING.name(), id: game.name()]">trending </g:link>page.
    </g:else>
</p>
</div>

<g:if test="${game.end}">
    <div class="alert alert-info">
        This game has ended competitive tracking at ${game.end}. All statistics are taken before that date. Results after the date are registered but not used in statistics.
        When a game closes, data is considered for last two years instead of last 12 months.
    </div>
</g:if>

<div class="table-responsive">

    <table class="table table-striped table-hover table-condensed">
        <thead>
        <tr>
            <g:if test="${filtered}">
                <th>Index</th>
            </g:if>
            <th>Rank</th>
            <th>Name</th>
            <th>Team</th>
            <th>Character</th>
            <th>Actual Score <a href="#" data-toggle="tooltip" data-placement="top"
                                 title="The actual current score is calculated over an 12 month window. His best 12 scores are used to calculate a total score, and a small decay is used over time.">(?)</a>
            </th>
            <th>Tournaments <a href="#" data-toggle="tooltip" data-placement="top"
                                      title="The amount of valid results in tournaments over last 12 months adding to the actual score, capped at 12 maximum.">(?)</a>
            </th>
            <th>Country</th>
            <g:if test="${snapshot != null && rankingType == RankingType.ACTUAL}">
                <th>Rank Diff <a href="#" data-toggle="tooltip" data-placement="top"
                                 title="Rank difference between now and ${snapshot?.format("yyyy-MM-dd")}">(?)</a></th>
            </g:if>
            <g:elseif test="${rankingType == RankingType.ALLTIME}">
                <th>Trend <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Rank difference between all-time and actual ranking. This shows if a player is trending upwards or downwards over all time">(?)</a>
                </th>
            </g:elseif>
            <g:elseif test="${rankingType == RankingType.TRENDING}">
                <th>Trend <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Rank difference between trending and actual ranking. This shows if a player is trending upwards or downwards in recent time">(?)</a>
                </th>
            </g:elseif>
            <th>Lifetime Score <a href="#" data-toggle="tooltip" data-placement="top"
                                  title="The lifetime score is the sum of a player's best 12 tournaments in this game without any decay or time constraints. This gives an idea on the overall player dominance throughout the lifespan of the game">(?)</a>
            <th>Tournaments <a href="#" data-toggle="tooltip" data-placement="top"
                               title="The total amount of tournaments eligible for lifetime best of score (of which only 18 count)">(?)</a></th>
            </th>
            <th>Trending Score <a href="#" data-toggle="tooltip" data-placement="top"
                                  title="The trending score is the sum of best 12 tournaments in this game within last 6 months. This gives an idea on the short-term player dominance">(?)</a>
            </th>

        </tr>
        </thead>

        <g:each in="${players}" var="p" status="idx">

            <tr>
                <g:if test="${filtered}">
                    <td>${idx + poffset + 1}</td>
                </g:if>
                <g:if test="${rankingType == rankingType.ACTUAL}">
                    <td>${p.rank(game)}</td>
                </g:if>
                <g:elseif test="${rankingType == rankingType.ALLTIME}">
                    <td>${p.totalRank(game)}</td>
                </g:elseif>
                <g:elseif test="${rankingType == rankingType.TRENDING}">
                    <td>${p.trendingRank(game)}</td>
                </g:elseif>
                <td><g:link controller="rankings" mapping="playerByName" action="player"
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
                        <g:link action="rank" controller="rankings" params="[pchar: mainChar, id: game.name(), filtermain: 'on']"
                                data-toggle="tooltip" data-placement="top" title="Filter on ${mainChar.value}">
                            <g:img dir="images/chars/${Version.generalize(game).name().toLowerCase()}"
                                   file="${mainChar.name().toLowerCase() + '.png'}" width="22" height="25"
                                   alt="${mainChar.value}"
                                   class="charimg"/>
                        </g:link>
                    </g:each>
                </td>
                <td>${p.score(game)}
                    <g:if test="${p.cptGlobal()?.qualified}">
                        <g:link controller="rankings" action="cpt">
                            <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="20"
                                 height="20"/>
                        </g:link>
                    </g:if>
                </td>
                <td>${p.numResultsYear()}

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
                <g:if test="${snapshot != null && rankingType == RankingType.ACTUAL}">
                    <g:if test="${p.diffRank(game) == null}">
                        <td class="warning">
                            <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
                        </td>
                    </g:if>
                    <g:else>
                        <td class="${p.diffRank(game) == 0 ? '' : p.diffRank(game) > 0 ? 'success' : 'danger'}">
                            <g:if test="${p.diffRank(game) > 0}">
                                <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
                            </g:if>
                            <g:elseif test="${p.diffRank(game) < 0}">
                                <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
                            </g:elseif>
                            <g:if test="${p.diffRank(game) != 0 && p.diffRank(game) != null}">
                                ${Math.abs(p.diffRank(game))}
                            </g:if>
                        </td>
                    </g:else>
                </g:if>
                <g:elseif test="${rankingType == RankingType.ALLTIME}">
                    <g:if test="${p.diffTotalRank(game) == null}">
                        <td class="warning">
                            <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
                        </td>
                    </g:if>
                    <g:else>
                        <td class="${p.diffTotalRank(game) == 0 ? '' : p.diffTotalRank(game) > 0 ? 'success' : 'danger'}">
                            <g:if test="${p.diffTotalRank(game) > 0}">
                                <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
                            </g:if>
                            <g:elseif test="${p.diffTotalRank(game) < 0}">
                                <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
                            </g:elseif>
                            <g:if test="${p.diffTotalRank(game) != 0 && p.diffTotalRank(game) != null}">
                                ${Math.abs(p.diffTotalRank(game))}
                            </g:if>
                        </td>
                    </g:else>
                </g:elseif>
                <g:elseif test="${rankingType == RankingType.TRENDING}">
                    <g:if test="${p.diffTrendRank(game) == null}">
                        <td class="warning">
                            <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span>
                        </td>
                    </g:if>
                    <g:else>
                        <td class="${p.diffTrendRank(game) == 0 ? '' : p.diffTrendRank(game) > 0 ? 'success' : 'danger'}">
                            <g:if test="${p.diffTrendRank(game) > 0}">
                                <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
                            </g:if>
                            <g:elseif test="${p.diffTrendRank(game) < 0}">
                                <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
                            </g:elseif>
                            <g:if test="${p.diffTrendRank(game) != 0 && p.diffTrendRank(game) != null}">
                                ${Math.abs(p.diffTrendRank(game))}
                            </g:if>
                        </td>
                    </g:else>
                </g:elseif>
                <td>${p.totalScore(game)}</td>

                <td>${p.numResults()}
            <td>${p.trendingScore(game)}</td>

            </td>
                <g:if test="${SecurityUtils.subject.isPermitted("player")}">
                    <td>
                        <g:link controller="player" action="edit" params="[id: p.id]" target="_blank">[edit]</g:link><g:link controller="playerRanking" action="edit" params="[id: p.findRanking(game).id]"
                                                                                                                             target="_blank">[${p.skill(game)}]</g:link>
                    </td>
                </g:if>


            </tr>
        </g:each>

    </table></div>

<div id="pagination">
    <g:paginate total="${total}" controller="rankings" action="rank" max="50"
                params="[country: params.country, pchar: params.pchar, id: game.name(), rankingType: rankingType.name()]"/>
</div>
This is a list of the best ${game.value} tournament players world-wide. The ${game.name()} top player board is composed by looking at player weights, tournament difficulty and international appeal. For more info on the algorithm check out <g:link
        controller="about">The FAQ page</g:link>. This is a subjective list and is only meant to give an idea on who is making name and fame in the FGC. The ranking aims to provide a database of tournament results as well, open to the community.

<div class="row">
    <div class="col-md-7">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Filter</h3>
            </div>

            <div class="panel-body">

                <g:form name="filter" controller="rankings" action="rank" role="form" class="form-inline" method="get">
                    <div class="row">
                        <div class="col-md-4">
                            <g:select name="country" from="${countries}" class="form-control" value="${fcountry?.name}"/>
                        </div>
                        <div class="col-md-4">
                            <g:select name="pchar" from="${charnames}" class="form-control" value="${fchar?.value}"/>
                        </div>
                        <div class="col-md-4">
                            <g:hiddenField name="rankingType" value="${rankingType.name()}"/>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <g:checkBox name="filtermain" class="form-control" value="${ffiltermain}"/>
                            <g:hiddenField name="id" value="${game.name()}"/> Only search on main char
                        </div>

                    </div>
                </g:form>
            </div>
        </div>
    </div>

    <div class="col-md-5">
        <script type="text/javascript">
            amzn_assoc_placement = "adunit0";
            amzn_assoc_search_bar = "false";
            amzn_assoc_tracking_id = "capcombooks-20";
            amzn_assoc_ad_mode = "search";
            amzn_assoc_ad_type = "smart";
            amzn_assoc_marketplace = "amazon";
            amzn_assoc_region = "US";
            amzn_assoc_title = "Gaming Books";
            amzn_assoc_default_search_phrase = "capcom";
            amzn_assoc_default_category = "Books";
            amzn_assoc_linkid = "2093b0ce7f3bad6de66a5be83c60edc5";
            amzn_assoc_default_browse_node = "283155";
        </script>
        <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US"></script>
    </div>
</div>
</body>
</html>