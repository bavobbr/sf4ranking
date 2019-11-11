<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial">
    <title>Smash Tournament Seeding Tool</title>
</head>



<body>

You can ask for any public smash.gg tournament what the top players are for an event.<br/>
You need to provide the tournament name as used in the smash.gg URL address and the event as used in the smash.gg events overview.
To match the players against SRK weights you slect also the game of SRK to compare this with.
<br/>
So for example: <a href="https://smash.gg/tournament/final-round-2019-1/">'final-round-2019-1'</a> with event <a href="https://smash.gg/tournament/final-round-2019-1/events/street-fighter-v-arcade-edition/overview">'street fighter'</a>, compared to SF5 in SRK.
<br/>

If some top players do not have a matching smash ID in the SRK database they will not be detected. If needed, you can map them yourself by providing mappings from SRK player name to smash id.

<h2>Examples</h2>
Example URL: <a href="http://rank.shoryuken.com/smash/analyze?tournament=the-mixup-2019&event=Tekken&game=T7">http://rank.shoryuken.com/smash/analyze?tournament=the-mixup-2019&event=Tekken&game=T7</a>.
<br/>The API is also accessible as JSON by adding format:
<a href="http://rank.shoryuken.com/smash/analyze?tournament=the-mixup-2019&event=Tekken&game=T7&format=json">http://rank.shoryuken.com/smash/analyze?tournament=the-mixup-2019&event=Tekken&game=T7&format=json</a>.

<h2>Seedings Form</h2>

<g:form action="analyze" controller="smash" name="myform" role="form">
    <div class="form-group">
        <label for="tournament">(*) Smash Tournament Name (eg Evolution 2019)</label>
        <g:textField name="tournament" class="form-control" placeholder="smash tournament name"/>
    </div>

    <div class="form-group">
        <label for="event">(*) Smash Event name (eg: Tekken)</label>
        <g:textField name="event" class="form-control" placeholder="smash event name"/>
    </div>

    <div class="form-group">
        <label for="event">(*) [Optional] Custom smash ID mappings (eg: Tokido,148527)</label>
        <g:textArea name="mappings" class="form-control" placeholder="player,smashid"/>
    </div>

    <div class="form-group">
        <label for="game">(*) SRK Tournament Game (to find seeds)</label>
        <g:select name="game" from="${be.bbr.sf4ranking.Version.values()}" class="form-control"/>
    </div>

    <div class="form-group">
        <button type="submit" class="btn btn-primary">Analyze</button>
    </div>

</g:form>



</body>
</html>