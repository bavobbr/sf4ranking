<%@ page import="be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Fighting Games World Rankings</title>
</head>

<body>
<center>
    <h2 class="title">Fighting Games World Rankings</h2><span class="glyphicon glyphicon-flash"></span>
    <h4 class="subtitle">rank.shoryuken.com</h4>
</center>

<g:if test="${updateMessage}">
  <div class="alert alert-info alert-dismissable">
    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    <g:message message="${updateMessage}"/>

  </div>
</g:if>

<div class="row">
  <div class="col-md-6">
    <g:img dir="images/banners" file="usf4.png" class="img-responsive"/>
    <g:render template="/templates/top20" model="[game: Version.USF4, players: usf4players]"/>
  </div>
  <div class="col-md-6">
    <g:img dir="images/banners" file="mkx.jpg" class="img-responsive"/>
    <g:render template="/templates/top20" model="[game: Version.MKX, players: mkxplayers]"/>
  </div>

</div>
<div class="row">
    <div class="col-md-6">
        <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
        <!-- Main page -->
        <ins class="adsbygoogle"
             style="display:inline-block;width:468px;height:15px"
             data-ad-client="ca-pub-3108290198951174"
             data-ad-slot="2151634440"></ins>
        <script>
            (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
    </div>
    <div class="col-md-6">
        <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
        <!-- Main page -->
        <ins class="adsbygoogle"
             style="display:inline-block;width:468px;height:15px"
             data-ad-client="ca-pub-3108290198951174"
             data-ad-slot="2151634440"></ins>
        <script>
            (adsbygoogle = window.adsbygoogle || []).push({});
        </script>
    </div>

</div>

&NonBreakingSpace;
<div class="row">
  <div class="col-md-6">
    <g:img dir="images/banners" file="umvc3.png" class="img-responsive"/>
    <g:render template="/templates/top20" model="[game: Version.UMVC3, players: umvc3players]"/>
  </div>
  <div class="col-md-6">
    <g:img dir="images/banners" file="igau.png" class="img-responsive"/>
    <g:render template="/templates/top20" model="[game: Version.IGAU, players: igauplayers]"/>
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
  <div class="col-md-4">
    <div class="panel panel-primary">
      <div class="panel-heading">
        <h3 class="panel-title">Latest Tournaments</h3>
      </div>

      <div class="panel-body">
        <ul>
          <g:each in="${lastTournaments}" var="t">
            <li><g:link controller="rankings" action="tournament" params="[id: t.id]">${t.name}</g:link></li>
          </g:each>
      </div>
    </div>
  </div>

  <div class="col-md-4">
      <center>
      <a rel="nofollow" href="http://www.amazon.com/gp/product/B00QXJFE08/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B00QXJFE08&linkCode=as2&tag=fgwora-20&linkId=GIQ7YOZUFMJY33SI"><img border="0" src="http://ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B00QXJFE08&Format=_SL250_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=fgwora-20" ></a><img src="http://ir-na.amazon-adsystem.com/e/ir?t=fgwora-20&l=as2&o=1&a=B00QXJFE08" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
      </center>
  </div>

    <div class="col-md-4">
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