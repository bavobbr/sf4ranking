<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <g:if test="${alltime}">
        <title>${game.value} All-time Rankings</title>
    </g:if>
    <g:else><title>${game.value} World Rankings</title>
    </g:else>

</head>

<body>
<g:if test="${filtered}">
    <center><h2 class="title-filtered">${game.value} Tournament Rankings - Filtered on ${fcountry} ${fchar}</h2></center>
</g:if>
<g:elseif test="${alltime}">
    <center><h2 class="title-filtered">${game.value} Tournament Rankings - All-time score ranking</h2></center>
</g:elseif>
<g:else>
    <center>
        <h2 class="title">${game.value} Tournament Rankings</h2>
    </center>
</g:else>


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
    <g:if test="${alltime}">
        This ranking is based on all tournaments results from ${game.name()}. The best 12 results of these are summed to form the lifetime score.
        The importance of tournaments is sorted by weight, not class.
        If you would like to see how a player did the last two years of ${game.value} you can find a ranking on the <g:link
            controller="rankings" action="rank" params="[alltime: false, id: game.name()]">Actual Ranking</g:link> page.
    </g:if>
    <g:else>
        This ranking is based on tournaments results between now and one year ago using the official tournament scoring detailed on <g:link
            controller="about">FAQ</g:link>. The list is updated every week. If you would like to see how a player did
over the lifespan of ${game.value}. The tournaments are judged by class, in a sliding window of the last two years (following Tennis rules). You can find an unlimited ranking based on pure tournament weight on the <g:link
            controller="rankings" action="rank"
            params="[alltime: true, id: game.name()]">All-time Ranking</g:link> page.
    </g:else>
</div></p>
<div class="table-responsive">

    <table class="table table-striped table-hover table-condensed">
        <thead>
        <tr>
            <g:if test="${filtered || alltime}">
                <th>Index</th>
            </g:if>
            <th>Rank</th>
            <th>Name</th>
            <th>Team</th>
            <th>Character</th>
            <th>Current Score <a href="#" data-toggle="tooltip" data-placement="top"
                                 title="The actual current score is calculated over a 2-year window. This reflects how well a player has been doing over the last 2 years. His best 12 scores are used for the total.">(?)</a>
            </th>
            <th>Actual Tournaments <a href="#" data-toggle="tooltip" data-placement="top"
                                      title="The amount of best 12 results in tournaments over last 2 years adding to the actual score">(?)</a>
            </th>
            <th>Lifetime Score <a href="#" data-toggle="tooltip" data-placement="top"
                                  title="The lifetime score is the sum of best 12 tournaments in this game without decay or time constraints. This gives an idea on the overall player dominance throughout the lifespan of the game">(?)</a>
            </th>
            <th>Tournaments <a href="#" data-toggle="tooltip" data-placement="top"
                                     title="The total amount of tournaments contributing to lifetime best of score">(?)</a></th>
            <th>Country</th>
            <g:if test="${snapshot != null && !alltime}">
                <th>Rank Diff <a href="#" data-toggle="tooltip" data-placement="top"
                                 title="Rank difference between now and ${snapshot?.format("yyyy-MM-dd")}">(?)</a></th>
            </g:if>
            <g:elseif test="${alltime}">
                <th>Trend <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Rank difference between alltime and actual ranking. This shows if a player is trending upwards or downwards">(?)</a>
                </th>
            </g:elseif>
        </tr>
        </thead>

        <g:each in="${players}" var="p" status="idx">

            <tr>
                <g:if test="${filtered || alltime}">
                    <td>${idx + poffset + 1}</td>
                </g:if>
                <td>${p.rank(game)}

                </td>
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
                        <g:link action="rank" controller="rankings" params="[pchar: mainChar, id: game.name()]"
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

                <td>${p.totalScore(game)}</td>

                <td>${p.numResults()}
                </td>
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
                <g:if test="${snapshot != null && !alltime}">
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
                <g:elseif test="${alltime}">
                    <g:if test="${p.rank(game) == null}">
                        <td class="warning">
                            <span class="glyphicon glyphicon-arrow-right" aria-hidden="true">d</span>
                        </td>
                    </g:if>
                    <g:else>
                        <td class="${idx + poffset + 1 - p.rank(game) >= 0 ? 'success' : 'danger'}">
                            <g:if test="${idx + poffset + 1 - p.rank(game) > 0}">
                                <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
                                ${Math.abs(idx + poffset + 1 - p.rank(game))}
                            </g:if>
                            <g:elseif test="${idx + poffset + 1 - p.rank(game) < 0}">
                                <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
                                ${Math.abs(idx + poffset + 1 - p.rank(game))}
                            </g:elseif>
                        </td>
                    </g:else>
                </g:elseif>
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
                params="[country: params.country, pchar: params.pchar, id: game.name()]"/>
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
                            <g:select name="country" from="${countries}" class="form-control" value="${fcountry}"/>
                        </div>
                        <div class="col-md-4">
                            <g:select name="pchar" from="${charnames}" class="form-control" value="${fchar}"/>
                        </div>
                        <div class="col-md-4">
                            <g:hiddenField name="alltime" value="${alltime}"/>
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
        <div class="panel panel-info">
            <g:link controller="gear" action="index">
                <img src="https://s3.amazonaws.com/srkranking/controllers/madcatz_family_small.jpeg"
                     class="img-responsive"
                     alt="Mad catz controller prices" data-toggle="tooltip" data-placement="top"
                     title="Mad catz arcade stick and controller prices"/>
            </g:link>
        </div>
    </div>
</div>
</body>
</html>