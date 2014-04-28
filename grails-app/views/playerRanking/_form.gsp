<%@ page import="be.bbr.sf4ranking.PlayerRanking" %>



<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'game', 'error')} required">
	<label for="game">
		<g:message code="playerRanking.game.label" default="Game" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField name="game" from="${be.bbr.sf4ranking.Version?.values()}" keys="${be.bbr.sf4ranking.Version.values()*.name()}" required="" value="${playerRankingInstance?.game?.name()}"/>
    ${playerRankingInstance?.game?.name()}
</div>

<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'score', 'error')} required">
	<label for="score">
		<g:message code="playerRanking.score.label" default="Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField name="score" type="number" value="${playerRankingInstance.score}" required=""/>
    ${playerRankingInstance.score}
</div>

<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'totalScore', 'error')} required">
	<label for="totalScore">
		<g:message code="playerRanking.totalScore.label" default="Total Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField name="totalScore" type="number" value="${playerRankingInstance.totalScore}" required=""/>
    ${playerRankingInstance.totalScore}
</div>

<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'rank', 'error')} required">
	<label for="rank">
		<g:message code="playerRanking.rank.label" default="Rank" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField name="rank" type="number" value="${playerRankingInstance.rank}" required=""/>
    ${playerRankingInstance.rank}
</div>

<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'skill', 'error')} required">
	<label for="skill">
		<g:message code="playerRanking.skill.label" default="Skill" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="skill" from="${0..10}" class="range" required="" value="${fieldValue(bean: playerRankingInstance, field: 'skill')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'mainCharacters', 'error')} required">
	<label for="mainCharacters">
		<g:message code="playerRanking.mainCharacters.label" default="Main Characters" />
		<span class="required-indicator">*</span>
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'oldRank', 'error')} ">
	<label for="oldRank">
		<g:message code="playerRanking.oldRank.label" default="Old Rank" />
		
	</label>
	<g:field name="oldRank" type="number" value="${playerRankingInstance.oldRank}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'oldScore', 'error')} ">
	<label for="oldScore">
		<g:message code="playerRanking.oldScore.label" default="Old Score" />
		
	</label>
	<g:field name="oldScore" type="number" value="${playerRankingInstance.oldScore}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'snapshot', 'error')} ">
	<label for="snapshot">
		<g:message code="playerRanking.snapshot.label" default="Snapshot" />
		
	</label>
	<g:datePicker name="snapshot" precision="day"  value="${playerRankingInstance?.snapshot}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: playerRankingInstance, field: 'player', 'error')} required">
	<label for="player">
		<g:message code="playerRanking.player.label" default="Player" />
		<span class="required-indicator">*</span>
	</label>
	<g:hiddenField id="player" name="player.id" value="${playerRankingInstance?.player?.id}"/>
    ${playerRankingInstance?.player?.name}
</div>

