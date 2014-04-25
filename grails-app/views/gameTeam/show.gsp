
<%@ page import="be.bbr.sf4ranking.GameTeam" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'gameTeam.label', default: 'GameTeam')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-gameTeam" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-gameTeam" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list gameTeam">
			
				<g:if test="${gameTeamInstance?.pchars}">
				<li class="fieldcontain">
					<span id="pchars-label" class="property-label"><g:message code="gameTeam.pchars.label" default="Pchars" /></span>
					
						<g:each in="${gameTeamInstance.pchars}" var="p">
						<span class="property-value" aria-labelledby="pchars-label"><g:link controller="gameCharacter" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${gameTeamInstance?.result}">
				<li class="fieldcontain">
					<span id="result-label" class="property-label"><g:message code="gameTeam.result.label" default="Result" /></span>
					
						<span class="property-value" aria-labelledby="result-label"><g:link controller="result" action="show" id="${gameTeamInstance?.result?.id}">${gameTeamInstance?.result?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:gameTeamInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${gameTeamInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
