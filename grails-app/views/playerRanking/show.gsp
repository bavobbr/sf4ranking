
<%@ page import="be.bbr.sf4ranking.PlayerRanking" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'playerRanking.label', default: 'PlayerRanking')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-playerRanking" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-playerRanking" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list playerRanking">
			
				<g:if test="${playerRankingInstance?.game}">
				<li class="fieldcontain">
					<span id="game-label" class="property-label"><g:message code="playerRanking.game.label" default="Game" /></span>
					
						<span class="property-value" aria-labelledby="game-label"><g:fieldValue bean="${playerRankingInstance}" field="game"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerRankingInstance?.score}">
				<li class="fieldcontain">
					<span id="score-label" class="property-label"><g:message code="playerRanking.score.label" default="Score" /></span>
					
						<span class="property-value" aria-labelledby="score-label"><g:fieldValue bean="${playerRankingInstance}" field="score"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerRankingInstance?.totalScore}">
				<li class="fieldcontain">
					<span id="totalScore-label" class="property-label"><g:message code="playerRanking.totalScore.label" default="Total Score" /></span>
					
						<span class="property-value" aria-labelledby="totalScore-label"><g:fieldValue bean="${playerRankingInstance}" field="totalScore"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerRankingInstance?.rank}">
				<li class="fieldcontain">
					<span id="rank-label" class="property-label"><g:message code="playerRanking.rank.label" default="Rank" /></span>
					
						<span class="property-value" aria-labelledby="rank-label"><g:fieldValue bean="${playerRankingInstance}" field="rank"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerRankingInstance?.skill}">
				<li class="fieldcontain">
					<span id="skill-label" class="property-label"><g:message code="playerRanking.skill.label" default="Skill" /></span>
					
						<span class="property-value" aria-labelledby="skill-label"><g:fieldValue bean="${playerRankingInstance}" field="skill"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerRankingInstance?.mainCharacters}">
				<li class="fieldcontain">
					<span id="mainCharacters-label" class="property-label"><g:message code="playerRanking.mainCharacters.label" default="Main Characters" /></span>
					
						<span class="property-value" aria-labelledby="mainCharacters-label"><g:fieldValue bean="${playerRankingInstance}" field="mainCharacters"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerRankingInstance?.oldRank}">
				<li class="fieldcontain">
					<span id="oldRank-label" class="property-label"><g:message code="playerRanking.oldRank.label" default="Old Rank" /></span>
					
						<span class="property-value" aria-labelledby="oldRank-label"><g:fieldValue bean="${playerRankingInstance}" field="oldRank"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerRankingInstance?.oldScore}">
				<li class="fieldcontain">
					<span id="oldScore-label" class="property-label"><g:message code="playerRanking.oldScore.label" default="Old Score" /></span>
					
						<span class="property-value" aria-labelledby="oldScore-label"><g:fieldValue bean="${playerRankingInstance}" field="oldScore"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerRankingInstance?.snapshot}">
				<li class="fieldcontain">
					<span id="snapshot-label" class="property-label"><g:message code="playerRanking.snapshot.label" default="Snapshot" /></span>
					
						<span class="property-value" aria-labelledby="snapshot-label"><g:formatDate date="${playerRankingInstance?.snapshot}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${playerRankingInstance?.player}">
				<li class="fieldcontain">
					<span id="player-label" class="property-label"><g:message code="playerRanking.player.label" default="Player" /></span>
					
						<span class="property-value" aria-labelledby="player-label"><g:link controller="player" action="show" id="${playerRankingInstance?.player?.id}">${playerRankingInstance?.player?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:playerRankingInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${playerRankingInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
