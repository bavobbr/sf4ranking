<%@ page import="be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>SF4 World Ranking - FAQ</title>
</head>

<body>

<h2>How does it work?</h2>

<div class="jumbotron">
  <h2>Summary</h2>

  <p>
    The rankings given to players is analog to <a
          href="http://www.atpworldtour.com/">ATP and WTA</a>. Players earn points by placing in tournaments.
  Tournaments are ordered by importance and given a classification. The players in those tournemants are then assigned a score based on their place within a tournament, adjusted with the tournament weight.
  </p>
</div>

<h3>What is SFIV?</h3>
That's a weird question to ask if you managed to end up here. But if you really don't know what the fuzz is all about I gladly give you an excerpt from Wikipedia:
<blockquote>
  Street Fighter IV (ストリートファイター IV Sutorīto Faitā Fō?) is a 2008 fighting game produced by Capcom. It was the first numbered Street Fighter game released by Capcom since 1999, a hiatus of nine years.
  The coin-operated arcade game version was released in Japan on July 18, 2008. The console versions for the PlayStation 3 and Xbox 360 were released in February 12, 2009. A Windows version was released on July 2. Street Fighter IV had sold over 3 million copies worldwide. An updated version, Super Street Fighter IV, was released as a standalone title in April 2010.
  Street Fighter IV has sold 3.3 million units by September 2013. Super Street Fighter IV has sold 1.9 million units, in addition to 400,000 of the Arcade Edition, by December 2011.Super Street Fighter IV: 3D Edition sold an additional 1. million copies as of December 2011. This adds up to sales of 6.7 million copies in total.
  <br/>Upon its release, the game received universal critical acclaim; receiving universally high scores from many gaming websites and magazines. <a
        href="http://en.wikipedia.org/wiki/Street_fighter_4">Street Fighter 4 at Wikipedia</a>
</blockquote>
Essentially Street Fighter 4 is a one-on-one fighting game which plays in 2D but rendered in 3D, keeping gameplay close to the legendary Street Fighter 2 classic.

<h3>How data is entered</h3>
Tournaments results are imported in top 8, top 16 or top 32 format if available. The name, date and location of that tournament is stored and players are registered if they were not in the database before. Along with the result the main character of that player is stored into the database.
<h3>How tournaments are weighted</h3>
Every player that is entered into the database has an initial <i>skill weight</i> value. A tournament weight then becomes the average of the skill values of the best 8 reported players.
<h3>How tournaments are classified</h3>
The tournament ranking is done by sorting on weight and then ditributing them into the tournament types used by <a
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
Currently the points in Single and Double bracket mode are the same. A tournament can be a <strong>fixed</strong> type (the <i>Grand Slam</i>, <i>Championship</i> and <i>Tournament of Champions</i> types) or auto-weighted.
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
These are distributed according to tournament weight, which is the sum of the best 8 players that entered the top 32. Tournament organizers take note: providing result lists above top 8 results in better ranking results.
Championship and Tournament of Champions is reserved for leagues, with <i>Championship</i> being top-level and <i>Tournament of Champions</i>i> being lower-level. <i>Grand Slam</i> is assigned to large open international events that had aualifiers or seedings upfront.

<h3>How much data is being tracked?</h3>
A total of ${players} players seen in ${tournaments} tournaments producing ${results} tournament rankings from ${first?.format("MM-yyyy")} until ${last?.format("MM-yyyy")}. This covers most of the notable SF4:AE2012 tournaments, but it can be better and of course we would like to add older SF4 versions, or even other games such as MvC3 as well.


<h3>What about older tournaments and versions?</h3>
The website is prepared to track the game version and then filter accordingly. However, the ranking system will score over all versions. The site will be updated to rank per game version instead at some point. Currently it is a AE 2012 ranking as long as there are no older tournaments entered.
It would be really neat though to have results up to Vanilla.

<h3>What else is coming?</h3>
Besides ranking per version, it would also be nice to show some character statistics. The data is there so one could score characters instead of players and see what characters score best in tournaments. And of course the site will be updated whenever a new tournament is over. The ranking for AE 2012 is not final. We would also like to add in more foreign tournaments as US and JP are over represented. This is only possible if event sites report on these tournaments, and it will only be weighted correctly if one can rank the skill of the competing players.
<strong>This is how you can help!</strong>If you want a tournament listed or player data changed, then tweet @bavobbr or go to the <a href="http://forums.shoryuken.com/discussion/187561/sf4-ae-world-ranking-site-has-been-beta-released">official thread on the SRK forums</a>. If you disagree with a player skill or country, then chances may be we did not know the player. So update me and we will update the data.

<h3>How can I provide feedbacks/comments?</h3>
Please also join the <a href="http://forums.shoryuken.com/discussion/187561/sf4-ae-world-ranking-site-has-been-beta-released">official thread on the SRK forums</a>, where a full discussion of this site is available. 

<h3>What technology is being used?</h3>
Glad you ask! This is a <a
        href="http://grails.org/">Grails</a> application, using GORM on MySQL for persistence, Grails services and controller for business logic and GSP for data rendering. The GSP pages are HTML5 using <a
        href="http://getbootstrap.com/">Bootstrap</a> for layout and JQuery for Javascript magic. All this is deployed on CloudBees on a Tomcat server. I love it.
<hr />

</body>
</html>