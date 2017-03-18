

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Capcom Pro Tour 2016 Stats</title>


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
<script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/nl_NL/sdk.js#xfbml=1&version=v2.6";
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
                            <li><a href="/rankings/cpt_2015">Standings 2015</a></li>
                            <li><a href="/rankings/cptStats_2015">Tournaments and countries 2015</a></li>
                            <li><a href="/rankings/cptCharacterStats_2015">Characters used 2015</a></li>
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



                <h3 class="tournament"><small>73 Tournaments played</small></h3>
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
                            <td><a href="/rankings/tournament/byname/Cannes%20Winter%20Clash%202016%20-%20SF5">Cannes Winter Clash 2016 - SF5</a></td>
                            <td>2016-02-28</td>
                            <td>

                                <a href="/rankings/tournaments?country=FR">
                                    <img src="/static/images/countries/fr.png" class="countryflag" />
                                    France
                                </a>

                            </td>
                            <td>5844</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Mister Crimson (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Final%20Round%2019%20-%20SF5">Final Round 19 - SF5</a></td>
                            <td>2016-03-21</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>10436</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>Infiltration (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/NorCal%20Regionals%202016%20-%20SF5">NorCal Regionals 2016 - SF5</a></td>
                            <td>2016-03-27</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>10292</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>Infiltration (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Hypespotting%20V%20-%20SF5">Hypespotting V - SF5</a></td>
                            <td>2016-04-03</td>
                            <td>

                                <a href="/rankings/tournaments?country=GB">
                                    <img src="/static/images/countries/gb.png" class="countryflag" />
                                    United Kingdom
                                </a>

                            </td>
                            <td>6000</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Problem X (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Jam%20Festival%202016%20-%20SF5">Jam Festival 2016 - SF5</a></td>
                            <td>2016-04-10</td>
                            <td>

                                <a href="/rankings/tournaments?country=BR">
                                    <img src="/static/images/countries/br.png" class="countryflag" />
                                    Brazil
                                </a>

                            </td>
                            <td>2952</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Justin Wong (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/West%20Coast%20Warzone%205%20-%20SF5">West Coast Warzone 5 - SF5</a></td>
                            <td>2016-04-18</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>6009</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Chris Tatarian (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Frogbyte%202016%20-%20SF5">Frogbyte 2016 - SF5</a></td>
                            <td>2016-04-24</td>
                            <td>

                                <a href="/rankings/tournaments?country=IT">
                                    <img src="/static/images/countries/it.png" class="countryflag" />
                                    Italy
                                </a>

                            </td>
                            <td>3899</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Phenom (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Texas%20Showdown%202016%20-%20SF5">Texas Showdown 2016 - SF5</a></td>
                            <td>2016-04-25</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>4441</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Julio Fuentes (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Northwest%20Majors%208%20-%20SF5">Northwest Majors 8 - SF5</a></td>
                            <td>2016-05-01</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>6907</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Justin Wong (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Thaiger%20Uppercut%202016%20-%20SF5">Thaiger Uppercut 2016 - SF5</a></td>
                            <td>2016-05-08</td>
                            <td>

                                <a href="/rankings/tournaments?country=TH">
                                    <img src="/static/images/countries/th.png" class="countryflag" />
                                    Thailand
                                </a>

                            </td>
                            <td>6339</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Eita (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Dreamhack%20Austin%20-%20SF5">Dreamhack Austin - SF5</a></td>
                            <td>2016-05-08</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>6242</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>NuckleDu (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Battle%20Arena%20Melbourne%208%20-%20SF5">Battle Arena Melbourne 8 - SF5</a></td>
                            <td>2016-05-15</td>
                            <td>

                                <a href="/rankings/tournaments?country=AU">
                                    <img src="/static/images/countries/au.png" class="countryflag" />
                                    Australia
                                </a>

                            </td>
                            <td>3705</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Haitani (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Stunfest%202016%20-%20SF5">Stunfest 2016 - SF5</a></td>
                            <td>2016-05-22</td>
                            <td>

                                <a href="/rankings/tournaments?country=FR">
                                    <img src="/static/images/countries/fr.png" class="countryflag" />
                                    France
                                </a>

                            </td>
                            <td>10335</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>Momochi (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Toryuken%205%20-%20SF5">Toryuken 5 - SF5</a></td>
                            <td>2016-05-23</td>
                            <td>

                                <a href="/rankings/tournaments?country=CA">
                                    <img src="/static/images/countries/ca.png" class="countryflag" />
                                    Canada
                                </a>

                            </td>
                            <td>4916</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Filipino Champ (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Lima%20Salty%20-%20SF5">Lima Salty - SF5</a></td>
                            <td>2016-05-23</td>
                            <td>

                                <a href="/rankings/tournaments?country=PE">
                                    <img src="/static/images/countries/pe.png" class="countryflag" />
                                    Peru
                                </a>

                            </td>
                            <td>920</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Misterio (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/FFM%20Rumble%209%20-%20SF5">FFM Rumble 9 - SF5</a></td>
                            <td>2016-05-28</td>
                            <td>

                                <a href="/rankings/tournaments?country=DE">
                                    <img src="/static/images/countries/de.png" class="countryflag" />
                                    Germany
                                </a>

                            </td>
                            <td>7651</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>CCL (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Combo%20Breaker%202016%20-%20SF5">Combo Breaker 2016 - SF5</a></td>
                            <td>2016-05-29</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>6362</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Flash (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Japonawa%20X%20-%20SF5">Japonawa X - SF5</a></td>
                            <td>2016-05-30</td>
                            <td>

                                <a href="/rankings/tournaments?country=MX">
                                    <img src="/static/images/countries/mx.png" class="countryflag" />
                                    Mexico
                                </a>

                            </td>
                            <td>3352</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Chris Tatarian (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Tokyo%20Button%20Mashers%20-%20SF5">Tokyo Button Mashers - SF5</a></td>
                            <td>2016-06-05</td>
                            <td>

                                <a href="/rankings/tournaments?country=JP">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    Japan
                                </a>

                            </td>
                            <td>7098</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Kazunoko (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/The%20Fight%202016%20Colombia%20-%20SF5">The Fight 2016 Colombia - SF5</a></td>
                            <td>2016-06-06</td>
                            <td>

                                <a href="/rankings/tournaments?country=CO">
                                    <img src="/static/images/countries/co.png" class="countryflag" />
                                    Colombia
                                </a>

                            </td>
                            <td>2219</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>K-Brad (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/TWFighter%20Major%202016%20-%20SF5">TWFighter Major 2016 - SF5</a></td>
                            <td>2016-06-11</td>
                            <td>

                                <a href="/rankings/tournaments?country=TW">
                                    <img src="/static/images/countries/tw.png" class="countryflag" />
                                    Taiwan
                                </a>

                            </td>
                            <td>8286</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Mago (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Moscow%20Fighting%20Arena%202016%20-%20SF5">Moscow Fighting Arena 2016 - SF5</a></td>
                            <td>2016-06-13</td>
                            <td>

                                <a href="/rankings/tournaments?country=RU">
                                    <img src="/static/images/countries/ru.png" class="countryflag" />
                                    Russian Federation
                                </a>

                            </td>
                            <td>3651</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Xian (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Dreamhack%20Summer%202016%20-%20SF5">Dreamhack Summer 2016 - SF5</a></td>
                            <td>2016-06-19</td>
                            <td>

                                <a href="/rankings/tournaments?country=SE">
                                    <img src="/static/images/countries/se.png" class="countryflag" />
                                    Sweden
                                </a>

                            </td>
                            <td>9790</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>Phenom (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CEO%202016%20-%20SF5">CEO 2016 - SF5</a></td>
                            <td>2016-06-26</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>10338</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>Tokido (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/G-League%202016%20%20-%20SF5">G-League 2016  - SF5</a></td>
                            <td>2016-07-10</td>
                            <td>

                                <a href="/rankings/tournaments?country=CN">
                                    <img src="/static/images/countries/cn.png" class="countryflag" />
                                    China
                                </a>

                            </td>
                            <td>10067</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>Xiaohai (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Evolution%202016%20-%20SF5">Evolution 2016 - SF5</a></td>
                            <td>2016-07-17</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>10708</td>
                            <td>
                                Evolution tier
                            </td>
                            <td>Infiltration (Global)</td>
                            <td>1024</td>
                            <td>20000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/SANA%202016%20-%20SF5">SANA 2016 - SF5</a></td>
                            <td>2016-07-17</td>
                            <td>

                                <a href="/rankings/tournaments?country=BR">
                                    <img src="/static/images/countries/br.png" class="countryflag" />
                                    Brazil
                                </a>

                            </td>
                            <td>450</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Ericke Maciel (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Sonic%20Boom%202016%20-%20SF5">Sonic Boom 2016 - SF5</a></td>
                            <td>2016-07-31</td>
                            <td>

                                <a href="/rankings/tournaments?country=ES">
                                    <img src="/static/images/countries/es.png" class="countryflag" />
                                    Spain
                                </a>

                            </td>
                            <td>7511</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>MOV (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Defend%20The%20North%202016%20-%20SF5">Defend The North 2016 - SF5</a></td>
                            <td>2016-08-01</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>6150</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Ricki Ortiz (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%202016%20NA%20Online%20Ranking%20Event%201%20-%20SF5">CPT 2016 NA Online Ranking Event 1 - SF5</a></td>
                            <td>2016-08-01</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>2156</td>
                            <td>
                                Online Event
                            </td>
                            <td>XsK Samurai (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%202016%20LA%20Online%20Ranking%20Event%201%20-%20SF5">CPT 2016 LA Online Ranking Event 1 - SF5</a></td>
                            <td>2016-08-07</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>1928</td>
                            <td>
                                Online Event
                            </td>
                            <td>KusanagiMX (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%202016%20AO%20Online%20Ranking%20Event%201%20-%20SF5">CPT 2016 AO Online Ranking Event 1 - SF5</a></td>
                            <td>2016-08-07</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>2186</td>
                            <td>
                                Online Event
                            </td>
                            <td>Xian (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/VSFighting%202016%20-%20SF5">VSFighting 2016 - SF5</a></td>
                            <td>2016-08-07</td>
                            <td>

                                <a href="/rankings/tournaments?country=GB">
                                    <img src="/static/images/countries/gb.png" class="countryflag" />
                                    United Kingdom
                                </a>

                            </td>
                            <td>7070</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Chris Tatarian (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%202016%20EU%20Online%20Ranking%20Event%201%20-%20SF5">CPT 2016 EU Online Ranking Event 1 - SF5</a></td>
                            <td>2016-08-13</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>5388</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Cobelcog (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Well%20Played%20Cup%202016%20-%20SF5">Well Played Cup 2016 - SF5</a></td>
                            <td>2016-08-14</td>
                            <td>

                                <a href="/rankings/tournaments?country=JP">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    Japan
                                </a>

                            </td>
                            <td>6402</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Daigo Umehara (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Yangcheng%20Cup%20-%20SF5">Yangcheng Cup - SF5</a></td>
                            <td>2016-08-14</td>
                            <td>

                                <a href="/rankings/tournaments?country=CN">
                                    <img src="/static/images/countries/cn.png" class="countryflag" />
                                    China
                                </a>

                            </td>
                            <td>5822</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Tse4444 (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Furia%20Tica%20-%20SF5">Furia Tica - SF5</a></td>
                            <td>2016-08-15</td>
                            <td>

                                <a href="/rankings/tournaments?country=CR">
                                    <img src="/static/images/countries/cr.png" class="countryflag" />
                                    Costa Rica
                                </a>

                            </td>
                            <td>3932</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Will2Pac (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Summer%20Jam%202016%20-%20SF5">Summer Jam 2016 - SF5</a></td>
                            <td>2016-08-19</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>6504</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>K-Brad (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Esports%20Festival%20Hong%20Kong%202016%20-%20SF5">Esports Festival Hong Kong 2016 - SF5</a></td>
                            <td>2016-08-20</td>
                            <td>

                                <a href="/rankings/tournaments?country=HK">
                                    <img src="/static/images/countries/hk.png" class="countryflag" />
                                    Hong Kong
                                </a>

                            </td>
                            <td>8704</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>GamerBee (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Absolute%20Battle%202016%20-%20SF5">Absolute Battle 2016 - SF5</a></td>
                            <td>2016-08-26</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>4822</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Alucard (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Ozhadou%20Nationals%2014%20-%20SF5">Ozhadou Nationals 14 - SF5</a></td>
                            <td>2016-08-26</td>
                            <td>

                                <a href="/rankings/tournaments?country=AU">
                                    <img src="/static/images/countries/au.png" class="countryflag" />
                                    Australia
                                </a>

                            </td>
                            <td>4483</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Itabashi Zangief (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Geek%20Lounge%202016%20-%20SF5">Geek Lounge 2016 - SF5</a></td>
                            <td>2016-08-27</td>
                            <td>

                                <a href="/rankings/tournaments?country=AR">
                                    <img src="/static/images/countries/ar.png" class="countryflag" />
                                    Argentina
                                </a>

                            </td>
                            <td>357</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Baek (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Fight%20in%20Rio%20Olympia%202016%20-%20SF5">Fight in Rio Olympia 2016 - SF5</a></td>
                            <td>2016-08-27</td>
                            <td>

                                <a href="/rankings/tournaments?country=BR">
                                    <img src="/static/images/countries/br.png" class="countryflag" />
                                    Brazil
                                </a>

                            </td>
                            <td>1498</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Brolynho (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%202016%20EU%20Online%20Ranking%20Event%202%20-%20SF5">CPT 2016 EU Online Ranking Event 2 - SF5</a></td>
                            <td>2016-08-27</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>6592</td>
                            <td>
                                Online Event
                            </td>
                            <td>ImStillDaDaddy (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/East%20Coast%20Throwdown%202016%20-%20SF5">East Coast Throwdown 2016 - SF5</a></td>
                            <td>2016-09-03</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>4792</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Ludovic (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/First%20Attack%202016%20-%20SF5">First Attack 2016 - SF5</a></td>
                            <td>2016-09-03</td>
                            <td>

                                <a href="/rankings/tournaments?country=PR">
                                    <img src="/static/images/countries/pr.png" class="countryflag" />
                                    Puerto Rico
                                </a>

                            </td>
                            <td>5198</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>John Takeuchi (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Celtic%20Thowdown%202016%20-%20SF5">Celtic Thowdown 2016 - SF5</a></td>
                            <td>2016-09-03</td>
                            <td>

                                <a href="/rankings/tournaments?country=IE">
                                    <img src="/static/images/countries/ie.png" class="countryflag" />
                                    Ireland
                                </a>

                            </td>
                            <td>6703</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Luffy (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Ze%20fighting%20Game%202016%20-%20SF5">Ze fighting Game 2016 - SF5</a></td>
                            <td>2016-09-03</td>
                            <td>

                                <a href="/rankings/tournaments?country=CN">
                                    <img src="/static/images/countries/cn.png" class="countryflag" />
                                    China
                                </a>

                            </td>
                            <td>6875</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Xiaohai (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%202016%20LA%20Online%20Ranking%20Event%202%20-%20SF5">CPT 2016 LA Online Ranking Event 2 - SF5</a></td>
                            <td>2016-09-10</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>2514</td>
                            <td>
                                Online Event
                            </td>
                            <td>DR Ray (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Lockdown%202016%20-%20SF5">Lockdown 2016 - SF5</a></td>
                            <td>2016-09-10</td>
                            <td>

                                <a href="/rankings/tournaments?country=PT">
                                    <img src="/static/images/countries/pt.png" class="countryflag" />
                                    Portugal
                                </a>

                            </td>
                            <td>2419</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Daigo Umehara (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Manila%20Cup%202016%20-%20SF5">Manila Cup 2016 - SF5</a></td>
                            <td>2016-09-10</td>
                            <td>

                                <a href="/rankings/tournaments?country=PH">
                                    <img src="/static/images/countries/ph.png" class="countryflag" />
                                    Philippines
                                </a>

                            </td>
                            <td>7427</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Justin Wong (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%202016%20NA%20Online%20Ranking%20Event%202%20-%20SF5">CPT 2016 NA Online Ranking Event 2 - SF5</a></td>
                            <td>2016-09-11</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>3428</td>
                            <td>
                                Online Event
                            </td>
                            <td>Punk (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Japan%20Cup%202016%20-%20SF5">Japan Cup 2016 - SF5</a></td>
                            <td>2016-09-17</td>
                            <td>

                                <a href="/rankings/tournaments?country=JP">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    Japan
                                </a>

                            </td>
                            <td>9648</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>GamerBee (Global)</td>
                            <td>256</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Thunderstruck%20-%20SF5">Thunderstruck - SF5</a></td>
                            <td>2016-09-17</td>
                            <td>

                                <a href="/rankings/tournaments?country=MX">
                                    <img src="/static/images/countries/mx.png" class="countryflag" />
                                    Mexico
                                </a>

                            </td>
                            <td>1916</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Filipino Champ (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Fighting%20Fest%20-%20SF5">Fighting Fest - SF5</a></td>
                            <td>2016-09-18</td>
                            <td>

                                <a href="/rankings/tournaments?country=DO">
                                    <img src="/static/images/countries/do.png" class="countryflag" />
                                    Dominican Republic
                                </a>

                            </td>
                            <td>2818</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Crossover (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/EGX%202016%20-%20SF5">EGX 2016 - SF5</a></td>
                            <td>2016-09-22</td>
                            <td>

                                <a href="/rankings/tournaments?country=GB">
                                    <img src="/static/images/countries/gb.png" class="countryflag" />
                                    United Kingdom
                                </a>

                            </td>
                            <td>8733</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>GamerBee (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Never%20Give%20Up%202016%20-%20SF5">Never Give Up 2016 - SF5</a></td>
                            <td>2016-09-24</td>
                            <td>

                                <a href="/rankings/tournaments?country=CL">
                                    <img src="/static/images/countries/cl.png" class="countryflag" />
                                    Chile
                                </a>

                            </td>
                            <td>2974</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Jiewa (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Treta%202016%20-%20SF5">Treta 2016 - SF5</a></td>
                            <td>2016-10-01</td>
                            <td>

                                <a href="/rankings/tournaments?country=BR">
                                    <img src="/static/images/countries/br.png" class="countryflag" />
                                    Brazil
                                </a>

                            </td>
                            <td>1742</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Dark817 (Latin America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Fighting%20Games%20Challenge%202016%20-%20SF5">Fighting Games Challenge 2016 - SF5</a></td>
                            <td>2016-10-01</td>
                            <td>

                                <a href="/rankings/tournaments?country=PL">
                                    <img src="/static/images/countries/pl.png" class="countryflag" />
                                    Poland
                                </a>

                            </td>
                            <td>5634</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Jiewa (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Abuget%202016%20-%20SF5">Abuget 2016 - SF5</a></td>
                            <td>2016-10-01</td>
                            <td>

                                <a href="/rankings/tournaments?country=ID">
                                    <img src="/static/images/countries/id.png" class="countryflag" />
                                    Indonesia
                                </a>

                            </td>
                            <td>3962</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>GO1 (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/SEAM%202016%20-%20SF5">SEAM 2016 - SF5</a></td>
                            <td>2016-10-07</td>
                            <td>

                                <a href="/rankings/tournaments?country=SG">
                                    <img src="/static/images/countries/sg.png" class="countryflag" />
                                    Singapore
                                </a>

                            </td>
                            <td>10039</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>Tokido (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/The%20Fall%20Classic%202016%20-%20SF5">The Fall Classic 2016 - SF5</a></td>
                            <td>2016-10-07</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>4744</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>PR Balrog (Northern America)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Geek%20Weekend%20-%20SF5">Geek Weekend - SF5</a></td>
                            <td>2016-10-07</td>
                            <td>

                                <a href="/rankings/tournaments?country=AE">
                                    <img src="/static/images/countries/ae.png" class="countryflag" />
                                    United Arab Emirates
                                </a>

                            </td>
                            <td>2387</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Big Bird (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Liga%20Official%20PS%202016%20-%20SF5">Liga Official PS 2016 - SF5</a></td>
                            <td>2016-10-08</td>
                            <td>

                                <a href="/rankings/tournaments?country=ES">
                                    <img src="/static/images/countries/es.png" class="countryflag" />
                                    Spain
                                </a>

                            </td>
                            <td>2675</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>TKR (Europe)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/SCR%202016%20-%20SF5">SCR 2016 - SF5</a></td>
                            <td>2016-10-14</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>9943</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>Xiaohai (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%20Regional%20Finals%20EU%202016%20-%20SF5">CPT Regional Finals EU 2016 - SF5</a></td>
                            <td>2016-10-15</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>8475</td>
                            <td>
                                Regional Final
                            </td>
                            <td>Daigo Umehara (Global)</td>
                            <td>0</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/FV%20Cup%202016%20-%20SF5">FV Cup 2016 - SF5</a></td>
                            <td>2016-10-22</td>
                            <td>

                                <a href="/rankings/tournaments?country=MY">
                                    <img src="/static/images/countries/my.png" class="countryflag" />
                                    Malaysia
                                </a>

                            </td>
                            <td>5959</td>
                            <td>
                                Ranking Tournament
                            </td>
                            <td>Sako (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%202016%20AO%20Online%20Ranking%20Event%202%20-%20SF5">CPT 2016 AO Online Ranking Event 2 - SF5</a></td>
                            <td>2016-10-22</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>6962</td>
                            <td>
                                Online Event
                            </td>
                            <td>MOV (Asia)</td>
                            <td>128</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Canada%20Cup%202016%20-%20SF5">Canada Cup 2016 - SF5</a></td>
                            <td>2016-10-28</td>
                            <td>

                                <a href="/rankings/tournaments?country=CA">
                                    <img src="/static/images/countries/ca.png" class="countryflag" />
                                    Canada
                                </a>

                            </td>
                            <td>9877</td>
                            <td>
                                Premier Tournament
                            </td>
                            <td>NuckleDu (Global)</td>
                            <td>256</td>
                            <td>7000</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%20Regional%20Finals%20AO%202016%20-%20SF5">CPT Regional Finals AO 2016 - SF5</a></td>
                            <td>2016-10-31</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>9729</td>
                            <td>
                                Regional Final
                            </td>
                            <td>Mago (Global)</td>
                            <td>0</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%20Regional%20Finals%20LA%202016%20-%20SF5">CPT Regional Finals LA 2016 - SF5</a></td>
                            <td>2016-10-31</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>5016</td>
                            <td>
                                Regional Final
                            </td>
                            <td>DR Ray (Global)</td>
                            <td>0</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/CPT%20Regional%20Finals%20NA%202016%20-%20SF5">CPT Regional Finals NA 2016 - SF5</a></td>
                            <td>2016-10-31</td>
                            <td>

                                <a href="/rankings/tournaments?country=NONE">
                                    <img src="/static/images/countries/none.png" class="countryflag" />
                                    Not Applicable
                                </a>

                            </td>
                            <td>7870</td>
                            <td>
                                Regional Final
                            </td>
                            <td>NuckleDu (Global)</td>
                            <td>0</td>
                            <td>0</td>
                        </tr>

                        <tr>
                            <td><a href="/rankings/tournament/byname/Capcom%20Cup%20Finals%202016%20-%20SF5">Capcom Cup Finals 2016 - SF5</a></td>
                            <td>2016-12-04</td>
                            <td>

                                <a href="/rankings/tournaments?country=US">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    United States
                                </a>

                            </td>
                            <td>10750</td>
                            <td>
                                Capcom Cup
                            </td>
                            <td></td>
                            <td>0</td>
                            <td>120000</td>
                        </tr>


                    </table>
                    A total of <strong>11008 points </strong>could be scored and <strong>16 direct places </strong>were granted

                </div>



                <h3 class="tournament"><small>Qualifying listed players by country</small></h3>
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
                            <td>DO</td>
                            <td>1</td>
                            <td>DR Ray</td>
                        </tr>

                        <tr>
                            <td>HK</td>
                            <td>1</td>
                            <td>Tse4444</td>
                        </tr>

                        <tr>
                            <td>JP</td>
                            <td>12</td>
                            <td>Sako, Yukadon, Kazunoko, GO1, Mago, Eita, Haitani, Momochi, Daigo Umehara, MOV, Fuudo, Tokido</td>
                        </tr>

                        <tr>
                            <td>US</td>
                            <td>7</td>
                            <td>XsK Samurai, Ricki Ortiz, Chris Tatarian, Filipino Champ, Julio Fuentes, NuckleDu, Justin Wong</td>
                        </tr>

                        <tr>
                            <td>CL</td>
                            <td>1</td>
                            <td>Misterio</td>
                        </tr>

                        <tr>
                            <td>GB</td>
                            <td>2</td>
                            <td>Problem X, Ryan Hart</td>
                        </tr>

                        <tr>
                            <td>BR</td>
                            <td>1</td>
                            <td>Brolynho</td>
                        </tr>

                        <tr>
                            <td>FR</td>
                            <td>2</td>
                            <td>Mister Crimson, Luffy</td>
                        </tr>

                        <tr>
                            <td>BE</td>
                            <td>1</td>
                            <td>CCL</td>
                        </tr>

                        <tr>
                            <td>SG</td>
                            <td>1</td>
                            <td>Xian</td>
                        </tr>

                        <tr>
                            <td>NO</td>
                            <td>1</td>
                            <td>Phenom</td>
                        </tr>

                        <tr>
                            <td>TW</td>
                            <td>1</td>
                            <td>GamerBee</td>
                        </tr>

                        <tr>
                            <td>CN</td>
                            <td>1</td>
                            <td>Xiaohai</td>
                        </tr>

                        <tr>
                            <td>KR</td>
                            <td>1</td>
                            <td>Infiltration</td>
                        </tr>

                    </table>
                </div>

                See the <a href="/rankings/cptCharacterStats">CPT character stats </a> page for more info on qualifying players. Currently -1 spots are not known yet.


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
                            <td>KR</td>
                            <td>7</td>
                        </tr>

                        <tr>
                            <td>JP</td>
                            <td>38</td>
                        </tr>

                        <tr>
                            <td>US</td>
                            <td>86</td>
                        </tr>

                        <tr>
                            <td>CN</td>
                            <td>13</td>
                        </tr>

                        <tr>
                            <td>TW</td>
                            <td>5</td>
                        </tr>

                        <tr>
                            <td>NO</td>
                            <td>3</td>
                        </tr>

                        <tr>
                            <td>SG</td>
                            <td>8</td>
                        </tr>

                        <tr>
                            <td>FR</td>
                            <td>19</td>
                        </tr>

                        <tr>
                            <td>BE</td>
                            <td>2</td>
                        </tr>

                        <tr>
                            <td>BR</td>
                            <td>38</td>
                        </tr>

                        <tr>
                            <td>GB</td>
                            <td>17</td>
                        </tr>

                        <tr>
                            <td>CL</td>
                            <td>10</td>
                        </tr>

                        <tr>
                            <td>MX</td>
                            <td>19</td>
                        </tr>

                        <tr>
                            <td>HK</td>
                            <td>4</td>
                        </tr>

                        <tr>
                            <td>DO</td>
                            <td>10</td>
                        </tr>

                        <tr>
                            <td>IE</td>
                            <td>3</td>
                        </tr>

                        <tr>
                            <td>AE</td>
                            <td>11</td>
                        </tr>

                        <tr>
                            <td>TH</td>
                            <td>4</td>
                        </tr>

                        <tr>
                            <td>DE</td>
                            <td>4</td>
                        </tr>

                        <tr>
                            <td>AR</td>
                            <td>9</td>
                        </tr>

                        <tr>
                            <td>VN</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>PE</td>
                            <td>8</td>
                        </tr>

                        <tr>
                            <td>MY</td>
                            <td>4</td>
                        </tr>

                        <tr>
                            <td>PY</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>NL</td>
                            <td>4</td>
                        </tr>

                        <tr>
                            <td>AU</td>
                            <td>15</td>
                        </tr>

                        <tr>
                            <td>RU</td>
                            <td>8</td>
                        </tr>

                        <tr>
                            <td>PT</td>
                            <td>6</td>
                        </tr>

                        <tr>
                            <td>ES</td>
                            <td>10</td>
                        </tr>

                        <tr>
                            <td>PR</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>CO</td>
                            <td>7</td>
                        </tr>

                        <tr>
                            <td>CR</td>
                            <td>4</td>
                        </tr>

                        <tr>
                            <td>ID</td>
                            <td>4</td>
                        </tr>

                        <tr>
                            <td>CA</td>
                            <td>7</td>
                        </tr>

                        <tr>
                            <td>SE</td>
                            <td>2</td>
                        </tr>

                        <tr>
                            <td>PA</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>PH</td>
                            <td>2</td>
                        </tr>

                        <tr>
                            <td>NZ</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>PL</td>
                            <td>1</td>
                        </tr>

                        <tr>
                            <td>IT</td>
                            <td>3</td>
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
                                condensed: true})
                        })
                    });

                </script>


                <br/>


                <div class="footer">
                    <div class="row">
                        <div class="col-md-6">
                            <p class="large">Street Fighter World Rankings &copy; 2013-2016 Bavo Bruylandt</p>
                        </div>

                        <div class="col-md-2">
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

                        <div class="col-md-2">
                            <div class="fb-like" data-href="https://www.facebook.com/fgcworldranking" data-layout="button_count" data-action="like" data-size="small" data-show-faces="false" data-share="false"></div>
                        </div>
                        <div class="col-md-2">
                            <div class="fb-share-button" data-href="http://rank.shoryuken.com/" data-type="button_count"></div>
                        </div>
                    </div>


                    <p>Developed by <a href="https://twitter.com/bavobbr">Bavo Bruylandt</a> &middot; Hosted on <a
                            href="http://www.shoryuken.com">Shoryuken</a>  &middot;
                        Bootstrap mods by <a href="http://www.kineda.com">Kineda</a> &middot; Twitter at <a
                            href="https://twitter.com/SRKRanking">@SRK Ranking</a></p>

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