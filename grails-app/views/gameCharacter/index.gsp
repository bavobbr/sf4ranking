
<%@ page import="be.bbr.sf4ranking.GameCharacter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'gameCharacter.label', default: 'GameCharacter')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-gameCharacter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-gameCharacter" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="characterType" title="${message(code: 'gameCharacter.characterType.label', default: 'Character Type')}" />
					
						<g:sortableColumn property="main" title="${message(code: 'gameCharacter.main.label', default: 'Main')}" />
					
						<th><g:message code="gameCharacter.gameTeam.label" default="Game Team" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${gameCharacterInstanceList}" status="i" var="gameCharacterInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${gameCharacterInstance.id}">${fieldValue(bean: gameCharacterInstance, field: "characterType")}</g:link></td>
					
						<td><g:formatBoolean boolean="${gameCharacterInstance.main}" /></td>
					
						<td>${fieldValue(bean: gameCharacterInstance, field: "gameTeam")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${gameCharacterInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
