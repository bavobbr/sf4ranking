<%@ page import="be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
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
    <g:img dir="images/banners" file="ae2012.png" class="img-responsive"/>
    <g:render template="/templates/top20" model="[game: Version.AE2012, players: players]"/>
  </div>
  <div class="col-md-6">
    <g:img dir="images/banners" file="killerinstinct.png" class="img-responsive"/>
    <g:render template="/templates/top20" model="[game: Version.KI, players: kiplayers]"/>
  </div>

</div>
&NonBreakingSpace;
<div class="row">
%{--  <div class="col-md-6">
    <g:img dir="images/banners" file="umvc3.png" class="img-responsive"/>
    <g:render template="/templates/top20" model="[game: Version.UMVC3, players: umvc3players]"/>
  </div>
  <div class="col-md-6">
    <g:img dir="images/banners" file="skullgirls.png" class="img-responsive"/>
    <g:render template="/templates/top20" model="[game: Version.SKULLGIRLS, players: sgplayers]"/>
  </div>--}%
</div>
</body>
</html>