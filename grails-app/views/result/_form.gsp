<%@ page import="be.bbr.sf4ranking.Result" %>



<div class="fieldcontain ${hasErrors(bean: resultInstance, field: 'player', 'error')} required">
	<label for="player">
		<g:message code="result.player.label" default="Player" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField id="player" name="player.id" value="${resultInstance?.player?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resultInstance, field: 'place', 'error')} required">
	<label for="place">
		<g:message code="result.place.label" default="Place" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="place" type="number" value="${resultInstance.place}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: resultInstance, field: 'tournament', 'error')} required">
	<label for="tournament">
		<g:message code="result.tournament.label" default="Tournament" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField id="tournament" name="tournament.id" value="${resultInstance?.tournament?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: resultInstance, field: 'characterTeams', 'error')} ">
	<label for="characterTeams">
		<g:message code="result.characterTeams.label" default="Character Teams" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${resultInstance?.characterTeams?}" var="c">
    <li><g:link controller="gameTeam" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="gameTeam" action="create" params="['result.id': resultInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'gameTeam.label', default: 'GameTeam')])}</g:link>
</li>
</ul>

</div>

