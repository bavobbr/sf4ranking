
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
                
<h2>Character Statistics in Capcom Pro Tour 2015</h2>
Statistics drawn from past Capcom Pro Tour tournaments. They reflect the characters we will likely see in the Capcom Cup finals and who plays them, as well as overall statistics on what characters were used to compete in the Capcom Pro Tour.



    <h3 class="tournament">Main character usage of top32</h3>
    <div class="table-responsive">
        <table class="tablehead" id="datatable2">
            <thead>
            <tr class="stathead">
                <th>Character</th>
                <th>Occurence</th>
                <th>Used by</th>
            </tr>
            </thead>
            
                <tr>
                    <td>Ken</td>
                    <td>2</td>
                    <td>Momochi, Dark Jiewa</td>
                </tr>
            
                <tr>
                    <td>Akuma</td>
                    <td>2</td>
                    <td>Infiltration, Tokido</td>
                </tr>
            
                <tr>
                    <td>Sagat</td>
                    <td>1</td>
                    <td>Bonchan</td>
                </tr>
            
                <tr>
                    <td>Gen</td>
                    <td>1</td>
                    <td>Xian</td>
                </tr>
            
                <tr>
                    <td>Adon</td>
                    <td>1</td>
                    <td>GamerBee</td>
                </tr>
            
                <tr>
                    <td>Rose</td>
                    <td>1</td>
                    <td>Luffy</td>
                </tr>
            
                <tr>
                    <td>Fei Long</td>
                    <td>2</td>
                    <td>Fuudo, Gackt</td>
                </tr>
            
                <tr>
                    <td>Yang</td>
                    <td>1</td>
                    <td>Mago</td>
                </tr>
            
                <tr>
                    <td>Evil Ryu</td>
                    <td>3</td>
                    <td>Daigo Umehara, Xiaohai, Dakou</td>
                </tr>
            
                <tr>
                    <td>Yun</td>
                    <td>1</td>
                    <td>Kazunoko</td>
                </tr>
            
                <tr>
                    <td>Rolento</td>
                    <td>2</td>
                    <td>Nemo, RB</td>
                </tr>
            
                <tr>
                    <td>Seth</td>
                    <td>2</td>
                    <td>Poongko, Dashio</td>
                </tr>
            
                <tr>
                    <td>Abel</td>
                    <td>3</td>
                    <td>Keoma, 801 Strider, Shiro</td>
                </tr>
            
                <tr>
                    <td>Zangief</td>
                    <td>2</td>
                    <td>Snake Eyez, Itabashi Zangief</td>
                </tr>
            
                <tr>
                    <td>Rufus</td>
                    <td>1</td>
                    <td>Justin Wong</td>
                </tr>
            
                <tr>
                    <td>C. Viper</td>
                    <td>2</td>
                    <td>Tonpy, Problem X</td>
                </tr>
            
                <tr>
                    <td>Guile</td>
                    <td>2</td>
                    <td>NuckleDu, Dieminion</td>
                </tr>
            
                <tr>
                    <td>Sakura</td>
                    <td>1</td>
                    <td>HumanBomb</td>
                </tr>
            
                <tr>
                    <td>Chun-Li</td>
                    <td>1</td>
                    <td>Valmaster</td>
                </tr>
            
                <tr>
                    <td>Makoto</td>
                    <td>1</td>
                    <td>Misse</td>
                </tr>
            
        </table>
    </div>
    A total of <b>20 </b>have been used as main by the current best 32 CPT players.  <br/>
    Characters not used as main are: <b>Not identified, Balrog, Blanka, Cammy, Cody, Dan, Dee Jay, Dhalsim, Dudley, Honda, Fuerte, Gouken, Guy, Hakan, Ibuki, Juri, M. Bison, Oni, Ryu, T. Hawk, Claw, Hugo, Elena, Decapre, Poison</b>



    <h3 class="tournament">All character usages of top32</h3>
    <div class="table-responsive">
        <table class="tablehead" id="datatable5">
            <thead>
            <tr class="stathead">
                <th>Character</th>
                <th>Occurence</th>
                <th>Used by</th>
            </tr>
            </thead>
            
                <tr>
                    <td>Ken</td>
                    <td>4</td>
                    <td>Momochi, Dark Jiewa, Dakou, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Evil Ryu</td>
                    <td>6</td>
                    <td>Xiaohai, Daigo Umehara, Momochi, Dakou, Snake Eyez, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Guy</td>
                    <td>3</td>
                    <td>RB, Momochi, Dakou</td>
                </tr>
            
                <tr>
                    <td>Elena</td>
                    <td>7</td>
                    <td>Justin Wong, Xiaohai, Momochi, Tokido, Xian, Infiltration, GamerBee</td>
                </tr>
            
                <tr>
                    <td>Decapre</td>
                    <td>3</td>
                    <td>NuckleDu, Nemo, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Chun-Li</td>
                    <td>2</td>
                    <td>Valmaster, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Akuma</td>
                    <td>4</td>
                    <td>NuckleDu, Tokido, Dakou, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Gouken</td>
                    <td>1</td>
                    <td>Infiltration</td>
                </tr>
            
                <tr>
                    <td>Abel</td>
                    <td>4</td>
                    <td>Keoma, 801 Strider, Shiro, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Hakan</td>
                    <td>1</td>
                    <td>Infiltration</td>
                </tr>
            
                <tr>
                    <td>Juri</td>
                    <td>2</td>
                    <td>Dieminion, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Rolento</td>
                    <td>4</td>
                    <td>RB, Nemo, Dieminion, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Hugo</td>
                    <td>3</td>
                    <td>RB, Tokido, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Ryu</td>
                    <td>5</td>
                    <td>HumanBomb, Gackt, Daigo Umehara, Dakou, Infiltration</td>
                </tr>
            
                <tr>
                    <td>Sagat</td>
                    <td>5</td>
                    <td>Gackt, Xiaohai, Bonchan, Xian, Fuudo</td>
                </tr>
            
                <tr>
                    <td>Yun</td>
                    <td>4</td>
                    <td>Kazunoko, Xiaohai, Bonchan, GamerBee</td>
                </tr>
            
                <tr>
                    <td>Gen</td>
                    <td>1</td>
                    <td>Xian</td>
                </tr>
            
                <tr>
                    <td>Poison</td>
                    <td>2</td>
                    <td>HumanBomb, Xian</td>
                </tr>
            
                <tr>
                    <td>Dhalsim</td>
                    <td>2</td>
                    <td>Xian, Problem X</td>
                </tr>
            
                <tr>
                    <td>Adon</td>
                    <td>2</td>
                    <td>Justin Wong, GamerBee</td>
                </tr>
            
                <tr>
                    <td>Rose</td>
                    <td>2</td>
                    <td>Justin Wong, Luffy</td>
                </tr>
            
                <tr>
                    <td>Fei Long</td>
                    <td>3</td>
                    <td>Mago, Gackt, Fuudo</td>
                </tr>
            
                <tr>
                    <td>Seth</td>
                    <td>4</td>
                    <td>Dashio, Poongko, Problem X, Fuudo</td>
                </tr>
            
                <tr>
                    <td>Yang</td>
                    <td>2</td>
                    <td>HumanBomb, Mago</td>
                </tr>
            
                <tr>
                    <td>Fuerte</td>
                    <td>1</td>
                    <td>Poongko</td>
                </tr>
            
                <tr>
                    <td>Zangief</td>
                    <td>3</td>
                    <td>Itabashi Zangief, Problem X, Snake Eyez</td>
                </tr>
            
                <tr>
                    <td>Cammy</td>
                    <td>2</td>
                    <td>Xiaohai, Dakou</td>
                </tr>
            
                <tr>
                    <td>Rufus</td>
                    <td>1</td>
                    <td>Justin Wong</td>
                </tr>
            
                <tr>
                    <td>C. Viper</td>
                    <td>2</td>
                    <td>Tonpy, Problem X</td>
                </tr>
            
                <tr>
                    <td>Guile</td>
                    <td>2</td>
                    <td>NuckleDu, Dieminion</td>
                </tr>
            
                <tr>
                    <td>Ibuki</td>
                    <td>1</td>
                    <td>NuckleDu</td>
                </tr>
            
                <tr>
                    <td>Sakura</td>
                    <td>1</td>
                    <td>HumanBomb</td>
                </tr>
            
                <tr>
                    <td>Makoto</td>
                    <td>1</td>
                    <td>Misse</td>
                </tr>
            
        </table>
    </div>
    A total of <b>20 </b>have been used as main by the current best 32 CPT players. <br/>
    Characters not used at all are: <b>Not identified, Balrog, Blanka, Cody, Dan, Dee Jay, Dudley, Honda, M. Bison, Oni, T. Hawk, Claw</b>




    <h3 class="tournament">Characters used by top 32 players</h3>
    <div class="table-responsive">
        <table class="tablehead" id="datatable4">
            <thead>
            <tr class="stathead">
                <th>Player</th>
                <th>Number</th>
                <th>Characters</th>
            </tr>
            </thead>
            
                <tr>
                    <td>Infiltration</td>
                    <td>13</td>
                    <td><b>Decapre</b> (12), <b>Akuma</b> (9), <b>Chun-Li</b> (4), <b>Gouken</b> (3), <b>Ryu</b> (3), <b>Abel</b> (2), <b>Elena</b> (2), <b>Rolento</b> (2), <b>Hugo</b> (2), <b>Hakan</b> (1), <b>Juri</b> (1), <b>Evil Ryu</b> (1), <b>Ken</b> (1)</td>
                </tr>
            
                <tr>
                    <td>Dakou</td>
                    <td>6</td>
                    <td><b>Evil Ryu</b> (8), <b>Akuma</b> (2), <b>Ken</b> (1), <b>Guy</b> (1), <b>Ryu</b> (1), <b>Cammy</b> (1)</td>
                </tr>
            
                <tr>
                    <td>Xiaohai</td>
                    <td>5</td>
                    <td><b>Evil Ryu</b> (11), <b>Cammy</b> (9), <b>Sagat</b> (3), <b>Elena</b> (2), <b>Yun</b> (2)</td>
                </tr>
            
                <tr>
                    <td>Xian</td>
                    <td>5</td>
                    <td><b>Gen</b> (12), <b>Elena</b> (7), <b>Poison</b> (3), <b>Sagat</b> (1), <b>Dhalsim</b> (1)</td>
                </tr>
            
                <tr>
                    <td>Problem X</td>
                    <td>4</td>
                    <td><b>C. Viper</b> (9), <b>Seth</b> (9), <b>Dhalsim</b> (2), <b>Zangief</b> (1)</td>
                </tr>
            
                <tr>
                    <td>HumanBomb</td>
                    <td>4</td>
                    <td><b>Sakura</b> (12), <b>Poison</b> (2), <b>Ryu</b> (2), <b>Yang</b> (1)</td>
                </tr>
            
                <tr>
                    <td>NuckleDu</td>
                    <td>4</td>
                    <td><b>Guile</b> (12), <b>Decapre</b> (9), <b>Ibuki</b> (1), <b>Akuma</b> (1)</td>
                </tr>
            
                <tr>
                    <td>Justin Wong</td>
                    <td>4</td>
                    <td><b>Rose</b> (5), <b>Rufus</b> (4), <b>Elena</b> (4), <b>Adon</b> (1)</td>
                </tr>
            
                <tr>
                    <td>Momochi</td>
                    <td>4</td>
                    <td><b>Ken</b> (9), <b>Evil Ryu</b> (5), <b>Guy</b> (2), <b>Elena</b> (2)</td>
                </tr>
            
                <tr>
                    <td>Gackt</td>
                    <td>3</td>
                    <td><b>Fei Long</b> (6), <b>Sagat</b> (3), <b>Ryu</b> (2)</td>
                </tr>
            
                <tr>
                    <td>Dieminion</td>
                    <td>3</td>
                    <td><b>Guile</b> (9), <b>Rolento</b> (1), <b>Juri</b> (1)</td>
                </tr>
            
                <tr>
                    <td>RB</td>
                    <td>3</td>
                    <td><b>Rolento</b> (5), <b>Hugo</b> (3), <b>Guy</b> (3)</td>
                </tr>
            
                <tr>
                    <td>Fuudo</td>
                    <td>3</td>
                    <td><b>Fei Long</b> (15), <b>Seth</b> (2), <b>Sagat</b> (1)</td>
                </tr>
            
                <tr>
                    <td>Tokido</td>
                    <td>3</td>
                    <td><b>Akuma</b> (13), <b>Elena</b> (1), <b>Hugo</b> (1)</td>
                </tr>
            
                <tr>
                    <td>GamerBee</td>
                    <td>3</td>
                    <td><b>Elena</b> (10), <b>Adon</b> (7), <b>Yun</b> (2)</td>
                </tr>
            
                <tr>
                    <td>Snake Eyez</td>
                    <td>2</td>
                    <td><b>Zangief</b> (13), <b>Evil Ryu</b> (4)</td>
                </tr>
            
                <tr>
                    <td>Poongko</td>
                    <td>2</td>
                    <td><b>Seth</b> (11), <b>Fuerte</b> (5)</td>
                </tr>
            
                <tr>
                    <td>Nemo</td>
                    <td>2</td>
                    <td><b>Rolento</b> (6), <b>Decapre</b> (1)</td>
                </tr>
            
                <tr>
                    <td>Daigo Umehara</td>
                    <td>2</td>
                    <td><b>Evil Ryu</b> (8), <b>Ryu</b> (1)</td>
                </tr>
            
                <tr>
                    <td>Mago</td>
                    <td>2</td>
                    <td><b>Yang</b> (9), <b>Fei Long</b> (3)</td>
                </tr>
            
                <tr>
                    <td>Bonchan</td>
                    <td>2</td>
                    <td><b>Sagat</b> (15), <b>Yun</b> (1)</td>
                </tr>
            
                <tr>
                    <td>Misse</td>
                    <td>1</td>
                    <td><b>Makoto</b> (10)</td>
                </tr>
            
                <tr>
                    <td>Valmaster</td>
                    <td>1</td>
                    <td><b>Chun-Li</b> (7)</td>
                </tr>
            
                <tr>
                    <td>Shiro</td>
                    <td>1</td>
                    <td><b>Abel</b> (13)</td>
                </tr>
            
                <tr>
                    <td>Dark Jiewa</td>
                    <td>1</td>
                    <td><b>Ken</b> (13)</td>
                </tr>
            
                <tr>
                    <td>801 Strider</td>
                    <td>1</td>
                    <td><b>Abel</b> (11)</td>
                </tr>
            
                <tr>
                    <td>Tonpy</td>
                    <td>1</td>
                    <td><b>C. Viper</b> (11)</td>
                </tr>
            
                <tr>
                    <td>Itabashi Zangief</td>
                    <td>1</td>
                    <td><b>Zangief</b> (16)</td>
                </tr>
            
                <tr>
                    <td>Keoma</td>
                    <td>1</td>
                    <td><b>Abel</b> (3)</td>
                </tr>
            
                <tr>
                    <td>Dashio</td>
                    <td>1</td>
                    <td><b>Seth</b> (3)</td>
                </tr>
            
                <tr>
                    <td>Kazunoko</td>
                    <td>1</td>
                    <td><b>Yun</b> (12)</td>
                </tr>
            
                <tr>
                    <td>Luffy</td>
                    <td>1</td>
                    <td><b>Rose</b> (11)</td>
                </tr>
            
        </table>
    </div>



    <h3 class="tournament">Characters in all CPT tournaments by all players</h3>
    <div class="table-responsive">
        <table class="tablehead" id="datatable3">
            <thead>
            <tr class="stathead">
                <th>Character</th>
                <th>Occurence</th>
            </tr>
            </thead>
            
                <tr>
                    <td>C. Viper</td>
                    <td>49</td>
                </tr>
            
                <tr>
                    <td>Akuma</td>
                    <td>47</td>
                </tr>
            
                <tr>
                    <td>Guile</td>
                    <td>42</td>
                </tr>
            
                <tr>
                    <td>Gen</td>
                    <td>19</td>
                </tr>
            
                <tr>
                    <td>Elena</td>
                    <td>55</td>
                </tr>
            
                <tr>
                    <td>Evil Ryu</td>
                    <td>65</td>
                </tr>
            
                <tr>
                    <td>Chun-Li</td>
                    <td>32</td>
                </tr>
            
                <tr>
                    <td>Hugo</td>
                    <td>32</td>
                </tr>
            
                <tr>
                    <td>Rose</td>
                    <td>38</td>
                </tr>
            
                <tr>
                    <td>T. Hawk</td>
                    <td>16</td>
                </tr>
            
                <tr>
                    <td>M. Bison</td>
                    <td>43</td>
                </tr>
            
                <tr>
                    <td>Ibuki</td>
                    <td>30</td>
                </tr>
            
                <tr>
                    <td>Seth</td>
                    <td>47</td>
                </tr>
            
                <tr>
                    <td>Fuerte</td>
                    <td>38</td>
                </tr>
            
                <tr>
                    <td>Juri</td>
                    <td>17</td>
                </tr>
            
                <tr>
                    <td>Yun</td>
                    <td>56</td>
                </tr>
            
                <tr>
                    <td>Makoto</td>
                    <td>19</td>
                </tr>
            
                <tr>
                    <td>Sakura</td>
                    <td>30</td>
                </tr>
            
                <tr>
                    <td>Decapre</td>
                    <td>51</td>
                </tr>
            
                <tr>
                    <td>Cammy</td>
                    <td>41</td>
                </tr>
            
                <tr>
                    <td>Honda</td>
                    <td>15</td>
                </tr>
            
                <tr>
                    <td>Sagat</td>
                    <td>62</td>
                </tr>
            
                <tr>
                    <td>Abel</td>
                    <td>54</td>
                </tr>
            
                <tr>
                    <td>Ryu</td>
                    <td>30</td>
                </tr>
            
                <tr>
                    <td>Claw</td>
                    <td>19</td>
                </tr>
            
                <tr>
                    <td>Fei Long</td>
                    <td>48</td>
                </tr>
            
                <tr>
                    <td>Gouken</td>
                    <td>15</td>
                </tr>
            
                <tr>
                    <td>Hakan</td>
                    <td>5</td>
                </tr>
            
                <tr>
                    <td>Rufus</td>
                    <td>44</td>
                </tr>
            
                <tr>
                    <td>Poison</td>
                    <td>37</td>
                </tr>
            
                <tr>
                    <td>Ken</td>
                    <td>44</td>
                </tr>
            
                <tr>
                    <td>Zangief</td>
                    <td>40</td>
                </tr>
            
                <tr>
                    <td>Rolento</td>
                    <td>40</td>
                </tr>
            
                <tr>
                    <td>Dhalsim</td>
                    <td>17</td>
                </tr>
            
                <tr>
                    <td>Oni</td>
                    <td>11</td>
                </tr>
            
                <tr>
                    <td>Blanka</td>
                    <td>16</td>
                </tr>
            
                <tr>
                    <td>Guy</td>
                    <td>25</td>
                </tr>
            
                <tr>
                    <td>Not identified</td>
                    <td>20</td>
                </tr>
            
                <tr>
                    <td>Cody</td>
                    <td>13</td>
                </tr>
            
                <tr>
                    <td>Dudley</td>
                    <td>19</td>
                </tr>
            
                <tr>
                    <td>Balrog</td>
                    <td>21</td>
                </tr>
            
                <tr>
                    <td>Yang</td>
                    <td>16</td>
                </tr>
            
                <tr>
                    <td>Adon</td>
                    <td>23</td>
                </tr>
            
                <tr>
                    <td>Dan</td>
                    <td>2</td>
                </tr>
            
                <tr>
                    <td>Dee Jay</td>
                    <td>8</td>
                </tr>
            
        </table>
    </div>
    A total of <b>45 </b>have been used as main or secondary by all Capcom Pro Tour tournament players.




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