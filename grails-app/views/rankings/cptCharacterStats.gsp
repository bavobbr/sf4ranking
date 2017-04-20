<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Capcom Pro Tour 2017 Player and Character Stats</title>
</head>

<body>
<h2>Player Statistics in Capcom Pro Tour 2017</h2>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Work in progress</h3>
            </div>

            <div class="panel-body">
                This page is being updated with 2017 ruleset! Release soon
            </div>
        </div>
    </div>

</div>



Statistics drawn from past Capcom Pro Tour tournaments. They reflect the characters we will likely see in the Capcom Cup finals and who plays them, as well as overall statistics on what characters were used to compete in the Capcom Pro Tour.
<h3 class="tournament">Players in qualifying zones</h3>
These players will qualify if tournament started today:
<ul>
<li>Players qualified directly: <i>${qualified.collect { it.name}.join(", ")}</i></li>
    <li>Players qualifying by global score: <i>${qualifiedGlobal.collect { it.name}.join(", ")}</i></li>
    <li>Players qualifying by regional score: <i>${qualifiedRegional.collect { it.name}.join(", ")}</i></li>
</ul>
Players that may still win a direct spot:
<ul>
    <g:each in="${regionalPlayers.keySet()}" var="regional">
        <li>qualified for regional finals ${regional.value}: <i>${regionalPlayers[regional].collect { it.name}.join(", ")}</i></li>
    </g:each>
</ul>
Note that in early stages only 'qualified' players are guaranteed. The others are still fighting for points to qualify.

<h2>Character Statistics in Capcom Pro Tour 2017</h2>

<g:if test="${byMainCharacter32}">
    <h3 class="tournament">Main character usage of current qualifying 32</h3>
    These are the characters that will be played at highest level. Competitors are advised to learn these matchups thoroughly.
    <div class="table-responsive">
        <table class="tablehead" id="datatable2">
            <thead>
            <tr class="stathead">
                <th>Character</th>
                <th>Occurence</th>
                <th>Used by</th>
            </tr>
            </thead>
            <g:each in="${byMainCharacter32}" var="t">
                <tr>
                    <td>${t.key?.value}</td>
                    <td>${t.value.size()}</td>
                    <td>${t.value.collect{ it.name}.join(", ")}</td>
                </tr>
            </g:each>
        </table>
    </div>
    A total of <b>${byMainCharacter32.size()} </b>have been used as main by the current qualifying ${players32.size()} CPT players<br/>
    Characters not used as main are: <b>${notIn.join(", ")}</b>
</g:if>

<g:if test="${secondary32}">
    <h3 class="tournament">All character usages of current qualifying players</h3>
    These are the characters that may be played. Most as main charac ter, some as secondary characters. Secondaries are often used to counter bad matchups.
    <div class="table-responsive">
        <table class="tablehead" id="datatable5">
            <thead>
            <tr class="stathead">
                <th>Character</th>
                <th>Occurence</th>
                <th>Used by</th>
            </tr>
            </thead>
            <g:each in="${secondary32}" var="t">
                <tr>
                    <td>${t.key?.value}</td>
                    <td>${t.value.size()}</td>
                    <td>${t.value.collect{ it.name}.join(", ")}</td>
                </tr>
            </g:each>
        </table>
    </div>
    A total of <b>${byMainCharacter32.size()} </b>have been used as main by the current best ${players32.size()} CPT players. <br/>
    Characters not used at all are: <b>${notInAll.join(", ")}</b>
</g:if>


<g:if test="${players32}">
    <h3 class="tournament">Characters used by current qualifying players</h3>
    This shows how diverse certain players can be. Players with a lot of characters are less prone to bad match-ups.
    <div class="table-responsive">
        <table class="tablehead" id="datatable4">
            <thead>
            <tr class="stathead">
                <th>Player</th>
                <th>Number</th>
                <th>Characters</th>
            </tr>
            </thead>
            <g:each in="${players32}" var="player">
                <tr>
                    <td>${player.name}</td>
                    <td>${player.usedCharacters().size()}</td>
                    <td>${raw(player.usedCharacters().collect { "<b>$it.key.value</b> ($it.value)" }.join(", "))}</td>
                </tr>
            </g:each>
        </table>
    </div>
</g:if>

<g:if test="${charToCount}">
    <h3 class="tournament">Characters in all CPT tournaments by all players</h3>
    This is an overall statistics on the characters used in CPT tournaments.
    <div class="table-responsive">
        <table class="tablehead" id="datatable3">
            <thead>
            <tr class="stathead">
                <th>Character</th>
                <th>Occurence</th>
            </tr>
            </thead>
            <g:each in="${charToCount}" var="t">
                <tr>
                    <td>${t.key?.value}</td>
                    <td>${t.value}</td>
                </tr>
            </g:each>
        </table>
    </div>
    A total of <b>${charToCount.size()} </b>have been used as main or secondary by all Capcom Pro Tour 2016 tournament players.
</g:if>



<g:render template="/templates/prettify"/>

</body>
</html>