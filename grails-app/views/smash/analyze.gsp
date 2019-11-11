<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial">
    <title>Smash Tournament Analysis ${tournament?.tournament}</title>
</head>

<body>


<g:if test="${flash.message}">
    <div class="alert alert-warning">${flash.message}</div>
</g:if>

Discovered ${numRegistrations} registrations by ${numPlayers} players in ${numGames} games!
<br>
Note: this is still in beta. More features and robustness will be added.

<h2>Suggested seedings based on SRK data</h2>
<div class="table-responsive">
    <table class="tablehead" id="datatable">
        <thead>
        <tr class="stathead">
            <td>seed</td>
            <td>player</td>
            <td>smashId</td>
            <td>name</td>
            <td>country</td>
            <td>weight</td>
            <td>rank</td>
            <g:if test="${game == be.bbr.sf4ranking.Version.SF5}">
            <td>cpt</td>
            </g:if>
            <td>score</td>
            <td>alltime</td>
            <td>trend</td>
        </tr>
        </thead>
        <tbody>
        <g:each in="${seeds}" var="seed" status="idx">
            <tr>
                <td>${idx + 1}</td>
                <td><g:link mapping="playerByName" controller="rankings" action="player"
                            params="[name: seed.name]">${seed.name}</g:link>
                </td>
                <td>${seed.smashId}</td>
                <td>${seed.realname}</td>
                <td>${seed.countryCode?.name}</td>
                <td>${seed.skill(game)}</td>
                <td>${seed.rank(game)}</td>
            <g:if test="${game == be.bbr.sf4ranking.Version.SF5}">
                <td>${seed.cptGlobal()?.rank}</td>
            </g:if>
                <td>${seed.score(game)}</td>
                <td>${seed.totalScore(game)}</td>
                <td>${seed.trendingScore(game)}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>


<script type="text/javascript" charset="utf-8">
    $(document).ready(function () {
        $('table[id^="datatable"]').each(function (index) {
            $(this).tablecloth({
                theme: "default",
                striped: true,
                sortable: true,
                condensed: true
            });
            //$(this).tablesorter({sortList: [[1,1]]})
        })
    });
</script>
</body>
</html>