<table cellspacing='0'>
    <thead>
    <tr>
        <th>${game}</th>
        <th>Rank</th>
        <th>Country</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${players}" var="p" status="index">
        <tr class= ${index % 2 == 0 ? 'even' : 'odd'}>
            <td><a href="http://rank.shoryuken.com/rankings/player/byname/${p.name}">${p.name}</a></td>
            <td>${p.rank}</td>
            <td><img src="http://rank.shoryuken.com/static/images/countries/${p.country}.png"></td>
        </tr>
    </g:each>
    </tbody>
</table>
