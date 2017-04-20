<%@ page import="be.bbr.sf4ranking.CptTournament; org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Fighting Games World Rankings - ${tournament.game.value} - ${tournament.name} Tournament Details</title>

</head>

<body>
<h2 class="tournament"><small>${tournament.name}</small> Tournament details</h2>
<g:if test="${updateMessage}">
    <div class="alert alert-info alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:message message="${updateMessage}"/>

    </div>
</g:if>
<div class="table-responsive">
    <table class="table table-striped table-hover tdetails">
        <thead>
        <tr>
            <th>Type</th>
            <th>Country</th>
            <th>Date</th>
            <th>Format</th>
            <th>Game</th>
            <th>Weight</th>
            <th>Share</th>
            <th>Coverage</th>
            <th>Creator</th>
            <g:if test="${tournament.game == Version.SF5}">
                <th>CPT</th>
            </g:if>
        </tr>
        </thead>
        <tr>
            <td>${tournament.tournamentType?.value}</td>
            <td>${tournament.countryCode?.name}</td>
            <td>${tournament.date?.format("MM-yyyy")}</td>
            <td>${tournament.tournamentFormat?.value}</td>
            <td>${tournament.game?.value}</td>
            <td>${tournament.weight}</td>
            <td>
                <g:render template="/templates/share"/>
            </td>

            <td>
                <g:if test="${tournament.coverage}">
                    <g:link url="${tournament.coverage}" target="_new">
                        source
                    </g:link>
                </g:if>
            </td>
            <td>${tournament.creator}</td>
            <g:if test="${tournament.game == Version.SF5}">
                <td>${tournament.cptTournament}</td>
            </g:if>
        </tr>
    </table>
</div>

<h2 class="tournament"><large>Registered ${details.size()} rankings</large></h2>

<div class="table-responsive">
    <table class="tablehead" id="datatable">
        <thead>
        <tr class="stathead">
            <th>Place</th>
            <th>Player</th>
            <th>Top</th>
            <th>Team(s)</th>
            <th>Country</th>
            <th>Score</th>
            <g:if test="${tournament.cptTournament != be.bbr.sf4ranking.CptTournament.NONE}">
                <th>CPT Points</th>
            </g:if>
            <g:if test="${tournament.cptTournament in [be.bbr.sf4ranking.CptTournament.PREMIER, be.bbr.sf4ranking.CptTournament.EVO, be.bbr.sf4ranking.CptTournament.CC]}">
                <td>CPT Prize</td>
            </g:if>
            <g:if test="${SecurityUtils.subject.isPermitted("player")}">
                <th>Result</th>
                <th>Player</th>
                <th>Skill</th>
            </g:if>
        </tr>
        </thead>
        <g:each in="${details}" var="result">
            <tr>
                <td>${result.rplace}</td>
                <td><g:link mapping="playerByName" controller="rankings" action="player"
                            params="[name: result.rplayer]">${result.rplayer}</g:link></td>
                <td>
                    <div class="${result.rlabel.cssClass}">
                    ${result.rlabel.displayValue}
                    </div>
                </td>
                <td>
                    <g:if test="${result.tteams}">
                        <g:each in="${result.tteams}" var="tteam" status="rowidx">
                            <g:if test="${rowidx > 0}">
                                /
                            </g:if>
                            <g:each in="${tteam.pchars}" var="tchar">
                                <g:link action="rank" controller="rankings"
                                        params="[pchar: tchar.characterType.name(), id: tournament.game.name()]"
                                        data-toggle="tooltip" data-placement="top"
                                        title="Filter on ${tchar.characterType.name()}">
                                    <g:img dir="images/chars/${Version.generalize(tournament.game).name().toLowerCase()}"
                                           file="${tchar.characterType.name().toLowerCase() + '.png'}" width="22"
                                           height="25" class="charimg"/>
                                </g:link>
                            </g:each>
                        </g:each>
                    </g:if>
                </td>
                <td>
                    <g:if test="${result.rcountry != null}">
                        <g:link controller="rankings" action="tournaments" params="[country: result.rcountry]">
                            <g:img dir="images/countries" file="${result.rcountry + '.png'}" class="countryflag"/>
                            ${result.rcountryname}
                        </g:link>
                    </g:if>
                </td>
                <td>${result.rscore}</td>
                <g:if test="${tournament.cptTournament != be.bbr.sf4ranking.CptTournament.NONE}">
                    <td>${tournament.cptTournament?.getScore(result.rplace) ?: 0}</td>
                </g:if>
                <g:if test="${tournament.cptTournament in [be.bbr.sf4ranking.CptTournament.PREMIER, be.bbr.sf4ranking.CptTournament.EVO, be.bbr.sf4ranking.CptTournament.CC]}">
                    <td>${tournament.cptTournament.getPrize(result.rplace, tournament.countryCode)}</td>
                </g:if>
                <g:if test="${SecurityUtils.subject.isPermitted("player")}">
                    <td><g:link controller="result" action="edit"
                                params="['id': result.resultid]">[Update result]</g:link></td>
                    <td><g:link controller="player" action="edit"
                                params="['id': result.rplayerid]">[Update player]</g:link></td>
                    <td><g:link controller="playerRanking" action="edit"
                                params="['id': result.prankingid]">[Update skill ${result.pskill}]</g:link></td>
                </g:if>
            </tr>
        </g:each>
    </table>
</div>

<g:if test="${SecurityUtils.subject.isPermitted("tournament")}">
    <div class="alert alert-info">
    <g:link controller="tournament" action="show" params="['id': tournament.id]">[Update tournament...]</g:link>
    <g:link controller="admin" action="importer" params="['source': tournament.id]">[Use as template...]</g:link>
    <g:link controller="admin" action="replaceResults" params="['id': tournament.id]">[Replace results...]</g:link>
    <g:link controller="admin" action="batchSetCountry"
            params="['id': tournament.id]">[Batch apply ${tournament.countryCode.name()}]</g:link>
    </div>

</g:if>

<div class="row" align="center">
    <div class="col-md-12" align="center">
        <script type="text/javascript">
            amzn_assoc_placement = "adunit0";
            amzn_assoc_search_bar = "false";
            amzn_assoc_tracking_id = "fgwora-20";
            amzn_assoc_ad_mode = "search";
            amzn_assoc_ad_type = "smart";
            amzn_assoc_marketplace = "amazon";
            amzn_assoc_region = "US";
            amzn_assoc_title = "Shop Related Products";
            amzn_assoc_default_search_phrase = "nintendo switch";
            amzn_assoc_default_category = "All";
            amzn_assoc_linkid = "919899be79cdf14ca1b81c0b22f6c130";
        </script>
        <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US"></script>    </div>
</div>


%{--<g:if test="${org.apache.shiro.SecurityUtils.subject.hasRole("Administrator")}">
    <g:link controller="admin" action="selectTournamentVideos" params="['id': tournament.id]">[Update videos]</g:link>
    <g:link controller="admin" action="playerDiffForTournament" params="['id': tournament.id]">[Diff page]</g:link>
    <g:link controller="admin" action="playerRanksBefore"
            params="['id': tournament.id]">[Scores before tournament]</g:link>
    <g:link controller="admin" action="playerRanksAfter"
            params="['id': tournament.id]">[Scores after tournament]</g:link>
</g:if>--}%


%{--<g:if test="${tournament.videos}">
  <h2>Tournament videos <small>found ${tournament.videos.size()} videos</small></h2>
  <div class="row">
    <g:each in="${tournament.videos}" var="video">
      <div class="col-xs-6 col-md-3">
        <a href="#" class="thumbnail">
          <div class="flex-video widescreen"><iframe src="//www.youtube.com/embed/${video}" frameborder="0"
                                                     allowfullscreen></iframe></div>
        </a>
      </div>
    </g:each>
  </div>
</g:if>--}%

<g:render template="/templates/prettify"/>
</body>
</html>