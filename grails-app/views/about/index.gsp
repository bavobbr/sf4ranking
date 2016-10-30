<%@ page import="be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Fighting Games World Ranking - FAQ</title>
</head>

<body>

<h2>How does it work?</h2>

<div class="jumbotron">
  <h2>Summary</h2>
  <p>
    The rankings given to players is analog to <a
          href="http://www.atpworldtour.com/">ATP and WTA</a>. Players earn points by placing in tournaments.
  Tournaments are ordered by importance and given a classification. The players in those tournaments are then assigned a score based on their place within a tournament, adjusted with the tournament weight.<br/>
  </p><p>
    The goals is to rank the tournament performance of players in popular fighting games like SF5, Street Fighter 4 (vanilla, super, arcade edition, AE2012 and Ultra), Marvel vs Capcom 3, Killer Instinct, Mortal Kombat X, Injustice, Blazblue and Skullgirls.
</p>
</div>


<h3>How data is entered</h3>
Tournaments results are imported in top 8, top 16, top 32 or top 64 format if available. The name, date and location of that tournament is stored and players are registered if they were not in the database before. Along with the result the characters used by that player are stored into the database.
<h3>How tournaments are weighted</h3>
Every player that is entered into the database has an initial <i>skill weight</i> value. A tournament weight then becomes the average of the skill values of the 8 most skilled players in the tournament.
<h3>How tournaments are classified</h3>
The tournament ranking is done by sorting on tournament weight and then ditributing them into the tournament types used by <a
        href="http://en.wikipedia.org/wiki/Women%27s_Tennis_Association">WTA</a>
<br/>The score distribution for tournaments in bracket format is:

<div class="table-responsive">
  <table class="table table-striped table-hover table-condensed">
    <thead>
    <tr>
      <td>Type</td>
      <td>1st</td>
      <td>2nd</td>
      <td>3rd</td>
      <td>4th</td>
      <td>5th</td>
      <td>6th</td>
      <td>7th</td>
      <td>8th</td>
      <td>9th</td>
      <td>10th</td>
      <td>11th</td>
      <td>12th</td>
      <td>13th</td>
      <td>14th</td>
      <td>15th</td>
      <td>16th</td>
    </tr>
    </thead>
    <tbody>
    <g:each in="${[TournamentType.GRAND_SLAM, TournamentType.PREMIER_MANDATORY, TournamentType.PREMIER_5, TournamentType.PREMIER_12, TournamentType.INTERNATIONAL, TournamentType.SERIES, TournamentType.CIRCUIT, TournamentType.LOCAL]}" var="type">
      <tr>
        <td>${type.value}</td>
        <td>${ScoringSystem.getScore(1, type)}</td>
        <td>${ScoringSystem.getScore(2, type)}</td>
        <td>${ScoringSystem.getScore(3, type)}</td>
        <td>${ScoringSystem.getScore(4, type)}</td>
        <td>${ScoringSystem.getScore(5, type)}</td>
        <td>${ScoringSystem.getScore(6, type)}</td>
        <td>${ScoringSystem.getScore(7, type)}</td>
        <td>${ScoringSystem.getScore(8, type)}</td>
        <td>${ScoringSystem.getScore(9, type)}</td>
        <td>${ScoringSystem.getScore(10, type)}</td>
        <td>${ScoringSystem.getScore(11, type)}</td>
        <td>${ScoringSystem.getScore(12, type)}</td>
        <td>${ScoringSystem.getScore(13, type)}</td>
        <td>${ScoringSystem.getScore(14, type)}</td>
        <td>${ScoringSystem.getScore(15, type)}</td>
        <td>${ScoringSystem.getScore(16, type)}</td>
      </tr>
    </g:each>
    </tbody>
  </table>
</div>
<i>This degrades down further to top64</i><br/>
Tournaments in <strong>league</strong> format that are not auto-weighted score as:

<div class="table-responsive">
  <table class="table table-striped table-hover table-condensed">
    <thead>
    <tr>
      <td>Type</td>
      <td>Amount</td>
      <td>1st</td>
      <td>2nd</td>
      <td>3rd</td>
      <td>4th</td>
      <td>5th</td>
      <td>6th</td>
      <td>7th</td>
      <td>8th</td>
      <td>9th</td>
      <td>10th</td>
      <td>11th</td>
      <td>12th</td>
      <td>13th</td>
      <td>14th</td>
      <td>15th</td>
      <td>16th</td>
    </tr>
    </thead>
    <tbody>
    <g:each in="${[TournamentType.CHAMPIONSHIP, TournamentType.TOURNAMENT_CHAMPIONS]}" var="type">
      <tr>
        <td>${type.value}</td>
        <td>1</td>
        <td>${ScoringSystem.getScore(1, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(2, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(3, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(4, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(5, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(6, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(7, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(8, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(9, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(10, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(11, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(12, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(13, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(14, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(15, type, TournamentFormat.LEAGUE)}</td>
        <td>${ScoringSystem.getScore(16, type, TournamentFormat.LEAGUE)}</td>
      </tr>
    </g:each>
    </tbody>
  </table>
</div>
A tournament can be a <strong>fixed</strong> type (the <i>Grand Slam</i>, <i>Championship</i> and <i>Tournament of Champions</i> types) or auto-weighted. As a standard auto-weighting is used (based on player skills entering), but fixed types ccan be used for events that are considered Grand Slam unanimously (EVO class) or events that are very frequent and have a very local nature (like weeklies). The latter are classified as FIXED type on LOCAL.
For auto-weighted tournament types the following order is used:
<div class="table-responsive">

<table class="table table-condensed">
  <thead>
  <tr>
    <td>Type</td>
    <td>Amount</td>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td>Premier Mandatory</td>
    <td>5</td>
  </tr>
  <tr>
    <td>Premier 5</td>
    <td>5</td>
  </tr>
  <tr>
    <td>Premier 12</td>
    <td>12</td>
  </tr>
  <tr>
    <td>International</td>
    <td>20</td>
  </tr>
  <tr>
    <td>Series</td>
    <td>50</td>
  </tr>
  <tr>
    <td>Circuit</td>
    <td>the rest</td>
  </tr>
  </tbody>
</table>
</div>
These are distributed over tournaments of the last two years according to tournament weight, which is the sum of the best 8 players that entered the top 64. Tournament organizers take note: providing result lists above top 8 results in better ranking results.
Championship and Tournament of Champions is reserved for leagues, with <i>Championship</i> being top-level and <i>Tournament of Champions</i> being lower-level. <i>Grand Slam</i> is assigned to large open international events that had qualifiers or seedings upfront.
This forms the basis of the actual score, which considers tournaments of the last 2 years in a sliding window. Next to that a player also gets a total score for every game. The total score is the sum of tournament scores times tournament weight. So the tournament weight is simply used as a modifier. All tournaments of the game are counted in the total score.

<h3>Ranking system</h3>
<g:img dir="images" file="rank_flow.png" class="charimg"/>

<h3>How much data is being tracked?</h3>
A total of ${players} players seen in ${tournaments} tournaments producing ${results} tournament rankings from ${first?.format("MM-yyyy")} until ${last?.format("MM-yyyy")}.

<h3>Moderators</h3>
Data input and correctness is maintained by
<ul>
  <li><a href="https://twitter.com/bavobbr">Bavo Bruylandt</a> (site admin)</li>
  <li><a href="https://twitter.com/tomakh">Tomakh</a> (moderator)</li>
  <li><a href="https://twitter.com/TerranceElC">TLC</a> (moderator)</li>
</ul>
... and everyone who is submitting new data on the site and providing input via Twitter!

<h3>What about other games</h3>
There is a moderator feature to allow the community to add data for new games. When a game is added some code need to be adapted (eg character types need to be defined, new hyperlinks will be added) and images need to be cut (to display the characters etc). Afterwards it is a matter of finding results and inputting them in a consistent way that does not cause duplicates. Any help is appreciated.


<h3>How can I provide feedbacks/comments?</h3>
Please join the <a href="http://forums.shoryuken.com/discussion/187561/sf4-ae-world-ranking-site-has-been-beta-released">official thread on the SRK forums</a>, where a full discussion of this site is available.
You can also tweet to <a href="https://twitter.com/srkranking">@SRKRanking</a> for fast feedback.

<h3>What technology is being used?</h3>
Glad you ask! This is a <a
        href="http://grails.org/">Grails</a> application, using GORM on MySQL for persistence, Grails services and controller for business logic and GSP for data rendering. The GSP pages are HTML5 using <a
        href="http://getbootstrap.com/">Bootstrap</a> for layout and JQuery for Javascript magic. The search engine uses Compass/Lucene. Backups are made in JSON and security is covered with Apache Shiro. All this is deployed on CloudBees on a Tomcat server. I love it.
<h3>Where did you get the cool character sprites?</h3>
These are kindly contributed by <a href="https://twitter.com/SpeedBrkr">SpeedBrkr</a> and <a href="http://www.shunao.org/">Lyn/Shunao</a>.

<h3>Credits</h3>
  I would like to thank explicitly the following sources that, one way or another, were an influence to this site: Kyosuke of <a href="http://www.ssfranking.com/" target="_blank">ssfranking</a> (Arcade battle data), <a href="http://www.kuroppi.com/tournamentresults/" target="_blank">Kuroppi</a> (historical tournament results), the staff at <a href="http://shoryuken.com/" target="_blank">Shoryuken</a> for up-to-date tournament reporting, the <a href="http://forums.shoryuken.com/discussion/comment/8850159#Comment_8850159" target="_blank">SRK forums</a> community for fixes and suggestions, George at <a href="http://freedamage.com/" target="_blank">freedamage.com</a> (for ideas and cropped images), <a href="https://twitter.com/SpeedBrkr" target="_blank">SpeedBrkr</a> (8-bit SFIV images), <a href="https://twitter.com/_shunao" target="_blank">Lyn</a> (MvC3 images), <a href="http://www.tokidoblog.com/" target="_blank">Tokidoblog</a> (Asian coverage), and countless people on Twitter for suggestions.
Thanks to Capcom and <a href="https://twitter.com/CapcomFighters">CapcomFighters</a> for organizing the Capcom Cup Pro Tour event. The official ranking can be found at <a href="http://capcomprotour.com/">capcomprotour.com</a>.
<hr />

</body>
</html>