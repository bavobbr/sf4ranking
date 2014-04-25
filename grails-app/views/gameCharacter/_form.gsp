<%@ page import="be.bbr.sf4ranking.GameCharacter" %>



<div class="fieldcontain ${hasErrors(bean: gameCharacterInstance, field: 'characterType', 'error')} required">
	<label for="characterType">
		<g:message code="gameCharacter.characterType.label" default="Character Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="characterType" from="${be.bbr.sf4ranking.CharacterType?.values()}" keys="${be.bbr.sf4ranking.CharacterType.values()*.name()}" required="" value="${gameCharacterInstance?.characterType?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: gameCharacterInstance, field: 'main', 'error')} ">
	<label for="main">
		<g:message code="gameCharacter.main.label" default="Main" />
		
	</label>
	<g:checkBox name="main" value="${gameCharacterInstance?.main}" />
</div>

<div class="fieldcontain ${hasErrors(bean: gameCharacterInstance, field: 'gameTeam', 'error')} required">
	<label for="gameTeam">
		<g:message code="gameCharacter.gameTeam.label" default="Game Team" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField id="gameTeam" name="gameTeam.id" value="${gameCharacterInstance?.gameTeam?.id}"/>
</div>

