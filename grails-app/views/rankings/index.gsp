<%@ page import="be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial"/>
    <title>SRK data - FGC world rankings</title>
</head>

<body>

<g:if test="${updateMessage}">
    <div class="alert alert-info">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:message message="${updateMessage}"/>
    </div>
</g:if>

<div class="row">
    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="sfv.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.SF5, players: sf5players]"/>
    </div>

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="ae2012.png" class="img-responsive"/>
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
                            <g:img dir="images/chars/${Version.generalize(Version.SF5).name().toLowerCase()}"
                                   file="${c.characterType.name().toLowerCase() + '.png'}" width="22" height="25"
                                   alt="${c.characterType.value}"
                                   class="charimg"/>
                            ${c.characterType.value}
                        </g:link>
                        </td>
                        <td>
                            ${c.trendingScoreAccumulated}
                        </td>
                        <td>
                            ${c.trendingPlayer.name}
                        </td>
                        <td>
                            ${c.top1finishesTrending}
                        </td>
                    </tr>
                </g:each>
            </table></div>
        View <g:link action="index" controller="stats" params="['id': Version.SF5.name()]"
                     class="toplink">all character rankings (alltime, current and trending)</g:link>
    </div>

</div>

&NonBreakingSpace;
<div class="row">

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="dbfz.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.DBFZ, players: dbfzplayers]"/>
    </div>


    <div class="col-md-6">

        <table class="table table-striped table-hover table-condensed table-responsive">
            <tr>
                %{--
                                <td class="amazon_row">
                                    <script type="text/javascript">
                                        amzn_assoc_placement = "adunit0";
                                        amzn_assoc_tracking_id = "mainpage-custom-20";
                                        amzn_assoc_ad_mode = "manual";
                                        amzn_assoc_ad_type = "smart";
                                        amzn_assoc_marketplace = "amazon";
                                        amzn_assoc_region = "US";
                                        amzn_assoc_title = "Books";
                                        amzn_assoc_linkid = "fcb2f349ac65c1d244296f36cd2bf49f";
                                        amzn_assoc_asins = "B079WPXRC5,B01JOEKKWU,B074N7GFRP,1465414584,1927925193,B079342TFC,B01BVJ1U3Y,1421525666";
                                        amzn_assoc_search_bar = "false";
                                    </script>
                                    <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US"></script>
                                </td>
                --}%
                <td class="amazon_row">
   %{--                 <g:link url="https://displate.com/displate/592124?merch=5b5a0ec49ef2b">
                        <g:img dir="images/displate" file="ryu_large.png" class="img-responsive"/>
                    </g:link>
                </td>--}%
                <script id="mNCC" language="javascript">
                    medianet_width = "336";
                    medianet_height = "280";
                    medianet_crid = "592703599";
                    medianet_versionId = "3111299";
                </script>
                <script src="//contextual.media.net/nmedianet.js?cid=8CU54R87O"></script>

            </tr>
        </table>
    </div>

</div>
&NonBreakingSpace;
<div class="row">

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="tekken7.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.T7, players: t7players]"/>
    </div>


    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="ggxrd.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.GGXRD, players: ggplayers]"/>
    </div>

</div>

<div class="row">

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="injustice2.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.INJUSTICE2, players: inj2players]"/>
    </div>

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="mvci.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.MVCI, players: mvciplayers]"/>
    </div>

</div>


<div class="row">

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="mkx.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.MKX, players: mkxplayers]"/>
    </div>

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="killerinstinct.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.KI, players: kiplayers]"/>
    </div>

</div>

<div class="row">
    <div class="col-md-6 top10box">
        <td class="amazon_row">
%{--            <g:link url="https://displate.com/displate/592812?merch=5b5a0ec49ef2b">
                <g:img dir="images/displate" file="scorpion_large.png" class="img-responsive"/>
            </g:link>
        </td>--}%
            <script id="mNCC" language="javascript">
                medianet_width = "336";
                medianet_height = "280";
                medianet_crid = "592703599";
                medianet_versionId = "3111299";
            </script>
            <script src="//contextual.media.net/nmedianet.js?cid=8CU54R87O"></script>
    </div>

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="igau.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.IGAU, players: igauplayers]"/>
    </div>
</div>

<div class="row">

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="bbcp.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.BBCP, players: bbcpplayers]"/>
    </div>


    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="usf4.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.USF4, players: usf4players]"/>
    </div>

</div>




<div class="row">

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="umvc3.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.UMVC3, players: umvc3players]"/>
    </div>

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="skullgirls.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.SKULLGIRLS, players: sgplayers]"/>
    </div>
</div>

%{--<center>
    <div class="row top10box" style="margin: auto">
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
</center>--}%
<center>
    <div class="row top10box" style="margin: auto">
        <div class="panel panel-primary">
            <div class="panel-body">
                <div class="col-md-3">
                    <g:link url="https://displate.com/displate/291193?merch=5b5a0ec49ef2b">
                        <g:img dir="images/displate" file="cammy_small.png" class="img-responsive"/>
                    </g:link>
                </div>
                <div class="col-md-3">
                    <g:link url="https://displate.com/displate/284559?merch=5b5a0ec49ef2b">
                        <g:img dir="images/displate" file="chun_small.png" class="img-responsive"/>
                    </g:link>
                </div>
                <div class="col-md-3">
                    <g:link url="https://displate.com/displate/259832?merch=5b5a0ec49ef2b">
                        <g:img dir="images/displate" file="akuma_small.png" class="img-responsive"/>
                    </g:link>

                </div>
                <div class="col-md-3">
                    <g:link url="https://displate.com/displate/149208?merch=5b5a0ec49ef2b">
                        <g:img dir="images/displate" file="sf_mini_small.png" class="img-responsive"/>
                    </g:link>
                </div>
            </div>
        </div>
    </div>
</center>

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