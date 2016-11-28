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
                        amzn_assoc_search_bar = "false";
                        amzn_assoc_tracking_id = "fgwora-20";
                        amzn_assoc_ad_mode = "manual";
                        amzn_assoc_ad_type = "smart";
                        amzn_assoc_marketplace = "amazon";
                        amzn_assoc_region = "US";
                        amzn_assoc_title = "";
                        amzn_assoc_size = "550x350";
                        amzn_assoc_linkid = "4c46233c4e6948e48d28f85976393dbc";
                        amzn_assoc_asins = "B00DQLXE30,B00NKX9OSI,B00SKGV3OI,B00NKX9ONS";
                    </script>
                    <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US"></script>
                </td>
            </tr>
        </table>
    </div>

</div>

&NonBreakingSpace;
<div class="row">
    <div class="col-md-6">
        <g:img dir="images/banners" file="umvc3.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.UMVC3, players: umvc3players]"/>
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
        <g:img dir="images/banners" file="skullgirls.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.SKULLGIRLS, players: sgplayers]"/>
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
    <div class="col-md-12">
        <script type="text/javascript">
            amzn_assoc_placement = "adunit0";
            amzn_assoc_search_bar = "false";
            amzn_assoc_tracking_id = "fgwora-20";
            amzn_assoc_ad_mode = "manual";
            amzn_assoc_ad_type = "smart";
            amzn_assoc_marketplace = "amazon";
            amzn_assoc_region = "US";
            amzn_assoc_title = "Christmas sweaters";
            amzn_assoc_linkid = "6030d62ec82b660eaa686b9d498d0446";
            amzn_assoc_asins = "B016BM3CGO,B016BKQENY,B016C3Y3YC,B016BI9AE6,B016BPNIIS";
        </script>
        <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US"></script>
    </div>
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
                        <li><g:link controller="rankings" action="player" params="[id: p.id]">${p.name}</g:link></li>
                    </g:each>
            </div>
        </div>
    </div>
</div>
</body>
</html>