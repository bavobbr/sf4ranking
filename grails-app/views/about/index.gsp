<%@ page import="be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <title>Fighting Games World Ranking -FAQ</title>
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
    The goals is to rank the tournament performance of players in popular fighting games like Street Fighter 4 (vanilla, super, arcade edition amd AE2012), Marvel vs Capcom 3, Killer Instinct and Skullgirls.
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
    <g:each in="${[TournamentType.GRAND_SLAM, TournamentType.PREMIER_MANDATORY, TournamentType.PREMIER_5, TournamentType.PREMIER_12, TournamentType.INTERNATIONAL, TournamentType.SERIES, TournamentType.CIRCUIT]}" var="type">
      <tr>
        <td>${type.value}</td>
        <td>1</td>
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
A tournament can be a <strong>fixed</strong> type (the <i>Grand Slam</i>, <i>Championship</i> and <i>Tournament of Champions</i> types) or auto-weighted. Usually auto-weighting is used (based on player skills entering), but fixed types ccan be used for events that are considered Grand Slam unanimously (EVO class) or events that are very frequent but have a very local nature (like weeklies).
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
These are distributed according to tournament weight, which is the sum of the best 8 players that entered the top 64. Tournament organizers take note: providing result lists above top 8 results in better ranking results.
Championship and Tournament of Champions is reserved for leagues, with <i>Championship</i> being top-level and <i>Tournament of Champions</i>i> being lower-level. <i>Grand Slam</i> is assigned to large open international events that had qualifiers or seedings upfront.
In order to scale out better the number of tournaments each class has scales above 120. This avoids too heavy contention for the highest classes for games that have been runnign for years (eg AE2012 and MVC3 will have 20% more PREMIER events).

<h3>Ranking system</h3>
<g:img dir="images" file="rank_flow.png" class="charimg"/>

<h3>How much data is being tracked?</h3>
A total of ${players} players seen in ${tournaments} tournaments producing ${results} tournament rankings from ${first?.format("MM-yyyy")} until ${last?.format("MM-yyyy")}.


<h3>What about other games</h3>
There is a moderator feature in development to allow the community to add data for new games. When a game is added some code need to be adapted (eg character types need to be defined, new hyperlinks will be added) and images need to be cut (to display the characters etc). Afterwards it is a matter of finding results and inputting them in a consistent way that does not cause duplicates. Any help is appreciated.

<h3>What else is coming?</h3>
Besides ranking per version, it would also be nice to show some character statistics. The data is there so one could score characters instead of players and see what characters score best in tournaments. And of course the site will be updated whenever a new tournament is over. The ranking for AE 2012 is not final. We would also like to add in more foreign tournaments as US and JP are over represented. This is only possible if event sites report on these tournaments, and it will only be weighted correctly if one can rank the skill of the competing players.
<strong>This is how you can help!</strong>If you want a tournament listed or player data changed, then tweet @SRKRanking or go to the <a href="http://forums.shoryuken.com/discussion/187561/sf4-ae-world-ranking-site-has-been-beta-released">official thread on the SRK forums</a>. If you disagree with a player skill or country, then chances may be we did not know the player. So update me and we will update the data.

<h3>How can I provide feedbacks/comments?</h3>
Please also join the <a href="http://forums.shoryuken.com/discussion/187561/sf4-ae-world-ranking-site-has-been-beta-released">official thread on the SRK forums</a>, where a full discussion of this site is available. 

<h3>What technology is being used?</h3>
Glad you ask! This is a <a
        href="http://grails.org/">Grails</a> application, using GORM on MySQL for persistence, Grails services and controller for business logic and GSP for data rendering. The GSP pages are HTML5 using <a
        href="http://getbootstrap.com/">Bootstrap</a> for layout and JQuery for Javascript magic. The search engine uses Compass/Lucene. Backups are made in JSON and security is covered with Apache Shiro. All this is deployed on CloudBees on a Tomcat server. I love it.
<h3>Where did you get the cool character sprites?</h3>
These are kindly contributed by <a href="https://twitter.com/SpeedBrkr">SpeedBrkr</a> and <a href="http://www.shunao.org/">Lyn/Shunao</a>.

<h3>Credits</h3>
  I would like to thank explicitly the following sources that, one way or another, were an influence to this site: Kyosuke of <a href="http://www.ssfranking.com/" target="_blank">ssfranking</a> (Arcade battle data), <a href="http://www.kuroppi.com/tournamentresults/" target="_blank">Kuroppi</a> (historical tournament results), the staff at <a href="http://shoryuken.com/" target="_blank">Shoryuken</a> for up-to-date tournament reporting, the <a href="http://forums.shoryuken.com/discussion/comment/8850159#Comment_8850159" target="_blank">SRK forums</a> community for fixes and suggestions, George at <a href="http://freedamage.com/" target="_blank">freedamage.com</a> (for ideas and cropped images), <a href="https://twitter.com/SpeedBrkr" target="_blank">SpeedBrkr</a> (8-bit SFIV images), <a href="https://twitter.com/_shunao" target="_blank">Lyn</a> (MvC3 images), <a href="http://www.tokidoblog.com/" target="_blank">Tokidoblog</a> (Asian coverage), and countless people on Twitter for suggestions.

<hr />

</body>
</html>