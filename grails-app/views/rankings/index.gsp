<%@ page import="be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Fighting Games World Rankings</title>
</head>

<body>
<center>
    <h2 class="title">Fighting Games World Rankings</h2>
</center>

<g:if test="${updateMessage}">
    <div class="alert alert-info">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:message message="${updateMessage}"/>
    </div>
</g:if>

<div class="row">
    <div class="col-md-6">
        <g:img dir="images/banners" file="sfv.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.SF5, players: sf5players]"/>
    </div>

    <div class="col-md-6">
        <g:img dir="images/banners" file="sfv.jpg" class="img-responsive"/>
        <h4>SF5 Top 10 trending characters</h4>

        <div>
            <table class="table table-striped table-hover table-condensed table-responsive">
                <thead>
                <tr>
                    <th>Rank</th>
                    <th>Name</th>
                    <th>Trending score</th>
                    <th>Top trending player</th>
                    <th>Character wins</th>
                </tr>
                </thead>
                <g:each in="${topsf5chars}" var="c" status="idx">
                    <tr class="top10table">
                        <td>${idx + 1}</td>
                        <td><g:link controller="stats" action="character"
                                    params="[charname: c.characterType.name(), game: Version.SF5.name()]">
                            <g:img dir="images/chars/${Version.generalize(Version.SF5).name().toLowerCase()}" file="${c.characterType.name().toLowerCase() + '.png'}" width="22" height="25"
                                   alt="${c.characterType.value}"
                                   class="charimg"/>
                        </g:link>
                        </td>
                        <td>
                            ${c.trendingScoreAccumulated}
                        </td>
                        <td>
                            ${c.trendingPlayer.name}
                        </td>
                        <td>
                            ${c.top1finishes}
                        </td>
                    </tr>
                </g:each>
            </table></div>
        View <g:link action="index" controller="stats" params="['id': Version.SF5.name()]"
                     class="toplink"> all character rankings (alltime, current and trending)</g:link>
    </div>

</div>

&NonBreakingSpace;
<div class="row">

    <div class="col-md-6">
        <g:img dir="images/banners" file="banner_general.png" class="img-responsive"/>
        <h4>Top stuff</h4>

        <table class="table table-striped table-hover table-condensed table-responsive">
            <thead>
            <tr>
                <th>Items</th>
            </tr>
            </thead>
            <tr>
                <td class="amazon_row">
                    <script type="text/javascript">
                        amzn_assoc_placement = "adunit0";
                        amzn_assoc_search_bar = "true";
                        amzn_assoc_tracking_id = "topstuff0e-20";
                        amzn_assoc_ad_mode = "manual";
                        amzn_assoc_ad_type = "smart";
                        amzn_assoc_marketplace = "amazon";
                        amzn_assoc_region = "US";
                        amzn_assoc_title = "";
                        amzn_assoc_linkid = "effc15201ef3b8bfbc6d78d87839f3f7";
                        amzn_assoc_asins = "B01NBTWOVC,B06XS5HPVC,B01ISNHNFA,B00SKGV3OI";
                    </script>
                    <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US"></script>
                </td>
            </tr>
        </table>
    </div>

    <div class="col-md-6">
        <g:img dir="images/banners" file="mkx.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.MKX, players: mkxplayers]"/>
    </div>
</div>
&NonBreakingSpace;
<div class="row">

    <div class="col-md-6">
        <g:img dir="images/banners" file="killerinstinct.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.KI, players: kiplayers]"/>
    </div>

    <div class="col-md-6">
        <g:img dir="images/banners" file="umvc3.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.UMVC3, players: umvc3players]"/>
    </div>

</div>

<div class="row">

    <div class="col-md-6">
        <g:img dir="images/banners" file="bbcp.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.BBCP, players: bbcpplayers]"/>
    </div>

    <div class="col-md-6">
        <g:img dir="images/banners" file="ae2012.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.AE2012, players: players]"/>
    </div>

</div>

<div class="row">

    <div class="col-md-6">
        <g:img dir="images/banners" file="igau.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.IGAU, players: igauplayers]"/>
    </div>

    <div class="col-md-6">
        <g:img dir="images/banners" file="usf4.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.USF4, players: usf4players]"/>
    </div>
</div>

<div class="row">

    <div class="col-md-6">
        <g:img dir="images/banners" file="skullgirls.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.SKULLGIRLS, players: sgplayers]"/>
    </div>

</div>


<div class="row">
    <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US&adInstanceId=92a40fad-32f4-4e45-8e9c-ba21f4170ba9"></script>
</div>


<div class="row">
    <div class="col-md-7">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Latest Tournaments</h3>
            </div>

            <div class="panel-body">
                <ul>
                    <g:each in="${lastTournaments}" var="t">
                        <li><g:link controller="rankings" action="tournament"
                                    params="[id: t.id]">${t.name}</g:link></li>
                    </g:each>
            </div>
        </div>
    </div>


    <div class="col-md-5">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Newest Players</h3>
            </div>

            <div class="panel-body">
                <ul>
                    <g:each in="${lastPlayers}" var="p">
                        <li><g:link controller="rankings" action="player"
                                    params="[id: p.id]">${p.name}</g:link></li>
                    </g:each>
            </div>
        </div>
    </div>
</div>
</body>
</html>