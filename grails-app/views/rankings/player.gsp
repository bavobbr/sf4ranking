<%@ page import="be.bbr.sf4ranking.Region; org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Fighting Games World Rankings - ${player.name} results</title>
</head>

<body>
<div style="text-align: center;">
    <h1 class="player_name">${player.name}</h1>
</div>
<center>

    <div class="row">
        <div class="col-md-8">
            <dl class="dl-horizontal player_details">
                <dt>Country</dt>
                <dd>
                    <g:if test="${player.countryCode != null}">
                        <g:link controller="rankings" action="rank" params="[country: player.countryCode.name()]">
                            ${player.countryCode?.name}
                            <g:img dir="images/countries" file="${player.countryCode.name().toLowerCase() + '.png'}"
                                   alt="Find players from ${player.countryCode.name}"/>
                        </g:link>
                    </g:if>&NonBreakingSpace;
                </dd>
                <dt>Full name</dt>
                <dd>
                    <g:if test="${player.realname}">
                        ${player.realname}
                    </g:if>
                    <g:else>
                        <a href="#" data-toggle="tooltip" data-placement="top"
                           title="If you want to add your name to this page just share it on Twitter with the button below and we will favorite it when we linked it">(?)</a>
                    </g:else>
                </dd>
                <dt>Controller</dt>
                <dd>
                    <g:if test="${player.hardware}">
                        <g:link controller="gear" action="show" params="[id: player.hardware.id]">
                            ${player.hardware.shortname}
                        </g:link>
                    </g:if>
                    <g:else>
                        <a href="#" data-toggle="tooltip" data-placement="top"
                           title="Know the controller ${player.name} uses? Tweet it to us using page tweet!">(?)</a>
                    </g:else>
                </dd>
                <dt>Teams(s)</dt>
                <dd>
                    <g:if test="${player.teams}">
                        <g:each in="${player.teams}" var="team">
                            <g:link mapping="teamByName" action="team" controller="rankings"
                                    params="[name: team.name]">${team.name}</g:link>
                        </g:each>
                    </g:if>
                    <g:else>
                        <a href="#" data-toggle="tooltip" data-placement="top"
                           title="You can add this player to a team by sharing this page on Twitter and mentioning the team">(?)</a>
                    </g:else>
                </dd>
                <dt>Known for</dt>
                <dd>
                    <g:if test="${allGames}">
                        <g:each in="${allGames}" var="knowngame">
                            <g:link action="rank" controller="rankings"
                                    params="[id: knowngame.name()]">${knowngame.name()}</g:link>
                        </g:each>
                    </g:if>
                </dd>
                <dt>Top player in</dt>
                <dd>
                    <g:if test="${topGames}">
                        <g:each in="${topGames}" var="topgame">
                            <g:link action="rank" controller="rankings"
                                    params="[id: topgame.name()]">${topgame.name()}</g:link>
                        </g:each>
                    </g:if>
                </dd>
                <dt>Follow</dt>
                <dd>
                    <g:if test="${player.twitter}">
                        <g:render template="/templates/follow" model="[twitter: player.twitter]"/>&NonBreakingSpace;
                    </g:if>
                    <g:else>
                        <a href="#" data-toggle="tooltip" data-placement="top"
                           title="If you want to add your twitter handle to this page, share it on Twitter with the button below and we will favorite it when we linked it">(?)</a>
                    </g:else>
                </dd>
                <dt>Twitch Stream</dt>
                <dd>
                    <g:if test="${player.twitch}">
                        <a href="https://www.twitch.tv/${player.twitch}" target="_blank">${player.twitch}</a>
                    </g:if>
                    <g:else>
                        <a href="#" data-toggle="tooltip" data-placement="top"
                           title="If you want to add your Twitch handle to this page, share it on Twitter with the button below and we will favorite it when we linked it">(?)</a>
                    </g:else>
                </dd>
                <g:if test="${player.hasRanking(Version.SF5)}">
                    <dt>CPT score (rank) <a href="#" data-toggle="tooltip" data-placement="top"
                                     title="Global CPT score">(?)</a></dt>
                    <dd>
                        <g:link action="cpt" controller="rankings">
                        ${player.cptScore()} (${player.findCptRanking(Region.GLOBAL).rank})
                        </g:link>
                    </dd>
                    <dt>CPT Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                                        title="Directly qualified for CPT">(?)</a></dt>
                    <dd>
                        ${player.cptGlobal()?.qualified ? "Qualified" : "Not qualified"}
                    </dd>
                </g:if>
                <g:if test="${player.hasRanking(Version.SF5)}">
                    <dt>CPT Region scores <a href="#" data-toggle="tooltip" data-placement="top"
                                    title="Scores for regions Asia / Europe / Latin America / North America">(?)</a>
                    </dt>
                    <dd>
                        ${player.findCptRanking(Region.AO)?.score?:"-"} / ${player.findCptRanking(Region.EU)?.score?:"-"} / ${player.findCptRanking(Region.LA)?.score?:"-"} / ${player.findCptRanking(Region.NA)?.score?:"-"}
                    </dd>
                    <dt>CPT Region ranks <a href="#" data-toggle="tooltip" data-placement="top"
                                             title="Ranks for regions Asia / Europe / Latin America / North America">(?)</a>
                    </dt>
                    <dd>
                        ${player.findCptRanking(Region.AO)?.rank?:"-"} / ${player.findCptRanking(Region.EU)?.rank?:"-"} / ${player.findCptRanking(Region.LA)?.rank?:"-"} / ${player.findCptRanking(Region.NA)?.rank?:"-"}
                    </dd>
                    <dt>CPT RF <a href="#" data-toggle="tooltip" data-placement="top"
                                          title="Is this player qualified for the CPT Regional Finals?">(?)</a></dt>
                    <dd>
                        ${player.findCptRanking(Region.AO)?.qualified?"AO" : "-"} / ${player.findCptRanking(Region.EU)?.qualified?"EU" : "-"} / ${player.findCptRanking(Region.LA)?.qualified?"LA":"-"} / ${player.findCptRanking(Region.NA)?.qualified?"NA" : "-"}
                    </dd>
                </g:if>
                <dt>Compare</dt>
                <dd>
                    <g:link controller="stats" action="compare" params="[p1: player.id]">versus</g:link>
                </dd>
                <dt>Tweet results</dt>
                <dd>
                <g:render template="/templates/share"/>&NonBreakingSpace;
                </dd>
                <g:if test="${player.maxoplataId}">
                <dt>Match details <a href="#" data-toggle="tooltip" data-placement="top"
                                title="Link to the player profile on maxoplata.net to find more data on player matches and brackets">(?)</a></dt>
                <dd>
                <a href="http://www.maxoplata.net/player/${player.maxoplataId}" target="_blank">maxoplata.net</a>
                </dd>
                </g:if>
                    <dt>PSN/PC stats <a href="#" data-toggle="tooltip" data-placement="top"
                                        title="Link to v-league.pro that tracks player's online ranking and matches">(?)</a></dt>
                <g:if test="${player.onlineId}">
                    <dd>
                        <a href="http://v-league.pro/player/${player.onlineId}/profile" target="_blank">v-league.pro</a>
                    </dd>
                </g:if>
                <g:else>
                    <dd><small>(Tweet us the player id)</small></dd>
                </g:else>

            </dl>
        </div>

        <div class="col-md-4">
            <g:if test="${player.pictureUrl}">
                <img src="${player.pictureUrl}" class="img-responsive"/>
                <g:if test="${player.pictureCopyright}">
                    (c) ${player.pictureCopyright}
                </g:if>
                <g:else>
                    <p class="text-muted"><small>
                        <a href="#" data-toggle="tooltip" data-placement="top"
                           title="(no copyright known, tweet this page with your claim)">(copyright)</a>
                    </small>
                    </p>
                </g:else>
            </g:if>
            <g:else>
                <p class="text-muted">
                    <small>
                        (No image found yet, if you have one please tweet this page with URL to image)</small>
                </p>
            </g:else>
        </div>
    </div>

    <ul class="nav nav-tabs">
        <li class="active"><a href="#overview" data-toggle="tab">Overview</a></li>
        <g:each in="${results}" var="ranking" status="index">
            <li><a href="#${ranking.key.name()}" data-toggle="tab">${ranking.key.name()} <span
                    class="badge">${ranking.value.size()}</span></a></li>
        </g:each>
    %{--
            <li><a href="#videos" data-toggle="tab">Videos <span class="badge">${player.videos.size()}</span></a></li>
    --}%
    </ul>


    <div id='content' class="tab-content">
        <div class="tab-pane active" id="overview">
            <h3 class="tournaments">Tournament placings <small>found ${player.rankings.size()} games for</small> ${player.name} <small>in ${totalResults} results</small>
            </h3>
            <div class="table-responsive">
                <table class="tablehead" id="infotable">
                    <thead>
                    <tr class="stathead">
                        <th>Game</th>
                        <th>Rank</th>
                        <th>Current score</th>
                        <th>Lifetime Score</th>
                        <th>Main Team</th>
                        <th>Weight</th>
                        <th>Tournaments played</th>
                    </tr>
                    </thead>
                    <g:each in="${player.rankings}" var="ranking" status="index">
                        <g:if test="${results[ranking.game] != null}">
                            <tr>

                                <td>
                                    <g:link controller="rankings" action="rank" params="[id: ranking.game.name()]">
                                        ${ranking.game.value}
                                    </g:link>
                                </td>

                                <td>${ranking.rank}</td>
                                <td>${ranking.score}</td>
                                <td>${ranking.totalScore}</td>
                                <td>
                                    <g:each in="${ranking.mainCharacters}" var="mainCharacter">
                                        <g:link action="rank" controller="rankings"
                                                params="[pchar: mainCharacter.name(), id: ranking.game.name()]"
                                                data-toggle="tooltip" data-placement="top"
                                                title="Filter on ${mainCharacter.name()}">
                                            <g:set var="prepend"
                                                   value="${Version.generalize(ranking.game) == Version.USF4 ? "thumb_" : ""}"/>
                                            <g:img dir="images/chars/${Version.generalize(ranking.game).name().toLowerCase()}"
                                                   file="${prepend + mainCharacter.name().toLowerCase() + '.png'}"
                                                   height="30" class="charimg"/>
                                        </g:link>
                                    </g:each>

                                </td>
                                <td>${ranking.skill}</td>
                                <td>
                                    <g:link action="player" controller="rankings" params="[id: player.id]" fragment="${ranking.game.name()}" data-toggle="tab">
                                        ${results[ranking.game]?.size()} (see results)
                                    </g:link>
                                    </a>
                                </td>
                            </tr>
                        </g:if>
                    </g:each>
                </table>
            </div>
        </div>


        <g:each in="${results}" var="ranking" status="index">
            <div class="tab-pane" id="${ranking.key.name()}">
                <h3 class="tournaments">Tournament placings <small>found [${ranking.value.
                        size()}] ${ranking.key} tournaments for</small> ${player.name}
                </h3>

                <div class="table-responsive">
                    <table class="tablehead" id="datatable_${index}">
                        <thead>
                        <tr class="stathead">
                            <th>Tournament</th>
                            <th>Type</th>
                            <th>Ranking</th>
                            <th>Date</th>
                            <th>Team</th>
                            <th>Relative Points</th>
                            <th>Base Points</th>
                            <g:if test="${ranking.key == Version.SF5}">
                                <th>CPT Points</th>
                            </g:if>
                            <g:if test="${SecurityUtils.subject.isPermitted("player")}">
                                <th>Edit</th>
                            </g:if>
                        </tr>
                        </thead>
                        <g:each in="${ranking.value}" var="result">
                            <tr>
                                <td><g:link mapping="tournamentByName" controller="rankings" action="tournament"
                                            params="[name: result.tname]"
                                            title="View tournament">${result.tname}</g:link></td>
                                <td>${result.ttype}</td>
                                <td>${result.tplace}</td>
                                <td>${result.tdate}</td>
                                <td>
                                    <g:if test="${result.tteams}">
                                        <g:each in="${result.tteams}" var="tteam" status="rowidx">
                                            <g:if test="${rowidx > 0}">
                                                /
                                            </g:if>
                                            <g:each in="${tteam.pchars}" var="tchar">
                                                <g:link action="rank" controller="rankings"
                                                        params="[pchar: tchar.characterType.name(), id: ranking.key.name()]"
                                                        data-toggle="tooltip" data-placement="top"
                                                        title="Filter on ${tchar.characterType.name()}">
                                                    <g:img dir="images/chars/${Version.generalize(ranking.key).name().toLowerCase()}"
                                                           file="${tchar.characterType.name().toLowerCase() + '.png'}"
                                                           width="22" height="25"
                                                           class="charimg"/>
                                                </g:link>
                                            </g:each>
                                        </g:each>
                                    </g:if>
                                </td>
                                <td>${result.tscore}</td>
                                <td>${result.tbasescore}</td>
                                <g:if test="${ranking.key == Version.SF5}">
                                    <td>${result.tcpt}</td>
                                </g:if>
                                <g:if test="${SecurityUtils.subject.isPermitted("player")}">
                                    <td><g:link controller="result" action="show"
                                                params="[id: result.resultid]">[Update result as admin]</g:link></td>
                                </g:if>
                            </tr>
                        </g:each>
                    </table>
                </div>
            </div>
        </g:each>






        <g:if test="${SecurityUtils.subject.isPermitted("player")}">
            <g:link controller="admin" action="selectPlayerVideos"
                    params="['id': player.id]">[Update videos as admin]</g:link>
            <g:link controller="player" action="show" params="['id': player.id]">[Update player as admin]</g:link>
            <g:link controller="admin" action="split" params="['id': player.id]">[Split player as admin]</g:link>
        </g:if>

    %{--        <div class="tab-pane" id="videos">
                <g:if test="${player.videos}">
                    <h2>Player videos <small>found ${player.videos.size()} videos</small></h2>

                    <div class="row">
                        <g:each in="${player.videos}" var="video">
                            <div class="col-xs-6 col-md-3">
                                <a href="#" class="thumbnail">
                                    <div class="flex-video widescreen"><iframe src="//www.youtube.com/embed/${video}" frameborder="0"
                                                                               allowfullscreen></iframe></div>
                                </a>
                            </div>
                        </g:each>
                    </div>
                </g:if></div>--}%
</center>
<g:render template="/templates/prettify"/>

<script>
    // Javascript to enable link to tab
    var url = document.location.toString();
    if (url.match('#')) {
        $('.nav-tabs a[href="#' + url.split('#')[1] + '"]').tab('show');
    }

    // Change hash for page-reload
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        window.location.hash = e.target.hash;
    })
</script>
</body>
</html>