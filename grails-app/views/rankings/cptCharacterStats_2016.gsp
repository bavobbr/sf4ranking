

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Capcom Pro Tour 2016 Player and Character Stats</title>


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

                <h2>Player Statistics in Capcom Pro Tour 2016</h2>
                Statistics drawn from past Capcom Pro Tour tournaments. They reflect the characters we will likely see in the Capcom Cup finals and who plays them, as well as overall statistics on what characters were used to compete in the Capcom Pro Tour.
                <h3 class="tournament">Players in qualifying zones</h3>
                These players will qualify if tournament started today:
                <ul>
                    <li>Players qualified directly: <i>Infiltration, Tokido, NuckleDu, Xiaohai, GamerBee, Daigo Umehara, Phenom, Momochi, Xian, Mago, DR Ray</i></li>
                    <li>Players qualifying by global score: <i>Justin Wong, Fuudo, MOV, Julio Fuentes, Haitani, Eita, Luffy, GO1, Filipino Champ, CCL, Chris Tatarian, Mister Crimson, Kazunoko, Yukadon</i></li>
                    <li>Players qualifying by regional score: <i>Brolynho, Ricki Ortiz, Ryan Hart, Problem X, Misterio, XsK Samurai, Sako, Tse4444</i></li>
                </ul>
                Players that may still win a direct spot:
                <ul>

                    <li>qualified for regional finals Asia: <i>Justin Wong, Xiaohai, GamerBee, MOV, Daigo Umehara, Xian, Haitani, Eita, Mago, GO1, Kazunoko, Sako, Tse4444, Itabashi Zangief</i></li>

                    <li>qualified for regional finals Latin America: <i>Justin Wong, Filipino Champ, Chris Tatarian, K-Brad, Brolynho, Jiewa, Misterio, Will2Pac, KusanagiMX, Dark817, Baek, Crossover, Ericke Maciel, DR Ray</i></li>

                    <li>qualified for regional finals Northern America: <i>Justin Wong, NuckleDu, Julio Fuentes, Filipino Champ, Chris Tatarian, K-Brad, Ricki Ortiz, XsK Samurai, John Takeuchi, PR Balrog, Flash, Alucard, Ludovic, Punk</i></li>

                    <li>qualified for regional finals Europe: <i>MOV, Daigo Umehara, Phenom, Xian, Luffy, CCL, Chris Tatarian, Mister Crimson, Jiewa, Problem X, ImStillDaDaddy, Cobelcog, Big Bird, TKR</i></li>

                </ul>
                Note that in early stages only 'qualified' players are guaranteed. The others are still fighting for points to qualify.

                <h2>Character Statistics in Capcom Pro Tour 2016</h2>


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

                        <tr>
                            <td>Karin</td>
                            <td>3</td>
                            <td>Justin Wong, Mago, Misterio</td>
                        </tr>

                        <tr>
                            <td>Mika</td>
                            <td>2</td>
                            <td>Fuudo, Luffy</td>
                        </tr>

                        <tr>
                            <td>Chun</td>
                            <td>6</td>
                            <td>MOV, GO1, CCL, Ricki Ortiz, Sako, Tse4444</td>
                        </tr>

                        <tr>
                            <td>Ken</td>
                            <td>5</td>
                            <td>Julio Fuentes, Eita, Chris Tatarian, Momochi, Ryan Hart</td>
                        </tr>

                        <tr>
                            <td>Necalli</td>
                            <td>4</td>
                            <td>Haitani, GamerBee, Phenom, Brolynho</td>
                        </tr>

                        <tr>
                            <td>Dhalsim</td>
                            <td>2</td>
                            <td>Filipino Champ, Mister Crimson</td>
                        </tr>

                        <tr>
                            <td>Cammy</td>
                            <td>2</td>
                            <td>Kazunoko, Xiaohai</td>
                        </tr>

                        <tr>
                            <td>Nash</td>
                            <td>2</td>
                            <td>Yukadon, Infiltration</td>
                        </tr>

                        <tr>
                            <td>Akuma</td>
                            <td>1</td>
                            <td>Tokido</td>
                        </tr>

                        <tr>
                            <td>Guile</td>
                            <td>1</td>
                            <td>NuckleDu</td>
                        </tr>

                        <tr>
                            <td>Ryu</td>
                            <td>2</td>
                            <td>Daigo Umehara, XsK Samurai</td>
                        </tr>

                        <tr>
                            <td>FANG</td>
                            <td>1</td>
                            <td>Xian</td>
                        </tr>

                        <tr>
                            <td>Vega</td>
                            <td>1</td>
                            <td>DR Ray</td>
                        </tr>

                        <tr>
                            <td>Birdie</td>
                            <td>1</td>
                            <td>Problem X</td>
                        </tr>

                    </table>
                </div>
                A total of <b>14 </b>have been used as main by the current qualifying 33 CPT players<br/>
                Characters not used as main are: <b>Laura, Bison, Rashid, Gief, Alex, Ibuki, Balrog, Urien, Juri</b>



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

                        <tr>
                            <td>Karin</td>
                            <td>3</td>
                            <td>Justin Wong, Mago, Misterio</td>
                        </tr>

                        <tr>
                            <td>Mika</td>
                            <td>3</td>
                            <td>Luffy, Fuudo, NuckleDu</td>
                        </tr>

                        <tr>
                            <td>Chun</td>
                            <td>7</td>
                            <td>Ricki Ortiz, Momochi, CCL, MOV, Tse4444, Sako, GO1</td>
                        </tr>

                        <tr>
                            <td>Ken</td>
                            <td>5</td>
                            <td>Eita, Momochi, Chris Tatarian, Julio Fuentes, Ryan Hart</td>
                        </tr>

                        <tr>
                            <td>Necalli</td>
                            <td>4</td>
                            <td>Phenom, GamerBee, Haitani, Brolynho</td>
                        </tr>

                        <tr>
                            <td>Dhalsim</td>
                            <td>2</td>
                            <td>Mister Crimson, Filipino Champ</td>
                        </tr>

                        <tr>
                            <td>Nash</td>
                            <td>6</td>
                            <td>Xiaohai, Filipino Champ, Ricki Ortiz, Yukadon, Infiltration, NuckleDu</td>
                        </tr>

                        <tr>
                            <td>Laura</td>
                            <td>1</td>
                            <td>Mister Crimson</td>
                        </tr>

                        <tr>
                            <td>Cammy</td>
                            <td>4</td>
                            <td>Xiaohai, GamerBee, Kazunoko, Misterio</td>
                        </tr>

                        <tr>
                            <td>Rashid</td>
                            <td>1</td>
                            <td>Infiltration</td>
                        </tr>

                        <tr>
                            <td>FANG</td>
                            <td>3</td>
                            <td>Xian, Infiltration, Ryan Hart</td>
                        </tr>

                        <tr>
                            <td>Ryu</td>
                            <td>4</td>
                            <td>Xiaohai, Daigo Umehara, Tokido, XsK Samurai</td>
                        </tr>

                        <tr>
                            <td>Guile</td>
                            <td>3</td>
                            <td>Problem X, NuckleDu, Ryan Hart</td>
                        </tr>

                        <tr>
                            <td>Bison</td>
                            <td>2</td>
                            <td>Phenom, Problem X</td>
                        </tr>

                        <tr>
                            <td>Ibuki</td>
                            <td>2</td>
                            <td>Xian, Brolynho</td>
                        </tr>

                        <tr>
                            <td>Vega</td>
                            <td>2</td>
                            <td>DR Ray, Ryan Hart</td>
                        </tr>

                        <tr>
                            <td>Alex</td>
                            <td>2</td>
                            <td>Problem X, Brolynho</td>
                        </tr>

                        <tr>
                            <td>Gief</td>
                            <td>1</td>
                            <td>Problem X</td>
                        </tr>

                    </table>
                </div>
                A total of <b>14 </b>have been used as main by the current best 33 CPT players. <br/>
                Characters not used at all are: <b>Birdie, Balrog, Urien, Juri, Akuma</b>




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

                        <tr>
                            <td>Problem X</td>
                            <td>4</td>
                            <td><b>Alex</b> (12), <b>Bison</b> (5), <b>Gief</b> (2), <b>Guile</b> (1)</td>
                        </tr>

                        <tr>
                            <td>Ryan Hart</td>
                            <td>4</td>
                            <td><b>Ken</b> (13), <b>Guile</b> (4), <b>Vega</b> (1), <b>FANG</b> (1)</td>
                        </tr>

                        <tr>
                            <td>Brolynho</td>
                            <td>3</td>
                            <td><b>Necalli</b> (6), <b>Ibuki</b> (2), <b>Alex</b> (1)</td>
                        </tr>

                        <tr>
                            <td>Xiaohai</td>
                            <td>3</td>
                            <td><b>Cammy</b> (10), <b>Ryu</b> (2), <b>Nash</b> (1)</td>
                        </tr>

                        <tr>
                            <td>NuckleDu</td>
                            <td>3</td>
                            <td><b>Mika</b> (15), <b>Nash</b> (13), <b>Guile</b> (9)</td>
                        </tr>

                        <tr>
                            <td>Infiltration</td>
                            <td>3</td>
                            <td><b>Nash</b> (8), <b>Rashid</b> (2), <b>FANG</b> (1)</td>
                        </tr>

                        <tr>
                            <td>Misterio</td>
                            <td>2</td>
                            <td><b>Karin</b> (5), <b>Cammy</b> (1)</td>
                        </tr>

                        <tr>
                            <td>Ricki Ortiz</td>
                            <td>2</td>
                            <td><b>Chun</b> (20), <b>Nash</b> (2)</td>
                        </tr>

                        <tr>
                            <td>Xian</td>
                            <td>2</td>
                            <td><b>FANG</b> (17), <b>Ibuki</b> (2)</td>
                        </tr>

                        <tr>
                            <td>Momochi</td>
                            <td>2</td>
                            <td><b>Ken</b> (9), <b>Chun</b> (1)</td>
                        </tr>

                        <tr>
                            <td>Phenom</td>
                            <td>2</td>
                            <td><b>Necalli</b> (10), <b>Bison</b> (6)</td>
                        </tr>

                        <tr>
                            <td>GamerBee</td>
                            <td>2</td>
                            <td><b>Necalli</b> (14), <b>Cammy</b> (1)</td>
                        </tr>

                        <tr>
                            <td>Mister Crimson</td>
                            <td>2</td>
                            <td><b>Dhalsim</b> (13), <b>Laura</b> (9)</td>
                        </tr>

                        <tr>
                            <td>Filipino Champ</td>
                            <td>2</td>
                            <td><b>Dhalsim</b> (15), <b>Nash</b> (2)</td>
                        </tr>

                        <tr>
                            <td>Tse4444</td>
                            <td>1</td>
                            <td><b>Chun</b> (4)</td>
                        </tr>

                        <tr>
                            <td>Sako</td>
                            <td>1</td>
                            <td><b>Chun</b> (9)</td>
                        </tr>

                        <tr>
                            <td>XsK Samurai</td>
                            <td>1</td>
                            <td><b>Ryu</b> (12)</td>
                        </tr>

                        <tr>
                            <td>DR Ray</td>
                            <td>1</td>
                            <td><b>Vega</b> (6)</td>
                        </tr>

                        <tr>
                            <td>Mago</td>
                            <td>1</td>
                            <td><b>Karin</b> (15)</td>
                        </tr>

                        <tr>
                            <td>Daigo Umehara</td>
                            <td>1</td>
                            <td><b>Ryu</b> (15)</td>
                        </tr>

                        <tr>
                            <td>Tokido</td>
                            <td>1</td>
                            <td><b>Ryu</b> (13)</td>
                        </tr>

                        <tr>
                            <td>Yukadon</td>
                            <td>1</td>
                            <td><b>Nash</b> (11)</td>
                        </tr>

                        <tr>
                            <td>Kazunoko</td>
                            <td>1</td>
                            <td><b>Cammy</b> (17)</td>
                        </tr>

                        <tr>
                            <td>Chris Tatarian</td>
                            <td>1</td>
                            <td><b>Ken</b> (14)</td>
                        </tr>

                        <tr>
                            <td>CCL</td>
                            <td>1</td>
                            <td><b>Chun</b> (11)</td>
                        </tr>

                        <tr>
                            <td>GO1</td>
                            <td>1</td>
                            <td><b>Chun</b> (17)</td>
                        </tr>

                        <tr>
                            <td>Luffy</td>
                            <td>1</td>
                            <td><b>Mika</b> (15)</td>
                        </tr>

                        <tr>
                            <td>Eita</td>
                            <td>1</td>
                            <td><b>Ken</b> (17)</td>
                        </tr>

                        <tr>
                            <td>Haitani</td>
                            <td>1</td>
                            <td><b>Necalli</b> (19)</td>
                        </tr>

                        <tr>
                            <td>Julio Fuentes</td>
                            <td>1</td>
                            <td><b>Ken</b> (18)</td>
                        </tr>

                        <tr>
                            <td>MOV</td>
                            <td>1</td>
                            <td><b>Chun</b> (13)</td>
                        </tr>

                        <tr>
                            <td>Fuudo</td>
                            <td>1</td>
                            <td><b>Mika</b> (8)</td>
                        </tr>

                        <tr>
                            <td>Justin Wong</td>
                            <td>1</td>
                            <td><b>Karin</b> (16)</td>
                        </tr>

                    </table>
                </div>



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

                        <tr>
                            <td>Ryu</td>
                            <td>175</td>
                        </tr>

                        <tr>
                            <td>Cammy</td>
                            <td>147</td>
                        </tr>

                        <tr>
                            <td>Bison</td>
                            <td>92</td>
                        </tr>

                        <tr>
                            <td>Ken</td>
                            <td>178</td>
                        </tr>

                        <tr>
                            <td>Nash</td>
                            <td>168</td>
                        </tr>

                        <tr>
                            <td>Laura</td>
                            <td>93</td>
                        </tr>

                        <tr>
                            <td>Vega</td>
                            <td>98</td>
                        </tr>

                        <tr>
                            <td>FANG</td>
                            <td>70</td>
                        </tr>

                        <tr>
                            <td>Chun</td>
                            <td>232</td>
                        </tr>

                        <tr>
                            <td>Birdie</td>
                            <td>81</td>
                        </tr>

                        <tr>
                            <td>Necalli</td>
                            <td>168</td>
                        </tr>

                        <tr>
                            <td>Karin</td>
                            <td>141</td>
                        </tr>

                        <tr>
                            <td>Dhalsim</td>
                            <td>105</td>
                        </tr>

                        <tr>
                            <td>Rashid</td>
                            <td>61</td>
                        </tr>

                        <tr>
                            <td>Gief</td>
                            <td>58</td>
                        </tr>

                        <tr>
                            <td>Mika</td>
                            <td>108</td>
                        </tr>

                        <tr>
                            <td>Not identified</td>
                            <td>193</td>
                        </tr>

                        <tr>
                            <td>Alex</td>
                            <td>49</td>
                        </tr>

                        <tr>
                            <td>Guile</td>
                            <td>48</td>
                        </tr>

                        <tr>
                            <td>Balrog</td>
                            <td>24</td>
                        </tr>

                        <tr>
                            <td>Ibuki</td>
                            <td>11</td>
                        </tr>

                        <tr>
                            <td>Juri</td>
                            <td>9</td>
                        </tr>

                        <tr>
                            <td>Urien</td>
                            <td>6</td>
                        </tr>

                    </table>
                </div>
                A total of <b>23 </b>have been used as main or secondary by all Capcom Pro Tour 2016 tournament players.




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