<%@ page import="be.bbr.sf4ranking.GameTeam" %>



<div class="fieldcontain ${hasErrors(bean: gameTeamInstance, field: 'pchars', 'error')} ">
	<label for="pchars">
		<g:message code="gameTeam.pchars.label" default="Pchars" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${gameTeamInstance?.pchars?}" var="p">
    <li><g:link controller="gameCharacter" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="gameCharacter" action="create" params="['gameTeam.id': gameTeamInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'gameCharacter.label', default: 'GameCharacter')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: gameTeamInstance, field: 'result', 'error')} required">
	<label for="result">
		<g:message code="gameTeam.result.label" default="Result" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField id="result" name="result.id" value="${gameTeamInstance?.result?.id}"/>
    ${gameTeamInstance?.result?.id}
</div>

