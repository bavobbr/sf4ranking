<%@ page import="be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>Hardware and controllers - ${controller.name}</title>
</head>

<body>
<h2>Game Controller ${controller.name}</h2>
<center>
    <div class="row">
        <div class="col-md-6">
            <table class="tablehead" id="datatable">
                <thead><tr></tr></thead>
                <tbody>
                <tr>
                    <td>Name</td>
                    <td>${controller.name}</td>
                </tr>
                <tr>
                    <td>Vendor</td>
                    <td>${controller.website}</td>
                </tr>
                <tr>
                    <td>Details</td>
                    <td>${raw(controller.description)}</td>
                </tr>
                <tr>
                    <td>Known players</td>
                    <td>
                        <g:each in="${controller.players}" var="player">
                            <g:link controller="rankings" action="player"
                                    params="[id: player.id]">${player.name}</g:link>
                        </g:each>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="col-md-6">
            <g:if test="${controller.image}">
                <img src="${controller.image}" class="img-responsive"/>
            </g:if>
        </div>
    </div>
</center>

<h3>Prices of ${controller.name}</h3>

<div class="row">
    <g:if test="${controller.buy}">
        <div class="col-md-3">
            Amazon United States
        </div>
    </g:if>
    <g:if test="${controller.buyUK}">
        <div class="col-md-3">
            Amazon United Kingdom
        </div>
    </g:if>
    <g:if test="${controller.buyFR}">
        <div class="col-md-3">
            Amazon France
        </div>
    </g:if>
    <g:if test="${controller.buyDE}">
        <div class="col-md-3">
            Amazon Germany
        </div>
    </g:if>
</div>

<div class="row">
    <g:if test="${controller.buy}">
        <div class="col-md-3">
            ${raw(controller.buy)}
        </div>
    </g:if>
    <g:if test="${controller.buyUK}">
        <div class="col-md-3">
            ${raw(controller.buyUK)}
        </div>
    </g:if>
    <g:if test="${controller.buyFR}">
        <div class="col-md-3">
            ${raw(controller.buyFR)}
        </div>
    </g:if>
    <g:if test="${controller.buyDE}">
        <div class="col-md-3">
            ${raw(controller.buyDE)}
        </div>
    </g:if>
</div>
<g:render template="/templates/prettify"/>
</center>
</body>
</html>