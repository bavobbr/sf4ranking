<%--
  Created by IntelliJ IDEA.
  User: bbr
  Date: 1/16/14
  Time: 1:51 PM
--%>

<%@ page import="org.apache.shiro.SecurityUtils" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews">
    <title>Tournaments placed for review</title>
</head>

<body>

<h2>Tournaments submitted for review</h2>
<g:if test="${flash.message}">
    <div class="alert alert-warning">${flash.message}</div>
</g:if>


<div class="table-responsive">
    <table class="table table-striped table-hover tdetails">
        <thead>
        <tr>
            <td>Name</td>
            <td>Game</td>
            <td>Country</td>
            <td>Date</td>
            <td>Creator</td>
            <td>Details</td>
            <g:if test="${org.apache.shiro.SecurityUtils.subject.isPermitted("tournament")}">
                <td>Import</td>
                <td>Clear</td>
            </g:if>
        </tr>
        </thead>
        <tbody>
        <g:each in="${toReview}" var="review">
            <tr>
                <td>${review.name}</td>
                <td>${review.game}</td>
                <td>${review.countryCode}</td>
                <td>${review.date}</td>
                <td>${review.creator}</td>
                <td><g:link action="showreview" params="[id:review.id]">${review.id}</g:link></td>
                <g:if test="${org.apache.shiro.SecurityUtils.subject.isPermitted("tournament")}">
                    <td><g:link controller="admin" action="review" params="[id: review.id]">Import</g:link></td>
                    <td><g:link controller="admin" action="clear" params="[id: review.id]">Reviewed</g:link></td>
                </g:if>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<h2>Tournaments reviewed</h2>

<div class="table-responsive">
    <table class="table table-striped table-hover tdetails">
        <thead>
        <tr>
            <td>Name</td>
            <td>Country</td>
            <td>Date</td>
            <td>Creator</td>
            <td>Details</td>
        </tr>
        </thead>
        <tbody>
        <g:each in="${reviewed}" var="review">
            <tr>
                <td>${review.name}</td>
                <td>${review.countryCode}</td>
                <td>${review.date}</td>
                <td>${review.creator}</td>
                <td><g:link action="showreview" params="[id:review.id]">${review.id}</g:link></td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

</body>

</html>