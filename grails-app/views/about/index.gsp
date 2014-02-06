<%@ page import="be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>SF4 World Ranking - How it works</title>
</head>

<body>

<h2>How does it work?</h2>

<div class="jumbotron">
  <h1>Summary</h1>

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
Tournaments results are imported in top 8 or top 16 format if available. The name, date and location of that tournament is stored and players are registered if they were not in the database before. Along with the result the main character of that player is stored into the database.
<h3>How tournaments are weighted</h3>
Every player that is entered into the database has an initial <i>skill</i> value. A tournament weight is the sum of the skill values of all ranked contestants divided by the number of players.
<h3>How tournaments are classified</h3>
The tournament ranking is done by sorting on weight and then ditributing them into the tournament types used by <a
        href="http://en.wikipedia.org/wiki/Women%27s_Tennis_Association">WTA</a>
<br/>The distribution is:

<div class="table-responsive">
  <table class="table table-striped table-hover">
    <thead>
    <tr>
      <td>Type</td>
      <td>Amount</td>
      <td>First place</td>
      <td>Second place</td>
      <td>Third place</td>
      <td>Fourth place</td>
      <td>Fifth place</td>
      <td>Sixth place</td>
      <td>Seventh place</td>
      <td>Eight place</td>

    </tr>
    </thead>
    <tbody>
    <g:each in="${be.bbr.sf4ranking.TournamentType.values()}" var="type">
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
      </tr>
    </g:each>
    </tbody>
  </table>
</div>
There are also points awarded from 8th to 16th in the same fashion. To distribute the tournament types the following rules are used:
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
    <td>Grand Slam</td>
    <td>1</td>
  </tr>
  <tr>
    <td>Championship</td>
    <td>3</td>
  </tr>
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

<h3>What it tries to achieve</h3>
There are a lot of ways to rank players, and except for gut-feeling, only <a
        href="http://www.eventhubs.com/news/2014/jan/20/ladies-and-gentlemen-boys-and-girls-eventhubs-lists-top-10-current-ssf4-ae-v2012-players-voice-your-opinions-twitter-sf4rank/">Eventhubs</a> tried a more formal approach. This ranking tries the same, but in a transparant way, without leaving too much room for personal taste or fanboyism. If a player plays tournaments and does well, he'll be ranked. Just like WTA there is a rule that says one can only get points for his best 16 matches, so as more tournaments are being registered, the results will favor less those that play more, and reflect the rankings of those that placed best overall.
<h3>How much data is being tracked?</h3>
<ol>
  <li>Players ${players}</li>
  <li>Tournaments ${tournaments}</li>
  <li>Results ${results}</li>
  <li>First ${first?.format("MM-yyyy")}</li>
  <li>Last ${last?.format("MM-yyyy")}</li>
</ol>

<h3>What about older tournaments and versions?</h3>
The website is prepared to track the game version and then filter accordingly. However, the ranking system will score over all versions. The site will be updated to rank per game version instead at some point. Currently it is a AE 2012 ranking as long as there are no older tournaments entered.
It would be really neat though to have results up to Vanilla.
<h3>What else is coming</h3>
Besides ranking per version, it would also be nice to show some character statistics. The data is there so one could score characters instead of players and see what characters score best in tournaments. And of course the site will be updated whenever a new tournament is over. The ranking for AE 2012 is not final. I would also like to add in more foreign tournaments as US and JP are over represented. This is only possible if event sites repotrt on these tournaments, and it will only be weighted correctly if one can rank the skill of the competing players.
<strong>This is how you can help!</strong>If you want a tournament listed, then tweet me @bavobbr. If you disagree with a player skill or country, then chances are I did not know the player. So update me and I'll update the data.
<h3>What technology is being used?</h3>
Glad you ask! This is a <a
        href="http://grails.org/">Grails</a> application, using GORM on MySQL for persistence, Grails services and controller for business logic and GSP for data rendering. The GSP pages are HTML5 using <a
        href="http://getbootstrap.com/">Bootstrap</a> for layout and JQuery for Javascript magic. All this is deployed on CloudBees on a Tomcat server. I love it.
</body>
</html>