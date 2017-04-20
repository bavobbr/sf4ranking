
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Capcom Pro Tour 2015 Stats</title>


    <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
    <link href='http://fonts.googleapis.com/css?family=Lato:400,700,900' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Oswald:700' rel='stylesheet' type='text/css'>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="/static/js/jquery.metadata.js"></script>
    <script src="/static/js/jquery.tablesorter.min.js"></script>
    <script src="/static/js/jquery.tablecloth.js"></script>
    <link rel="stylesheet" href="/static/css/tablecloth.css" type="text/css">
    <link rel="stylesheet" href="/static/css/prettify.css" type="text/css">

    <link rel="stylesheet" href="/static/css/responsive-video.css" type="text/css">
    <link rel="stylesheet" href="/static/css/style_bootstrap.css" type="text/css">
    <link rel="stylesheet" href="/static/css/style_worldrank.css" type="text/css">
    <link rel="stylesheet" href="/static/css/bootstrap-tables.css" type="text/css">

    <script>
        $(function ()
        {
            function search(uid)
            {
                window.location = "/rankings/player/byname/" + uid
            }

            $("#playerSearch").autocomplete({
                source: "/rankings/autocompletePlayer",
                minLength: 3,
                select: function (event, ui)
                {
                    if (ui.item) search(ui.item.value);
                }
            });
        });
    </script>
    <script>
        $(function ()
        {
            function searchTournament(uid)
            {
                window.location = "/rankings/tournament/byname/" + uid
            }

            $("#tournamentSearch").autocomplete({
                source: "/rankings/autocompleteTournament",
                minLength: 2,
                select: function (event, ui)
                {
                    if (ui.item) searchTournament(ui.item.value);
                }
            });
        });
    </script>
    <script>
        jQuery(function ($)
        {
            $("a").tooltip()
        });
        jQuery(function () {
            $('[data-toggle="popover"]').popover()
        });
    </script>
    <script>
        $(document).ready(function ()
        {
            $('#playerSearch').keypress(function (e)
            {
                if (e.which == 13)
                {
                    $('#searchForm').submit();
                    return false;    //<---- Add this line
                }
            });
        })
    </script>

    <!-- Facebook Pixel Code -->
    <script>
        !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
                n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
            n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
            t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
                document,'script','//connect.facebook.net/en_US/fbevents.js');

        fbq('init', '1552062418442064');
        fbq('track', "PageView");</script>
    <noscript><img height="1" width="1" style="display:none"
                   src="https://www.facebook.com/tr?id=1552062418442064&ev=PageView&noscript=1"
    /></noscript>
    <!-- End Facebook Pixel Code -->
</head>

<body>


<div id="fb-root"></div>
<script>(function (d, s, id)
{
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s);
  js.id = id;
  js.src = "//connect.facebook.net/nl_NL/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>


<div class="container">

    <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="/rankings/index" class="navbar-brand">Shoryuken Rankings</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                <form class="navbar-form navbar-right top-search" role="search"
                      action="/rankings/search" id="searchForm">
                    <div class="form-group">
                        <input id="playerSearch" class="form-control" placeholder="Find a Player" name="player"
                               title="Press <ENTER> for advanced search">
                    </div>

                    <div class="form-group">
                        <input id="tournamentSearch" class="form-control" placeholder="Search Tournaments" name="tournament">
                    </div>
                </form>
                <ul class="nav navbar-nav navbar-right">

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">RANKINGS <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/rankings/index">Overview</a></li>
                            <li><a href="/rankings/teams">Player Teams</a></li>
                            <li><a href="/stats/index">Character Balance and Tiers</a></li>
                            <li class="divider"></li>
                            <li><a href="/rankings/rank/SF5">World Rankings Street Fighter 5</a></li>
                            <li><a href="/rankings/rank/MKX">World Rankings Mortal Kombat X</a></li>
                            <li><a href="/rankings/rank/UMVC3">World Rankings Marvel vs Capcom 3</a></li>
                            <li><a href="/rankings/rank/KI">World Rankings Killer Instinct</a></li>
                            <li><a href="/rankings/rank/SKULLGIRLS">World Rankings Skullgirls</a></li>
                            <li><a href="/rankings/rank/IGAU">World Rankings Injustice</a></li>
                            <li><a href="/rankings/rank/BBCP">World Rankings Blazblue CP</a></li>
                            <li class="divider"></li>
                            <li><a href="/rankings/rank/USF4">World Rankings Ultra SF4</a></li>
                            <li><a href="/rankings/rank/AE2012">World Rankings SF4:AE 2012</a></li>
                            <li><a href="/rankings/rank/AE">World Rankings SF4:AE</a></li>
                            <li><a href="/rankings/rank/SUPER">World Rankings SSF4</a></li>
                            <li><a href="/rankings/rank/VANILLA">World Rankings SF4</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">TOURNAMENTS <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/rankings/tournaments/SF5">Street Fighter 5</a></li>
                            <li><a href="/rankings/tournaments/MKX">Mortal Kombat X</a></li>
                            <li><a href="/rankings/tournaments/UMVC3">Marvel vs Capcom 3</a></li>
                            <li><a href="/rankings/tournaments/KI">Killer Instinct</a></li>
                            <li><a href="/rankings/tournaments/SKULLGIRLS">Skullgirls</a></li>
                            <li><a href="/rankings/tournaments/IGAU">Injustice</a></li>
                            <li><a href="/rankings/tournaments/BBCP">Blazblue CP</a></li>
                            <li class="divider"></li>
                            <li><a href="/rankings/tournaments/USF4">USF4</a></li>
                            <li><a href="/rankings/tournaments/AE2012">SF4:AE 2012</a></li>
                            <li><a href="/rankings/tournaments/AE">SF4:AE</a></li>
                            <li><a href="/rankings/tournaments/SUPER">SSF4</a></li>
                            <li><a href="/rankings/tournaments/VANILLA">SF4</a></li>
                        </ul>
                    </li>
                    <li><a href="/gear/index">CONTROLLERS</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">SUBMIT <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="/submit/index">Submit new tournament</a></li>
                            <li>
                                <a href="/submit/list">List submitted tournaments</a></li>
                            <li><a href="/api/index">REST/JSON API</a></li>
                            <li class="divider"></li>
                            <li><a href="http://forums.shoryuken.com/discussion/187561/sf4-ae-world-ranking-site-has-been-beta-released">Join Rank Discussion</a>
                            </li>
                        </ul>
                    </li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">CAPCOM PRO TOUR <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/rankings/cpt">Standings</a></li>
                            <li><a href="/rankings/cptStats">Tournaments and countries</a></li>
                            <li><a href="/rankings/cptCharacterStats">Players and Characters</a></li>
                            <li class="divider"></li>
                            <li><a href="/rankings/cpt_2015">Archived Standings 2015</a></li>
                            <li><a href="/rankings/cptStats_2015">Archived Tournaments and countries 2015</a></li>
                            <li><a href="/rankings/cptCharacterStats_2015">Archived Characters used 2015</a></li>
                            <li class="divider"></li>
                            <li><a href="/rankings/cpt_2016">Archived Standings 2016</a></li>
                            <li><a href="/rankings/cptStats_2016">Archived Tournaments and countries 2016</a></li>
                            <li><a href="/rankings/cptCharacterStats_2016">Archived Characters used 2016</a></li>
                        </ul>
                    </li>
                    <li><a href="/about/index">FAQ</a></li>


                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <div class="row">

        <div class="col-md-12">

            <div class="starter-template">
                


<h3 class="tournament"><small>43 Tournaments played</small></h3>
<div class="table-responsive">
    <table class="tablehead" id="datatable2">
        <thead>
        <tr class="stathead">
            <th>Name</th>
            <th>Date</th>
            <th>Location</th>
            <th>Weight</th>
            <th>Pro Tour</th>
            <th>Qualified</th>
            <th>Max Points</th>
            <th>Max Prize</th>
        </tr>
        </thead>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Cannes%20Winter%20Clash%202015%20-%20USF4">Cannes Winter Clash 2015 - USF4</a></td>
                <td>2015-03-01</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=FR">
                            <img src="/static/images/countries/fr.png" class="countryflag" />
                            France
                        </a>
                    
                </td>
                <td>1086</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Abuget%20Cup%202015%20-%20USF4">Abuget Cup 2015 - USF4</a></td>
                <td>2015-03-08</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=ID">
                            <img src="/static/images/countries/id.png" class="countryflag" />
                            Indonesia
                        </a>
                    
                </td>
                <td>646</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Nine%20States%20Tournament%202015%20%20-%20USF4">Nine States Tournament 2015  - USF4</a></td>
                <td>2015-03-14</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=JP">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>
                <td>812</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Final%20Round%2018%20-%20USF4">Final Round 18 - USF4</a></td>
                <td>2015-03-23</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>1200</td>
                <td>
                    Premier Tournament
                </td>
                <td>Xian</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Hypespotting%204%20-%20USF4">Hypespotting 4 - USF4</a></td>
                <td>2015-04-06</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=GB">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>
                <td>1060</td>
                <td>
                    Premier Tournament
                </td>
                <td>Mago</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Norcal%20Regionals%202015%20-%20USF4">Norcal Regionals 2015 - USF4</a></td>
                <td>2015-04-06</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>1171</td>
                <td>
                    Premier Tournament
                </td>
                <td>Daigo Umehara</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Double%20Elimination%20CPT%20Asia%20Qualifier%20-%20USF4">Double Elimination CPT Asia Qualifier - USF4</a></td>
                <td>2015-04-25</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=KR">
                            <img src="/static/images/countries/kr.png" class="countryflag" />
                            Republic of Korea
                        </a>
                    
                </td>
                <td>1086</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Northwest%20Majors%207%20-%20USF4">Northwest Majors 7 - USF4</a></td>
                <td>2015-04-26</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>774</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/KVO%20x%20TSB%202015%20-%20USF4">KVO x TSB 2015 - USF4</a></td>
                <td>2015-05-04</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=JP">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>
                <td>905</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Texas%20Showdown%202015%20-%20USF4">Texas Showdown 2015 - USF4</a></td>
                <td>2015-05-10</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>893</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Stunfest%202015%20-%20USF4">Stunfest 2015 - USF4</a></td>
                <td>2015-05-24</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=FR">
                            <img src="/static/images/countries/fr.png" class="countryflag" />
                            France
                        </a>
                    
                </td>
                <td>1200</td>
                <td>
                    Premier Tournament
                </td>
                <td>Momochi</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Combo%20Breaker%202015%20-%20USF4">Combo Breaker 2015 - USF4</a></td>
                <td>2015-05-24</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>706</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/FFM%20Rumble%208%20-%20USF4">FFM Rumble 8 - USF4</a></td>
                <td>2015-05-30</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=DE">
                            <img src="/static/images/countries/de.png" class="countryflag" />
                            Germany
                        </a>
                    
                </td>
                <td>981</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Dreamhack%20Summer%202015%20-%20USF4">Dreamhack Summer 2015 - USF4</a></td>
                <td>2015-06-14</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=SE">
                            <img src="/static/images/countries/se.png" class="countryflag" />
                            Sweden
                        </a>
                    
                </td>
                <td>1006</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/South%20East%20Asia%20Major%202015%20-%20USF4">South East Asia Major 2015 - USF4</a></td>
                <td>2015-06-21</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=TH">
                            <img src="/static/images/countries/th.png" class="countryflag" />
                            Thailand
                        </a>
                    
                </td>
                <td>1200</td>
                <td>
                    Premier Tournament
                </td>
                <td>Tokido</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/CEO%202015%20-%20USF4">CEO 2015 - USF4</a></td>
                <td>2015-06-29</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>1200</td>
                <td>
                    Premier Tournament
                </td>
                <td>Kazunoko</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Evolution%202015%20-%20USF4">Evolution 2015 - USF4</a></td>
                <td>2015-07-19</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>1200</td>
                <td>
                    Evolution tier
                </td>
                <td>GamerBee</td>
                <td>1024</td>
                <td>20000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Capcom%20pro%20tour%20Asia%20Shanghai%20qualifier%20-%20USF4">Capcom pro tour Asia Shanghai qualifier - USF4</a></td>
                <td>2015-08-02</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=CN">
                            <img src="/static/images/countries/cn.png" class="countryflag" />
                            China
                        </a>
                    
                </td>
                <td>922</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/FV%20Cup%202015%20-%20USF4">FV Cup 2015 - USF4</a></td>
                <td>2015-08-08</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=MY">
                            <img src="/static/images/countries/my.png" class="countryflag" />
                            Malaysia
                        </a>
                    
                </td>
                <td>1000</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/VSFighting%20Day%202%20-%20USF4">VSFighting Day 2 - USF4</a></td>
                <td>2015-08-09</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=GB">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>
                <td>727</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Taiwan%20Fighter%20Major%20CPT%20qualifier%20-%20USF4">Taiwan Fighter Major CPT qualifier - USF4</a></td>
                <td>2015-08-22</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=TW">
                            <img src="/static/images/countries/tw.png" class="countryflag" />
                            Taiwan
                        </a>
                    
                </td>
                <td>895</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Hong%20Kong%20Esports%20CPT%20Asia%20Qualifier%20-%20USF4">Hong Kong Esports CPT Asia Qualifier - USF4</a></td>
                <td>2015-08-29</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=HK">
                            <img src="/static/images/countries/hk.png" class="countryflag" />
                            Hong Kong
                        </a>
                    
                </td>
                <td>1000</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Summer%20Jam%209%20%20-%20USF4">Summer Jam 9  - USF4</a></td>
                <td>2015-08-31</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>891</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Manila%20Cup%202015%20-%20USF4">Manila Cup 2015 - USF4</a></td>
                <td>2015-09-05</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=PH">
                            <img src="/static/images/countries/ph.png" class="countryflag" />
                            Philippines
                        </a>
                    
                </td>
                <td>895</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/First%20Attack%202015%20-%20USF4">First Attack 2015 - USF4</a></td>
                <td>2015-09-06</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>849</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Saigon%20Cup%202015%20-%20USF4">Saigon Cup 2015 - USF4</a></td>
                <td>2015-09-12</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=VN">
                            <img src="/static/images/countries/vn.png" class="countryflag" />
                            Viet Nam
                        </a>
                    
                </td>
                <td>946</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/The%20Fall%20Classic%202015%20-%20USF4">The Fall Classic 2015 - USF4</a></td>
                <td>2015-09-14</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>788</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Mad%20Catz%20Tokyo%20Game%20Show%202015%20-%20USF4">Mad Catz Tokyo Game Show 2015 - USF4</a></td>
                <td>2015-09-20</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=JP">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>
                <td>1200</td>
                <td>
                    Premier Tournament
                </td>
                <td>Dashio</td>
                <td>256</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/KO%20Fighting%20Game%20Festival%20-%20USF4">KO Fighting Game Festival - USF4</a></td>
                <td>2015-09-25</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=KW">
                            <img src="/static/images/countries/kw.png" class="countryflag" />
                            Kuwait
                        </a>
                    
                </td>
                <td>1009</td>
                <td>
                    Premier Tournament
                </td>
                <td>Fuudo</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/The%20Call%20of%20Ragnarok%20%20-%20USF4">The Call of Ragnarok  - USF4</a></td>
                <td>2015-09-26</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=NO">
                            <img src="/static/images/countries/no.png" class="countryflag" />
                            Norway
                        </a>
                    
                </td>
                <td>750</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/EGX%202015%20-%20USF4">EGX 2015 - USF4</a></td>
                <td>2015-09-27</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=GB">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>
                <td>873</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Red%20Fight%20District%202015%20-%20USF4">Red Fight District 2015 - USF4</a></td>
                <td>2015-10-03</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=NL">
                            <img src="/static/images/countries/nl.png" class="countryflag" />
                            Netherlands
                        </a>
                    
                </td>
                <td>1003</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Ze%20Fighting%20Game%20Champion%20%28CPTA%20Qualifier%29%20-%20USF4">Ze Fighting Game Champion (CPTA Qualifier) - USF4</a></td>
                <td>2015-10-03</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=CN">
                            <img src="/static/images/countries/cn.png" class="countryflag" />
                            China
                        </a>
                    
                </td>
                <td>1000</td>
                <td>
                    Qualifier Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/SoCal%20Regionals%202015%20-%20USF4">SoCal Regionals 2015 - USF4</a></td>
                <td>2015-10-09</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>1086</td>
                <td>
                    Premier Tournament
                </td>
                <td>Bonchan</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/CPT%20Brazil%20Registration%202015%20-%20USF4">CPT Brazil Registration 2015 - USF4</a></td>
                <td>2015-10-10</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=BR">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>
                <td>453</td>
                <td>
                    Premier Tournament
                </td>
                <td>Keoma</td>
                <td>256</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Ultra%20Hyakkishu%20Cup%202015%20-%20USF4">Ultra Hyakkishu Cup 2015 - USF4</a></td>
                <td>2015-10-17</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=JP">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>
                <td>862</td>
                <td>
                    Premier Tournament
                </td>
                <td>Nemo</td>
                <td>256</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Milan%20Games%20Week%202015%20-%20USF4">Milan Games Week 2015 - USF4</a></td>
                <td>2015-10-23</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=IT">
                            <img src="/static/images/countries/it.png" class="countryflag" />
                            Italy
                        </a>
                    
                </td>
                <td>1086</td>
                <td>
                    Premier Tournament
                </td>
                <td>RB</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Defend%20the%20North%202015%20-%20USF4">Defend the North 2015 - USF4</a></td>
                <td>2015-10-24</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>823</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/True%20Challengers%20Costa%20Rica%20-%20USF4">True Challengers Costa Rica - USF4</a></td>
                <td>2015-10-24</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=CR">
                            <img src="/static/images/countries/cr.png" class="countryflag" />
                            Costa Rica
                        </a>
                    
                </td>
                <td>654</td>
                <td>
                    Ranking Tournament
                </td>
                <td></td>
                <td>128</td>
                <td>0</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Canada%20Cup%202015%20-%20USF4">Canada Cup 2015 - USF4</a></td>
                <td>2015-10-30</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=CA">
                            <img src="/static/images/countries/ca.png" class="countryflag" />
                            Canada
                        </a>
                    
                </td>
                <td>1200</td>
                <td>
                    Premier Tournament
                </td>
                <td>Itabashi Zangief</td>
                <td>256</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Capcom%20Pro%20Tour%20Asia%20Finals%202015%20-%20USF4">Capcom Pro Tour Asia Finals 2015 - USF4</a></td>
                <td>2015-11-13</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=SG">
                            <img src="/static/images/countries/sg.png" class="countryflag" />
                            Singapore
                        </a>
                    
                </td>
                <td>946</td>
                <td>
                    Premier without points
                </td>
                <td>Poongko</td>
                <td>0</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Dreamhack%20Winter%202015%20-%20USF4">Dreamhack Winter 2015 - USF4</a></td>
                <td>2015-11-26</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=SE">
                            <img src="/static/images/countries/se.png" class="countryflag" />
                            Sweden
                        </a>
                    
                </td>
                <td>1032</td>
                <td>
                    Premier without points
                </td>
                <td>Luffy</td>
                <td>0</td>
                <td>7000</td>
            </tr>
        
            <tr>
                <td><a href="/rankings/tournament/byname/Capcom%20Cup%202015%20-%20USF4">Capcom Cup 2015 - USF4</a></td>
                <td>2015-12-07</td>
                <td>
                    
                        <a href="/rankings/tournaments?country=US">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>
                <td>1200</td>
                <td>
                    Capcom Cup
                </td>
                <td></td>
                <td>0</td>
                <td>120000</td>
            </tr>
        

    </table>
    A total of 7680 points could be scored and 16 direct places were granted

</div>



<h3 class="tournament"><small>Qualified listed players by country</small></h3>
<div class="table-responsive">
    <table class="tablehead" id="datatable4">
        <thead>
        <tr class="stathead">
            <th>Country</th>
            <th>Amount</th>
            <th>Players</th>
        </tr>
        </thead>
        
            <tr>
                <td>TW</td>
                <td>2</td>
                <td>RB, GamerBee</td>
            </tr>
        
            <tr>
                <td>CN</td>
                <td>3</td>
                <td>Dakou, Dark Jiewa, Xiaohai</td>
            </tr>
        
            <tr>
                <td>JP</td>
                <td>13</td>
                <td>Misse, Shiro, Dashio, Tonpy, Itabashi Zangief, Nemo, Kazunoko, Daigo Umehara, Mago, Fuudo, Tokido, Bonchan, Momochi</td>
            </tr>
        
            <tr>
                <td>FR</td>
                <td>2</td>
                <td>Valmaster, Luffy</td>
            </tr>
        
            <tr>
                <td>SG</td>
                <td>2</td>
                <td>Gackt, Xian</td>
            </tr>
        
            <tr>
                <td>GB</td>
                <td>1</td>
                <td>Problem X</td>
            </tr>
        
            <tr>
                <td>HK</td>
                <td>1</td>
                <td>HumanBomb</td>
            </tr>
        
            <tr>
                <td>US</td>
                <td>5</td>
                <td>Dieminion, 801 Strider, NuckleDu, Justin Wong, Snake Eyez</td>
            </tr>
        
            <tr>
                <td>BR</td>
                <td>1</td>
                <td>Keoma</td>
            </tr>
        
            <tr>
                <td>KR</td>
                <td>2</td>
                <td>Poongko, Infiltration</td>
            </tr>
        
    </table>
</div>


<h3 class="tournament"><small>Total listed players by country</small></h3>
<div class="table-responsive">
    <table class="tablehead" id="datatable3">
        <thead>
        <tr class="stathead">
            <th>Country</th>
            <th>Amount</th>
        </tr>
        </thead>
        
            <tr>
                <td>JP</td>
                <td>44</td>
            </tr>
        
            <tr>
                <td>KR</td>
                <td>2</td>
            </tr>
        
            <tr>
                <td>SG</td>
                <td>4</td>
            </tr>
        
            <tr>
                <td>TW</td>
                <td>2</td>
            </tr>
        
            <tr>
                <td>FR</td>
                <td>6</td>
            </tr>
        
            <tr>
                <td>US</td>
                <td>32</td>
            </tr>
        
            <tr>
                <td>CN</td>
                <td>7</td>
            </tr>
        
            <tr>
                <td>BR</td>
                <td>10</td>
            </tr>
        
            <tr>
                <td>HK</td>
                <td>2</td>
            </tr>
        
            <tr>
                <td>GB</td>
                <td>17</td>
            </tr>
        
            <tr>
                <td>NO</td>
                <td>2</td>
            </tr>
        
            <tr>
                <td>SA</td>
                <td>1</td>
            </tr>
        
            <tr>
                <td>MY</td>
                <td>2</td>
            </tr>
        
            <tr>
                <td>NL</td>
                <td>1</td>
            </tr>
        
            <tr>
                <td>KW</td>
                <td>2</td>
            </tr>
        
            <tr>
                <td>CA</td>
                <td>2</td>
            </tr>
        
            <tr>
                <td></td>
                <td>4</td>
            </tr>
        
            <tr>
                <td>MX</td>
                <td>2</td>
            </tr>
        
            <tr>
                <td>ID</td>
                <td>3</td>
            </tr>
        
            <tr>
                <td>PA</td>
                <td>1</td>
            </tr>
        
            <tr>
                <td>CR</td>
                <td>2</td>
            </tr>
        
            <tr>
                <td>DE</td>
                <td>1</td>
            </tr>
        
            <tr>
                <td>SE</td>
                <td>1</td>
            </tr>
        
    </table>
</div>
<script type="text/javascript" charset="utf-8">
  $(document).ready(function ()
                    {
                      $('table[id^="datatable"]').each(function (index)
                                                       {
                                                         $(this).tablecloth({
                                                                              theme: "default",
                                                                              striped: true,
                                                                              sortable: true,
                                                                              condensed: true})
                                                       })
                    });
  $(document).ready(function ()
                    {
                      $('table[id^="infotable"]').each(function (index)
                                                       {
                                                         $(this).tablecloth({
                                                                              theme: "default",
                                                                              striped: true,
                                                                              sortable: true,
                                                                              condensed: false})
                                                       })
                    });

</script>


                <br/>


                <div class="footer">
                    <div class="row">
                        <div class="col-md-4">
                            <p class="large">Street Fighter World Rankings &copy; 2014 Bavo Bruylandt</p>
                        </div>

                        <div class="col-md-4">
                            <a href="https://twitter.com/share" class="twitter-share-button" data-via="SRKRanking">Tweet</a>
                            <script>!function (d, s, id)
                            {
                                var js, fjs = d.getElementsByTagName(s)[0], p = /^http:/.test(d.location) ? 'http' : 'https';
                                if (!d.getElementById(id))
                                {
                                    js = d.createElement(s);
                                    js.id = id;
                                    js.src = p + '://platform.twitter.com/widgets.js';
                                    fjs.parentNode.insertBefore(js, fjs);
                                }
                            }(document, 'script', 'twitter-wjs');</script>
                        </div>

                        <div class="col-md-4">
                            <div class="fb-share-button" data-href="http://rank.shoryuken.com/" data-type="button_count"></div>
                        </div>
                    </div>


                    <p>Developed by <a href="https://twitter.com/bavobbr">Bavo Bruylandt</a> &middot; Hosted by <a
                            href="http://www.shoryuken.com">Shoryuken</a>  &middot;
                        Bootstrap mods by <a href="http://www.kineda.com">Kineda</a> &middot; Twitter at <a
                            href="https://twitter.com/SRKRanking">@SRK Ranking</a> &middot; For more info, visit <a
                            href="http://forums.shoryuken.com/discussion/187561/sf4-ae-world-ranking-site-has-been-beta-released">official thread</a>.
                    </p>

                </div>
            </div>
        </div>

    </div>
</div>


<script>
    (function (i, s, o, g, r, a, m)
    {
        i['GoogleAnalyticsObject'] = r;
        i[r] = i[r] || function ()
        {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date();
        a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
        a.async = 1;
        a.src = g;
        m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-47390615-1', 'shoryuken.com');
    ga('send', 'pageview');

</script>

</body>
</html>