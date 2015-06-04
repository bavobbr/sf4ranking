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
  <div class="col-md-6">
    <div class="panel panel-primary">
      <div class="panel-heading">
        <h3 class="panel-title">Last added tournaments</h3>
      </div>

      <div class="panel-body">
        <ul>
          <g:each in="${lastTournaments}" var="t">
            <li><g:link controller="rankings" action="tournament" params="[id: t.id]">${t.name}</g:link></li>
          </g:each>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="panel panel-primary">
      <div class="panel-heading">
        <h3 class="panel-title">Last added players</h3>
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