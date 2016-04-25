<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Fighting Games World Rankings - ${player.name} results</title>
</head>

<body>
<div style="text-align: center;">
    <h6 class="player-heading">Fighting Game World Ranking</h6><span class="glyphicon glyphicon-flash"></span>

    <h1 class="player_name">${player.name}</h1>

    <h3 class="world_rank">${player.rank(player.mainGame)}</h3>
    <span class="glyphicon glyphicon-flash"></span>
    <span class="world_rank_title">${player.mainGame.value} World Rank</span>
    <span class="glyphicon glyphicon-flash"></span>
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
                <dt>Follow</dt>
                <dd>
                    <g:if test="${player.twitter}">
                        <g:render template="/templates/follow" model="[twitter: player.twitter]"/>&NonBreakingSpace;
                    </g:if>
                    <g:else>
                        <a href="#" data-toggle="tooltip" data-placement="top"
                           title="If you want to add your twitter handle to this page just share it on Twitter with the button below and we will favorite it when we linked it">(?)</a>
                    </g:else>
                </dd>
                <dt>Main Game</dt>
                <dd>
                    <g:link controller="rankings" action="rank"
                            params="[id: player.mainGame.name()]">${player.mainGame}</g:link>
                </dd>
                <g:if test="${player.hasRanking(Version.SF5)}">
                    <dt>CPT Score</dt>
                    <dd>
                        ${player.cptScore}
                    </dd>
                    <dt>CPT Qualified</dt>
                    <dd>
                        ${player.cptQualified ? "Qualified" : "Not qualified"}
                    </dd>
                </g:if>
                <g:if test="${player.hasRanking(Version.SF5)}">
                    <dt>CPT Score AO/EU/LA/NA</dt>
                    <dd>
                        ${player.cptScoreAO}/${player.cptScoreEU}/${player.cptScoreLA}/${player.cptScoreNA}
                    </dd>
                    <dt>CPT Regional Finals</dt>
                    <dd>
                        ${player.cptRegionalQualified ? "Qualified" : "Not qualified"}
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
                        (no copyright known, tweet this page with your claim)
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
            <h3 class="tournaments">Tournament placings <small>found ${player.rankings.size()} games for</small> ${player.name}
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
                                                   height="50" class="charimg"/>
                                        </g:link>
                                    </g:each>

                                </td>
                                <td>${ranking.skill}</td>
                                <td>
                                    <a href="#${ranking.game.name()}" data-toggle="tab">
                                        ${results[ranking.game]?.size()}
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
</body>
</html>