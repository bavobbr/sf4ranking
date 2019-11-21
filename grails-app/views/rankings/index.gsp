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
                            <g:img dir="images/chars/${Version.generalize(Version.SF5).name().toLowerCase()}"
                                   file="${c.characterType?.name()?.toLowerCase() + '.png'}" width="22" height="25"
                                   alt="${c.characterType?.value}"
                                   class="charimg"/>
                            ${c.characterType?.value}
                        </g:link>
                        </td>
                        <td>
                            ${c.trendingScoreAccumulated}
                        </td>
                        <td>
                            ${c.trendingPlayer?.name}
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
        <g:img dir="images/banners" file="tekken7.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.T7, players: t7players]"/>
    </div>

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="tekken7.png" class="img-responsive"/>
        <h4>T7 Top 10 trending characters</h4>

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
                <g:each in="${topt7chars}" var="c" status="idx">
                    <tr class="top10table">
                        <td>${idx + 1}</td>
                        <td><g:link controller="stats" action="character"
                                    params="[charname: c.characterType.name(), game: Version.T7.name()]">
                            <g:img dir="images/chars/${Version.generalize(Version.T7).name().toLowerCase()}"
                                   file="${c.characterType?.name()?.toLowerCase() + '.png'}" width="22" height="25"
                                   alt="${c.characterType?.value}"
                                   class="charimg"/>
                            ${c.characterType?.value}
                        </g:link>
                        </td>
                        <td>
                            ${c.trendingScoreAccumulated}
                        </td>
                        <td>
                            ${c.trendingPlayer?.name}
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

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="ggxrd.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.GGXRD, players: ggplayers]"/>
    </div>

</div>

<div class="row">


    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="mk11.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.MK11, players: mk11players]"/>
    </div>

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="mvci.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.MVCI, players: mvciplayers]"/>
    </div>

</div>


<div class="row">

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="injustice2.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.INJUSTICE2, players: inj2players]"/>
    </div>

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="killerinstinct.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.KI, players: kiplayers]"/>
    </div>

</div>

<div class="row">

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="bbcp.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.BBTAG, players: bbtagplayers]"/>
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

<div class="row">

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="mkx.jpg" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.MKX, players: mkxplayers]"/>
    </div>

    <div class="col-md-6 top10box">
        <g:img dir="images/banners" file="ae2012.png" class="img-responsive"/>
        <g:render template="/templates/top20" model="[game: Version.AE2012, players: aeplayers]"/>
    </div>
</div>



<div class="row">
    <div class="col-md-12">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Latest Tournaments</h3>
            </div>

            <div class="panel-body">
                <ul>
                    <g:each in="${lastTournaments}" var="t">
                        <li><g:link controller="rankings" action="tournament"
                                    params="[id: t.id]">${t.name} in ${t.countryCode?.name} region ${t.region?.value}</g:link></li>
                    </g:each>
            </div>
        </div>
    </div>

</div>
</body>
</html>