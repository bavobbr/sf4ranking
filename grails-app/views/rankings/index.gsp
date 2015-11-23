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
    <div class="panel panel-default">
        <a href="http://www.jdoqocy.com/click-7926414-12359324-1443739020000" target="_top">
            <img src="http://www.lduhtrp.net/image-7926414-12359324-1443739020000" width="300" height="250" alt="Mad Catz Xbox One FightStick" border="0"/></a>
    </div>
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