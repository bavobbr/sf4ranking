
<%@ page import="be.bbr.sf4ranking.Result" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'result.label', default: 'Result')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-result" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-result" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list result">
			
				<g:if test="${resultInstance?.player}">
				<li class="fieldcontain">
					<span id="player-label" class="property-label"><g:message code="result.player.label" default="Player" /></span>
					
						<span class="property-value" aria-labelledby="player-label"><g:link controller="player" action="show" id="${resultInstance?.player?.id}">${resultInstance?.player?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${resultInstance?.place}">
				<li class="fieldcontain">
					<span id="place-label" class="property-label"><g:message code="result.place.label" default="Place" /></span>
					
						<span class="property-value" aria-labelledby="place-label"><g:fieldValue bean="${resultInstance}" field="place"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${resultInstance?.tournament}">
				<li class="fieldcontain">
					<span id="tournament-label" class="property-label"><g:message code="result.tournament.label" default="Tournament" /></span>
					
						<span class="property-value" aria-labelledby="tournament-label"><g:link controller="tournament" action="show" id="${resultInstance?.tournament?.id}">${resultInstance?.tournament?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${resultInstance?.characterTeams}">
				<li class="fieldcontain">
					<span id="characterTeams-label" class="property-label"><g:message code="result.characterTeams.label" default="Character Teams" /></span>
					
						<g:each in="${resultInstance.characterTeams}" var="c">
						<span class="property-value" aria-labelledby="characterTeams-label"><g:link controller="gameTeam" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:resultInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${resultInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
