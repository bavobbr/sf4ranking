
<%@ page import="be.bbr.sf4ranking.GameCharacter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'gameCharacter.label', default: 'GameCharacter')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-gameCharacter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-gameCharacter" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list gameCharacter">
			
				<g:if test="${gameCharacterInstance?.characterType}">
				<li class="fieldcontain">
					<span id="characterType-label" class="property-label"><g:message code="gameCharacter.characterType.label" default="Character Type" /></span>
					
						<span class="property-value" aria-labelledby="characterType-label"><g:fieldValue bean="${gameCharacterInstance}" field="characterType"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${gameCharacterInstance?.main}">
				<li class="fieldcontain">
					<span id="main-label" class="property-label"><g:message code="gameCharacter.main.label" default="Main" /></span>
					
						<span class="property-value" aria-labelledby="main-label"><g:formatBoolean boolean="${gameCharacterInstance?.main}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${gameCharacterInstance?.gameTeam}">
				<li class="fieldcontain">
					<span id="gameTeam-label" class="property-label"><g:message code="gameCharacter.gameTeam.label" default="Game Team" /></span>
					
						<span class="property-value" aria-labelledby="gameTeam-label"><g:link controller="gameTeam" action="show" id="${gameCharacterInstance?.gameTeam?.id}">${gameCharacterInstance?.gameTeam?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:gameCharacterInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${gameCharacterInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
