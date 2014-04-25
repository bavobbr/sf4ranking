
<%@ page import="be.bbr.sf4ranking.PlayerRanking" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'playerRanking.label', default: 'PlayerRanking')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-playerRanking" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-playerRanking" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="game" title="${message(code: 'playerRanking.game.label', default: 'Game')}" />
					
						<g:sortableColumn property="score" title="${message(code: 'playerRanking.score.label', default: 'Score')}" />
					
						<g:sortableColumn property="totalScore" title="${message(code: 'playerRanking.totalScore.label', default: 'Total Score')}" />
					
						<g:sortableColumn property="rank" title="${message(code: 'playerRanking.rank.label', default: 'Rank')}" />
					
						<g:sortableColumn property="skill" title="${message(code: 'playerRanking.skill.label', default: 'Skill')}" />
					
						<g:sortableColumn property="oldRank" title="${message(code: 'playerRanking.oldRank.label', default: 'Old Rank')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${playerRankingInstanceList}" status="i" var="playerRankingInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${playerRankingInstance.id}">${fieldValue(bean: playerRankingInstance, field: "game")}</g:link></td>
					
						<td>${fieldValue(bean: playerRankingInstance, field: "score")}</td>
					
						<td>${fieldValue(bean: playerRankingInstance, field: "totalScore")}</td>
					
						<td>${fieldValue(bean: playerRankingInstance, field: "rank")}</td>
					
						<td>${fieldValue(bean: playerRankingInstance, field: "skill")}</td>
					
						<td>${fieldValue(bean: playerRankingInstance, field: "oldRank")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${playerRankingInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
