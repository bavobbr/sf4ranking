<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial">
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
                    <td>Short Name</td>
                    <td>${controller.shortname}</td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td>${controller.name}</td>
                </tr>
                <tr>
                    <td>Vendor</td>
                    <td>${controller.website}</td>
                </tr>
                <tr>
                    <td>Shop</td>
                    <td>
                        <a href="${controller.directLink}" target="_blank">Buy at Amazon</a>
                    </td>
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
These Amazon stores offer ${controller.shortname} directly. Click on the image to go to Amazon for more info and related products.
<p>
<div class="row">
    <g:if test="${controller.buy}">
        <div class="col-md-2">
            Amazon United States
        </div>
    </g:if>
    <g:if test="${controller.buyUK}">
        <div class="col-md-2">
            Amazon United Kingdom
        </div>
    </g:if>
    <g:if test="${controller.buyFR}">
        <div class="col-md-2">
            Amazon France
        </div>
    </g:if>
    <g:if test="${controller.buyDE}">
        <div class="col-md-2">
            Amazon Germany
        </div>
    </g:if>
</div>

<div class="row">
    <g:if test="${controller.buy}">
        <div class="col-md-2">
            ${raw(controller.buy)}
        </div>
    </g:if>
    <g:if test="${controller.buyUK}">
        <div class="col-md-2">
            ${raw(controller.buyUK)}
        </div>
    </g:if>
    <g:if test="${controller.buyFR}">
        <div class="col-md-2">
            ${raw(controller.buyFR)}
        </div>
    </g:if>
    <g:if test="${controller.buyDE}">
        <div class="col-md-2">
            ${raw(controller.buyDE)}
        </div>
    </g:if>
</div>
</p>


<g:if test="${org.apache.shiro.SecurityUtils.subject.isPermitted("admin")}">
    <g:link controller="hardware" action="edit"
            params="['id': controller.id]">[Update hardware as admin]</g:link>
</g:if>

</center>
</body>
</html>