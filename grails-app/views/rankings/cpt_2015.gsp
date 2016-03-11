
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Capcom Pro Tour Rankings 2015 - Ultra SF4</title>
    

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
                            <li class="divider"></li>
                            <li><a href="/rankings/rank/USF4">World Rankings Ultra SF4</a></li>
                            <li><a href="/rankings/rank/SF5">World Rankings Street Fighter 5</a></li>
                            <li><a href="/rankings/rank/MKX">World Rankings Mortal Kombat X</a></li>
                            <li><a href="/rankings/rank/UMVC3">World Rankings Marvel vs Capcom 3</a></li>
                            <li><a href="/rankings/rank/KI">World Rankings Killer Instinct</a></li>
                            <li><a href="/rankings/rank/SKULLGIRLS">World Rankings Skullgirls</a></li>
                            <li><a href="/rankings/rank/IGAU">World Rankings Injustice</a></li>
                            <li><a href="/rankings/rank/BBCP">World Rankings Blazblue CP</a></li>
                            <li class="divider"></li>
                            <li><a href="/rankings/rank/AE2012">World Rankings SF4:AE 2012</a></li>
                            <li><a href="/rankings/rank/AE">World Rankings SF4:AE</a></li>
                            <li><a href="/rankings/rank/SUPER">World Rankings SSF4</a></li>
                            <li><a href="/rankings/rank/VANILLA">World Rankings SF4</a></li>
                            <li class="divider"></li>
                            <li><a href="/rankings/teams">View All Player Teams</a></li>
                            <li class="divider"></li>
                            <li><a href="/stats/index">Character Usage Statistics</a></li>

                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">TOURNAMENTS <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/rankings/tournaments/USF4">USF4</a></li>
                            <li><a href="/rankings/tournaments/SF5">Street Fighter 5</a></li>
                            <li><a href="/rankings/tournaments/MKX">Mortal Kombat X</a></li>
                            <li><a href="/rankings/tournaments/UMVC3">Marvel vs Capcom 3</a></li>
                            <li><a href="/rankings/tournaments/KI">Killer Instinct</a></li>
                            <li><a href="/rankings/tournaments/SKULLGIRLS">Skullgirls</a></li>
                            <li><a href="/rankings/tournaments/IGAU">Injustice</a></li>
                            <li><a href="/rankings/tournaments/BBCP">Blazblue CP</a></li>
                            <li class="divider"></li>
                            <li><a href="/rankings/tournaments/AE2012">SF4:AE 2012</a></li>
                            <li><a href="/rankings/tournaments/AE">SF4:AE</a></li>
                            <li><a href="/rankings/tournaments/SUPER">SSF4</a></li>
                            <li><a href="/rankings/tournaments/VANILLA">SF4</a></li>
                            <li class="divider"></li>
                            <li><a href="/rankings/tournaments">View All Tournaments</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">SUBMIT <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                            <a href="/submit/index">Submit new tournament</a></li>
                            <li>
                            <a href="/submit/list">List submitted tournaments</a></li>
                            <li class="divider"></li>
                            <li><a href="http://forums.shoryuken.com/discussion/187561/sf4-ae-world-ranking-site-has-been-beta-released">Join Rank Discussion</a>
                            </li>
                        </ul>
                    </li>
                    <li><a href="/about/index">FAQ</a></li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">CAPCOM PRO TOUR <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/rankings/cpt">Standings 2015</a></li>
                            <li><a href="/rankings/cptStats">Tournaments and countries 2015</a></li>
                            <li><a href="/rankings/cptCharacterStats">Characters used 2015</a></li>
                        </ul>
                    </li>
                    <li><a href="/about/sf5">SF5 ORDER GUIDE</a></li>

                    
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">ADMIN <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="/admin/index">[Actions]</a></li>
                                <li><a href="/tournament/index">[Tournaments]</a></li>
                                <li><a href="/player/index">[Players]</a></li>
                                <li><a href="/result/index">[Results]</a></li>
                                <li><a href="/team/index">[Teams]</a></li>
                                <li><a href="/user/index">[User]</a></li>
                                <li><a href="/configuration/index">[Configuration]</a></li>
                                <li><a href="/auth/signOut">[Sign out init]</a></li>
                            </ul>
                        </li>
                    
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>

    <div class="row">

        <div class="col-md-12">

            <div class="starter-template">
                
<center>
    <h2 class="title">Ultra SF4 Capcom Pro Tour Rankings 2015</h2>
</center>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Rules</h3>
        </div>
        <div class="panel-body">
            This ranking follows the <a
                href="http://capcomprotour.com/rules/">Capcom Pro Tour ruleset</a>. Check out the offical site at <a
                href="http://capcomprotour.com/standings/">http://capcomprotour.com/standings/</a>. The board is auto-updated as soon as the tournament results are added at Shoryuken World Rankings.
        <br/>Currently qualifying players by score are indicated in the blue area, those in yellow area are currently in the top32 region. Those that directly qualified are invited to the season finals in December, as well as the highest 15 scoring players.
        </div>
    </div>

    <div class="alert alert-info alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <ul>
<li>You can find a list of prices on latest arcade sticks and pads in the <a href="http://rank.shoryuken.com/about/sf5">SF5 Order Guide</a></li>
<li>A new <b>feature</b> has been added: submit results!</li>
<li>The SF5 ranking is <b>still early</b>, tournaments will be weighted correctly over time</li>
</ul>

    </div>


<div class="table-responsive">

    <table class="tablehead" id="datatable">

        <thead>
        <tr class="stathead">
            <th>CPT Rank</th>
            <th>World Rank</th>
            <th>Name</th>
            <th>Team</th>
            <th>Character</th>
            <th>CPT Score <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Score as granted by the Capcom Pro Tour 2015 ranking system">(?)</a></th>
            <th>Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Directly qualified for the Capcom Cup Finals">(?)</a></th>
            <th>Score diff<a href="#" data-toggle="tooltip" data-placement="top"
                             title="Diff against score before update at 2016-02-27">(?)</a></th>
            <th>Rank diff<a href="#" data-toggle="tooltip" data-placement="top"
                            title="Diff against rank before update at 2016-02-27">(?)</a></th>
            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
            <th>Fight Money<a href="#" data-toggle="tooltip" data-placement="top"
                            title="Estimated Prize money assigned by CPT budget">(?)</a></th>
            <th>Country</th>
        </tr>
        </thead>

        

            <tr class="unqual">
                <td class="warning">
                        1
                </td>
                <td>1</td>
                <td>
                    <a href="/rankings/player/byname/Momochi">Momochi</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Evil%20Geniuses">EG</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                            <img src="/static/images/chars/usf4/ken.png" width="22" height="25" alt="Ken" class="charimg" />
                        </a>
                    
                </td>
                <td>1374</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>10</td>
                <td>$28250</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        2
                </td>
                <td>7</td>
                <td>
                    <a href="/rankings/player/byname/Infiltration">Infiltration</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=AKUMA" data-toggle="tooltip" data-placement="top" title="Filter on Akuma">
                            <img src="/static/images/chars/usf4/akuma.png" width="22" height="25" alt="Akuma" class="charimg" />
                        </a>
                    
                </td>
                <td>1076</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>14</td>
                <td>$14500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=KR" data-toggle="tooltip" data-placement="top" title="Find players from Republic of Korea">
                            <img src="/static/images/countries/kr.png" class="countryflag" />
                            Republic of Korea
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        3
                </td>
                <td>3</td>
                <td>
                    <a href="/rankings/player/byname/Bonchan">Bonchan</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Red%20Bull%20eSports">RB</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAGAT" data-toggle="tooltip" data-placement="top" title="Filter on Sagat">
                            <img src="/static/images/chars/usf4/sagat.png" width="22" height="25" alt="Sagat" class="charimg" />
                        </a>
                    
                </td>
                <td>896</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>15</td>
                <td>$9750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        4
                </td>
                <td>5</td>
                <td>
                    <a href="/rankings/player/byname/Xian">Xian</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20Razer">RZR</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=GEN" data-toggle="tooltip" data-placement="top" title="Filter on Gen">
                            <img src="/static/images/chars/usf4/gen.png" width="22" height="25" alt="Gen" class="charimg" />
                        </a>
                    
                </td>
                <td>798</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>12</td>
                <td>$51250</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=SG" data-toggle="tooltip" data-placement="top" title="Find players from Singapore">
                            <img src="/static/images/countries/sg.png" class="countryflag" />
                            Singapore
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        5
                </td>
                <td>8</td>
                <td>
                    <a href="/rankings/player/byname/GamerBee">GamerBee</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Avermedia">AVM</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ADON" data-toggle="tooltip" data-placement="top" title="Filter on Adon">
                            <img src="/static/images/chars/usf4/adon.png" width="22" height="25" alt="Adon" class="charimg" />
                        </a>
                    
                </td>
                <td>740</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>10</td>
                <td>$14750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=TW" data-toggle="tooltip" data-placement="top" title="Find players from Taiwan">
                            <img src="/static/images/countries/tw.png" class="countryflag" />
                            Taiwan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        6
                </td>
                <td>6</td>
                <td>
                    <a href="/rankings/player/byname/Luffy">Luffy</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Meltdown">MD</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROSE" data-toggle="tooltip" data-placement="top" title="Filter on Rose">
                            <img src="/static/images/chars/usf4/rose.png" width="22" height="25" alt="Rose" class="charimg" />
                        </a>
                    
                </td>
                <td>724</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>11</td>
                <td>$5250</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                            <img src="/static/images/countries/fr.png" class="countryflag" />
                            France
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        7
                </td>
                <td>9</td>
                <td>
                    <a href="/rankings/player/byname/Tokido">Tokido</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Mad%20Catz">MCZ</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=AKUMA" data-toggle="tooltip" data-placement="top" title="Filter on Akuma">
                            <img src="/static/images/chars/usf4/akuma.png" width="22" height="25" alt="Akuma" class="charimg" />
                        </a>
                    
                </td>
                <td>700</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>13</td>
                <td>$16500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        8
                </td>
                <td>10</td>
                <td>
                    <a href="/rankings/player/byname/Fuudo">Fuudo</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20Razer">RZR</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=FEI" data-toggle="tooltip" data-placement="top" title="Filter on Fei Long">
                            <img src="/static/images/chars/usf4/fei.png" width="22" height="25" alt="Fei Long" class="charimg" />
                        </a>
                    
                </td>
                <td>610</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>15</td>
                <td>$15000</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        9
                </td>
                <td>14</td>
                <td>
                    <a href="/rankings/player/byname/Mago">Mago</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Mad%20Catz">MCZ</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=YANG" data-toggle="tooltip" data-placement="top" title="Filter on Yang">
                            <img src="/static/images/chars/usf4/yang.png" width="22" height="25" alt="Yang" class="charimg" />
                        </a>
                    
                </td>
                <td>556</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>9</td>
                <td>$15250</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        10
                </td>
                <td>2</td>
                <td>
                    <a href="/rankings/player/byname/Daigo%20Umehara">Daigo Umehara</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Mad%20Catz">MCZ</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ERYU" data-toggle="tooltip" data-placement="top" title="Filter on Evil Ryu">
                            <img src="/static/images/chars/usf4/eryu.png" width="22" height="25" alt="Evil Ryu" class="charimg" />
                        </a>
                    
                </td>
                <td>546</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>8</td>
                <td>$74750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        11
                </td>
                <td>4</td>
                <td>
                    <a href="/rankings/player/byname/Kazunoko">Kazunoko</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=YUN" data-toggle="tooltip" data-placement="top" title="Filter on Yun">
                            <img src="/static/images/chars/usf4/yun.png" width="22" height="25" alt="Yun" class="charimg" />
                        </a>
                    
                </td>
                <td>512</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>12</td>
                <td>$132500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        12
                </td>
                <td>13</td>
                <td>
                    <a href="/rankings/player/byname/Snake%20Eyez">Snake Eyez</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Red%20Bull%20eSports">RB</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ZANGIEF" data-toggle="tooltip" data-placement="top" title="Filter on Zangief">
                            <img src="/static/images/chars/usf4/zangief.png" width="22" height="25" alt="Zangief" class="charimg" />
                        </a>
                    
                </td>
                <td>440</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>13</td>
                <td>$12000</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        13
                </td>
                <td>11</td>
                <td>
                    <a href="/rankings/player/byname/Nemo">Nemo</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/The%20Blackeye">BE</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROLENTO" data-toggle="tooltip" data-placement="top" title="Filter on Rolento">
                            <img src="/static/images/chars/usf4/rolento.png" width="22" height="25" alt="Rolento" class="charimg" />
                        </a>
                    
                </td>
                <td>416</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>6</td>
                <td>$8000</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        14
                </td>
                <td>21</td>
                <td>
                    <a href="/rankings/player/byname/Xiaohai">Xiaohai</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ERYU" data-toggle="tooltip" data-placement="top" title="Filter on Evil Ryu">
                            <img src="/static/images/chars/usf4/eryu.png" width="22" height="25" alt="Evil Ryu" class="charimg" />
                        </a>
                    
                </td>
                <td>360</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>12</td>
                <td>$4000</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CN" data-toggle="tooltip" data-placement="top" title="Find players from China">
                            <img src="/static/images/countries/cn.png" class="countryflag" />
                            China
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        15
                </td>
                <td>28</td>
                <td>
                    <a href="/rankings/player/byname/Justin%20Wong">Justin Wong</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Evil%20Geniuses">EG</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=RUFUS" data-toggle="tooltip" data-placement="top" title="Filter on Rufus">
                            <img src="/static/images/chars/usf4/rufus.png" width="22" height="25" alt="Rufus" class="charimg" />
                        </a>
                    
                </td>
                <td>310</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>8</td>
                <td>$750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        16
                </td>
                <td>12</td>
                <td>
                    <a href="/rankings/player/byname/Poongko">Poongko</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SETH" data-toggle="tooltip" data-placement="top" title="Filter on Seth">
                            <img src="/static/images/chars/usf4/seth.png" width="22" height="25" alt="Seth" class="charimg" />
                        </a>
                    
                </td>
                <td>308</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>11</td>
                <td>$22750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=KR" data-toggle="tooltip" data-placement="top" title="Find players from Republic of Korea">
                            <img src="/static/images/countries/kr.png" class="countryflag" />
                            Republic of Korea
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        17
                </td>
                <td>26</td>
                <td>
                    <a href="/rankings/player/byname/Itabashi%20Zangief">Itabashi Zangief</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20Razer">RZR</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ZANGIEF" data-toggle="tooltip" data-placement="top" title="Filter on Zangief">
                            <img src="/static/images/chars/usf4/zangief.png" width="22" height="25" alt="Zangief" class="charimg" />
                        </a>
                    
                </td>
                <td>296</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>16</td>
                <td>$1750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        18
                </td>
                <td>32</td>
                <td>
                    <a href="/rankings/player/byname/Tonpy">Tonpy</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VIPER" data-toggle="tooltip" data-placement="top" title="Filter on C. Viper">
                            <img src="/static/images/chars/usf4/viper.png" width="22" height="25" alt="C. Viper" class="charimg" />
                        </a>
                    
                </td>
                <td>280</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>11</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        19
                </td>
                <td>17</td>
                <td>
                    <a href="/rankings/player/byname/NuckleDu">NuckleDu</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20Liquid%20Pro">Liquid</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                            <img src="/static/images/chars/usf4/guile.png" width="22" height="25" alt="Guile" class="charimg" />
                        </a>
                    
                </td>
                <td>268</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>12</td>
                <td>$3000</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        20
                </td>
                <td>27</td>
                <td>
                    <a href="/rankings/player/byname/Dashio">Dashio</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SETH" data-toggle="tooltip" data-placement="top" title="Filter on Seth">
                            <img src="/static/images/chars/usf4/seth.png" width="22" height="25" alt="Seth" class="charimg" />
                        </a>
                    
                </td>
                <td>258</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>3</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        21
                </td>
                <td>59</td>
                <td>
                    <a href="/rankings/player/byname/Keoma">Keoma</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ABEL" data-toggle="tooltip" data-placement="top" title="Filter on Abel">
                            <img src="/static/images/chars/usf4/abel.png" width="22" height="25" alt="Abel" class="charimg" />
                        </a>
                    
                </td>
                <td>256</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>3</td>
                <td>$5500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        22
                </td>
                <td>33</td>
                <td>
                    <a href="/rankings/player/byname/801%20Strider">801 Strider</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Winterfox">WFX</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ABEL" data-toggle="tooltip" data-placement="top" title="Filter on Abel">
                            <img src="/static/images/chars/usf4/abel.png" width="22" height="25" alt="Abel" class="charimg" />
                        </a>
                    
                </td>
                <td>238</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>11</td>
                <td>$3000</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        23
                </td>
                <td>18</td>
                <td>
                    <a href="/rankings/player/byname/Dieminion">Dieminion</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Yomi%20Gaming">YOMI</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                            <img src="/static/images/chars/usf4/guile.png" width="22" height="25" alt="Guile" class="charimg" />
                        </a>
                    
                </td>
                <td>236</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>9</td>
                <td>$1500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        24
                </td>
                <td>36</td>
                <td>
                    <a href="/rankings/player/byname/Dark%20Jiewa">Dark Jiewa</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                            <img src="/static/images/chars/usf4/ken.png" width="22" height="25" alt="Ken" class="charimg" />
                        </a>
                    
                </td>
                <td>207</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>13</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CN" data-toggle="tooltip" data-placement="top" title="Find players from China">
                            <img src="/static/images/countries/cn.png" class="countryflag" />
                            China
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        25
                </td>
                <td>28</td>
                <td>
                    <a href="/rankings/player/byname/HumanBomb">HumanBomb</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAKURA" data-toggle="tooltip" data-placement="top" title="Filter on Sakura">
                            <img src="/static/images/chars/usf4/sakura.png" width="22" height="25" alt="Sakura" class="charimg" />
                        </a>
                    
                </td>
                <td>203</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>12</td>
                <td>$1000</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=HK" data-toggle="tooltip" data-placement="top" title="Find players from Hong Kong">
                            <img src="/static/images/countries/hk.png" class="countryflag" />
                            Hong Kong
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        26
                </td>
                <td>45</td>
                <td>
                    <a href="/rankings/player/byname/Shiro">Shiro</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ABEL" data-toggle="tooltip" data-placement="top" title="Filter on Abel">
                            <img src="/static/images/chars/usf4/abel.png" width="22" height="25" alt="Abel" class="charimg" />
                        </a>
                    
                </td>
                <td>182</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>13</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        27
                </td>
                <td>31</td>
                <td>
                    <a href="/rankings/player/byname/Problem%20X">Problem X</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VIPER" data-toggle="tooltip" data-placement="top" title="Filter on C. Viper">
                            <img src="/static/images/chars/usf4/viper.png" width="22" height="25" alt="C. Viper" class="charimg" />
                        </a>
                    
                </td>
                <td>178</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>11</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        28
                </td>
                <td>20</td>
                <td>
                    <a href="/rankings/player/byname/Gackt">Gackt</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20Razer">RZR</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=FEI" data-toggle="tooltip" data-placement="top" title="Filter on Fei Long">
                            <img src="/static/images/chars/usf4/fei.png" width="22" height="25" alt="Fei Long" class="charimg" />
                        </a>
                    
                </td>
                <td>160</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>6</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=SG" data-toggle="tooltip" data-placement="top" title="Find players from Singapore">
                            <img src="/static/images/countries/sg.png" class="countryflag" />
                            Singapore
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        29
                </td>
                <td>15</td>
                <td>
                    <a href="/rankings/player/byname/Valmaster">Valmaster</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=CHUN" data-toggle="tooltip" data-placement="top" title="Filter on Chun-Li">
                            <img src="/static/images/chars/usf4/chun.png" width="22" height="25" alt="Chun-Li" class="charimg" />
                        </a>
                    
                </td>
                <td>148</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>7</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                            <img src="/static/images/countries/fr.png" class="countryflag" />
                            France
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        30
                </td>
                <td>30</td>
                <td>
                    <a href="/rankings/player/byname/Misse">Misse</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=MAKOTO" data-toggle="tooltip" data-placement="top" title="Filter on Makoto">
                            <img src="/static/images/chars/usf4/makoto.png" width="22" height="25" alt="Makoto" class="charimg" />
                        </a>
                    
                </td>
                <td>144</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>10</td>
                <td>$10750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="qual">
                <td class="warning">
                        31
                </td>
                <td>37</td>
                <td>
                    <a href="/rankings/player/byname/Dakou">Dakou</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ERYU" data-toggle="tooltip" data-placement="top" title="Filter on Evil Ryu">
                            <img src="/static/images/chars/usf4/eryu.png" width="22" height="25" alt="Evil Ryu" class="charimg" />
                        </a>
                    
                </td>
                <td>140</td>
                <td>
                    
                    
                        <small>by points <a href="#" data-toggle="tooltip" data-placement="top"
                                           title="Currently player is in the top15 spots that are assigned to the highest scoring but not directly qualified players">(?)</a></small>
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>9</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CN" data-toggle="tooltip" data-placement="top" title="Find players from China">
                            <img src="/static/images/countries/cn.png" class="countryflag" />
                            China
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="warning">
                        32
                </td>
                <td>24</td>
                <td>
                    <a href="/rankings/player/byname/PR%20Balrog">PR Balrog</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Evil%20Geniuses">EG</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BALROG" data-toggle="tooltip" data-placement="top" title="Filter on Balrog">
                            <img src="/static/images/chars/usf4/balrog.png" width="22" height="25" alt="Balrog" class="charimg" />
                        </a>
                    
                </td>
                <td>132</td>
                <td>
                    
                    
                        
                            <small>candidate <a href="#" data-toggle="tooltip" data-placement="top"
                                               title="Player can still qualify when players who currently qualify by points get a direct qualifying spot at a Premier event">(?)</a></small>
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>9</td>
                <td>$3000</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        33
                </td>
                <td>89</td>
                <td>
                    <a href="/rankings/player/byname/Haitani">Haitani</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=MAKOTO" data-toggle="tooltip" data-placement="top" title="Filter on Makoto">
                            <img src="/static/images/chars/usf4/makoto.png" width="22" height="25" alt="Makoto" class="charimg" />
                        </a>
                    
                </td>
                <td>131</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        34
                </td>
                <td>23</td>
                <td>
                    <a href="/rankings/player/byname/Ryan%20Hart">Ryan Hart</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/The%20Falcon%20Arena">FA</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAGAT" data-toggle="tooltip" data-placement="top" title="Filter on Sagat">
                            <img src="/static/images/chars/usf4/sagat.png" width="22" height="25" alt="Sagat" class="charimg" />
                        </a>
                    
                </td>
                <td>126</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>11</td>
                <td>$2500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        35
                </td>
                <td>55</td>
                <td>
                    <a href="/rankings/player/byname/Gonzalez">Gonzalez</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SETH" data-toggle="tooltip" data-placement="top" title="Filter on Seth">
                            <img src="/static/images/chars/usf4/seth.png" width="22" height="25" alt="Seth" class="charimg" />
                        </a>
                    
                </td>
                <td>112</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>12</td>
                <td>$750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        36
                </td>
                <td>25</td>
                <td>
                    <a href="/rankings/player/byname/Ricky%20Ortiz">Ricky Ortiz</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Evil%20Geniuses">EG</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=RUFUS" data-toggle="tooltip" data-placement="top" title="Filter on Rufus">
                            <img src="/static/images/chars/usf4/rufus.png" width="22" height="25" alt="Rufus" class="charimg" />
                        </a>
                    
                </td>
                <td>100</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>10</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        37
                </td>
                <td>39</td>
                <td>
                    <a href="/rankings/player/byname/K-Brad">K-Brad</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Evil%20Geniuses">EG</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                            <img src="/static/images/chars/usf4/cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                        </a>
                    
                </td>
                <td>96</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>13</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        38
                </td>
                <td>37</td>
                <td>
                    <a href="/rankings/player/byname/Phenom">Phenom</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>80</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>9</td>
                <td>$1500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=NO" data-toggle="tooltip" data-placement="top" title="Find players from Norway">
                            <img src="/static/images/countries/no.png" class="countryflag" />
                            Norway
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        39
                </td>
                <td>69</td>
                <td>
                    <a href="/rankings/player/byname/Latif">Latif</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VIPER" data-toggle="tooltip" data-placement="top" title="Filter on C. Viper">
                            <img src="/static/images/chars/usf4/viper.png" width="22" height="25" alt="C. Viper" class="charimg" />
                        </a>
                    
                </td>
                <td>72</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$1500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=SA" data-toggle="tooltip" data-placement="top" title="Find players from Saudi Arabia">
                            <img src="/static/images/countries/sa.png" class="countryflag" />
                            Saudi Arabia
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        39
                </td>
                <td>94</td>
                <td>
                    <a href="/rankings/player/byname/kubo">kubo</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=HUGO" data-toggle="tooltip" data-placement="top" title="Filter on Hugo">
                            <img src="/static/images/chars/usf4/hugo.png" width="22" height="25" alt="Hugo" class="charimg" />
                        </a>
                    
                </td>
                <td>72</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>6</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        39
                </td>
                <td>77</td>
                <td>
                    <a href="/rankings/player/byname/KojiKOG">KojiKOG</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=HAWK" data-toggle="tooltip" data-placement="top" title="Filter on T. Hawk">
                            <img src="/static/images/chars/usf4/hawk.png" width="22" height="25" alt="T. Hawk" class="charimg" />
                        </a>
                    
                </td>
                <td>72</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        42
                </td>
                <td>65</td>
                <td>
                    <a href="/rankings/player/byname/RB">RB</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20Razer">RZR</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROLENTO" data-toggle="tooltip" data-placement="top" title="Filter on Rolento">
                            <img src="/static/images/chars/usf4/rolento.png" width="22" height="25" alt="Rolento" class="charimg" />
                        </a>
                    
                </td>
                <td>71</td>
                <td>
                    
                        <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="25"
                             height="25"/>
                    </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$1500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=TW" data-toggle="tooltip" data-placement="top" title="Find players from Taiwan">
                            <img src="/static/images/countries/tw.png" class="countryflag" />
                            Taiwan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        43
                </td>
                <td>62</td>
                <td>
                    <a href="/rankings/player/byname/aiai">aiai</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=JURI" data-toggle="tooltip" data-placement="top" title="Filter on Juri">
                            <img src="/static/images/chars/usf4/juri.png" width="22" height="25" alt="Juri" class="charimg" />
                        </a>
                    
                </td>
                <td>68</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$2500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        44
                </td>
                <td>91</td>
                <td>
                    <a href="/rankings/player/byname/MOV">MOV</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=IBUKI" data-toggle="tooltip" data-placement="top" title="Filter on Ibuki">
                            <img src="/static/images/chars/usf4/ibuki.png" width="22" height="25" alt="Ibuki" class="charimg" />
                        </a>
                    
                </td>
                <td>66</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        45
                </td>
                <td>16</td>
                <td>
                    <a href="/rankings/player/byname/sako">sako</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20HORI">HORI</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ELENA" data-toggle="tooltip" data-placement="top" title="Filter on Elena">
                            <img src="/static/images/chars/usf4/elena.png" width="22" height="25" alt="Elena" class="charimg" />
                        </a>
                    
                </td>
                <td>64</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        45
                </td>
                <td>418</td>
                <td>
                    <a href="/rankings/player/byname/Ibukiman">Ibukiman</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=IBUKI" data-toggle="tooltip" data-placement="top" title="Filter on Ibuki">
                            <img src="/static/images/chars/usf4/ibuki.png" width="22" height="25" alt="Ibuki" class="charimg" />
                        </a>
                    
                </td>
                <td>64</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        45
                </td>
                <td>72</td>
                <td>
                    <a href="/rankings/player/byname/Infexious">Infexious</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=HUGO" data-toggle="tooltip" data-placement="top" title="Filter on Hugo">
                            <img src="/static/images/chars/usf4/hugo.png" width="22" height="25" alt="Hugo" class="charimg" />
                        </a>
                    
                </td>
                <td>64</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>7</td>
                <td>$750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        45
                </td>
                <td>117</td>
                <td>
                    <a href="/rankings/player/byname/Rokkun">Rokkun</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SETH" data-toggle="tooltip" data-placement="top" title="Filter on Seth">
                            <img src="/static/images/chars/usf4/seth.png" width="22" height="25" alt="Seth" class="charimg" />
                        </a>
                    
                </td>
                <td>64</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        49
                </td>
                <td>19</td>
                <td>
                    <a href="/rankings/player/byname/Smug">Smug</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20Pie">PIE</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=DUDLEY" data-toggle="tooltip" data-placement="top" title="Filter on Dudley">
                            <img src="/static/images/chars/usf4/dudley.png" width="22" height="25" alt="Dudley" class="charimg" />
                        </a>
                    
                </td>
                <td>60</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>7</td>
                <td>$1750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        50
                </td>
                <td>82</td>
                <td>
                    <a href="/rankings/player/byname/Chuan">Chuan</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                            <img src="/static/images/chars/usf4/guile.png" width="22" height="25" alt="Guile" class="charimg" />
                        </a>
                    
                </td>
                <td>59</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>7</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=MY" data-toggle="tooltip" data-placement="top" title="Find players from Malaysia">
                            <img src="/static/images/countries/my.png" class="countryflag" />
                            Malaysia
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        51
                </td>
                <td>34</td>
                <td>
                    <a href="/rankings/player/byname/Filipino%20Man">Filipino Man</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Frequency">FRQ</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROSE" data-toggle="tooltip" data-placement="top" title="Filter on Rose">
                            <img src="/static/images/chars/usf4/rose.png" width="22" height="25" alt="Rose" class="charimg" />
                        </a>
                    
                </td>
                <td>52</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$1000</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        52
                </td>
                <td>35</td>
                <td>
                    <a href="/rankings/player/byname/NISHIKIN">NISHIKIN</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BLANKA" data-toggle="tooltip" data-placement="top" title="Filter on Blanka">
                            <img src="/static/images/chars/usf4/blanka.png" width="22" height="25" alt="Blanka" class="charimg" />
                        </a>
                    
                </td>
                <td>44</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        53
                </td>
                <td>58</td>
                <td>
                    <a href="/rankings/player/byname/Profluke">Profluke</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=FUERTE" data-toggle="tooltip" data-placement="top" title="Filter on Fuerte">
                            <img src="/static/images/chars/usf4/fuerte.png" width="22" height="25" alt="Fuerte" class="charimg" />
                        </a>
                    
                </td>
                <td>42</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>11</td>
                <td>$750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        54
                </td>
                <td>76</td>
                <td>
                    <a href="/rankings/player/byname/Inko">Inko</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=RUFUS" data-toggle="tooltip" data-placement="top" title="Filter on Rufus">
                            <img src="/static/images/chars/usf4/rufus.png" width="22" height="25" alt="Rufus" class="charimg" />
                        </a>
                    
                </td>
                <td>41</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>6</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        55
                </td>
                <td>51</td>
                <td>
                    <a href="/rankings/player/byname/Arturo%20Sanchez">Arturo Sanchez</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20Spooky">TS</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=DHALSIM" data-toggle="tooltip" data-placement="top" title="Filter on Dhalsim">
                            <img src="/static/images/chars/usf4/dhalsim.png" width="22" height="25" alt="Dhalsim" class="charimg" />
                        </a>
                    
                </td>
                <td>40</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        55
                </td>
                <td>73</td>
                <td>
                    <a href="/rankings/player/byname/Reiketsu">Reiketsu</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VEGA" data-toggle="tooltip" data-placement="top" title="Filter on Claw">
                            <img src="/static/images/chars/usf4/vega.png" width="22" height="25" alt="Claw" class="charimg" />
                        </a>
                    
                </td>
                <td>40</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>8</td>
                <td>$750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        57
                </td>
                <td>75</td>
                <td>
                    <a href="/rankings/player/byname/LPN">LPN</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROLENTO" data-toggle="tooltip" data-placement="top" title="Filter on Rolento">
                            <img src="/static/images/chars/usf4/rolento.png" width="22" height="25" alt="Rolento" class="charimg" />
                        </a>
                    
                </td>
                <td>36</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        57
                </td>
                <td>43</td>
                <td>
                    <a href="/rankings/player/byname/Pugera">Pugera</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=IBUKI" data-toggle="tooltip" data-placement="top" title="Filter on Ibuki">
                            <img src="/static/images/chars/usf4/ibuki.png" width="22" height="25" alt="Ibuki" class="charimg" />
                        </a>
                    
                </td>
                <td>36</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        57
                </td>
                <td>90</td>
                <td>
                    <a href="/rankings/player/byname/Tampa%20Bison">Tampa Bison</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>36</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>3</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        60
                </td>
                <td>65</td>
                <td>
                    <a href="/rankings/player/byname/Kita%20senju%20DJ">Kita senju DJ</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=DJ" data-toggle="tooltip" data-placement="top" title="Filter on Dee Jay">
                            <img src="/static/images/chars/usf4/dj.png" width="22" height="25" alt="Dee Jay" class="charimg" />
                        </a>
                    
                </td>
                <td>32</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        60
                </td>
                <td>79</td>
                <td>
                    <a href="/rankings/player/byname/Chuchu">Chuchu</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VIPER" data-toggle="tooltip" data-placement="top" title="Filter on C. Viper">
                            <img src="/static/images/chars/usf4/viper.png" width="22" height="25" alt="C. Viper" class="charimg" />
                        </a>
                    
                </td>
                <td>32</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        62
                </td>
                <td>48</td>
                <td>
                    <a href="/rankings/player/byname/Andreas">Andreas</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=RUFUS" data-toggle="tooltip" data-placement="top" title="Filter on Rufus">
                            <img src="/static/images/chars/usf4/rufus.png" width="22" height="25" alt="Rufus" class="charimg" />
                        </a>
                    
                </td>
                <td>28</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        63
                </td>
                <td>53</td>
                <td>
                    <a href="/rankings/player/byname/NYChrisG">NYChrisG</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAKURA" data-toggle="tooltip" data-placement="top" title="Filter on Sakura">
                            <img src="/static/images/chars/usf4/sakura.png" width="22" height="25" alt="Sakura" class="charimg" />
                        </a>
                    
                </td>
                <td>27</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>8</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        64
                </td>
                <td>49</td>
                <td>
                    <a href="/rankings/player/byname/MBR">MBR</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Team%20LowLandLions">LLL</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=AKUMA" data-toggle="tooltip" data-placement="top" title="Filter on Akuma">
                            <img src="/static/images/chars/usf4/akuma.png" width="22" height="25" alt="Akuma" class="charimg" />
                        </a>
                    
                </td>
                <td>24</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=NL" data-toggle="tooltip" data-placement="top" title="Find players from Netherlands">
                            <img src="/static/images/countries/nl.png" class="countryflag" />
                            Netherlands
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        65
                </td>
                <td>96</td>
                <td>
                    <a href="/rankings/player/byname/Tyrant_UK">Tyrant_UK</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>20</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        65
                </td>
                <td>41</td>
                <td>
                    <a href="/rankings/player/byname/SuperSantarouMan">SuperSantarouMan</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAGAT" data-toggle="tooltip" data-placement="top" title="Filter on Sagat">
                            <img src="/static/images/chars/usf4/sagat.png" width="22" height="25" alt="Sagat" class="charimg" />
                        </a>
                    
                </td>
                <td>20</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        67
                </td>
                <td>93</td>
                <td>
                    <a href="/rankings/player/byname/Packz">Packz</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=CODY" data-toggle="tooltip" data-placement="top" title="Filter on Cody">
                            <img src="/static/images/chars/usf4/cody.png" width="22" height="25" alt="Cody" class="charimg" />
                        </a>
                    
                </td>
                <td>18</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        67
                </td>
                <td>264</td>
                <td>
                    <a href="/rankings/player/byname/XiaoLong">XiaoLong</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>18</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CN" data-toggle="tooltip" data-placement="top" title="Find players from China">
                            <img src="/static/images/countries/cn.png" class="countryflag" />
                            China
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        69
                </td>
                <td>106</td>
                <td>
                    <a href="/rankings/player/byname/KOK">KOK</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAGAT" data-toggle="tooltip" data-placement="top" title="Filter on Sagat">
                            <img src="/static/images/chars/usf4/sagat.png" width="22" height="25" alt="Sagat" class="charimg" />
                        </a>
                    
                </td>
                <td>17</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>7</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        69
                </td>
                <td>52</td>
                <td>
                    <a href="/rankings/player/byname/ImStillDaDaddy">ImStillDaDaddy</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                            <img src="/static/images/chars/usf4/guile.png" width="22" height="25" alt="Guile" class="charimg" />
                        </a>
                    
                </td>
                <td>17</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>7</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        69
                </td>
                <td>45</td>
                <td>
                    <a href="/rankings/player/byname/Eita">Eita</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=AKUMA" data-toggle="tooltip" data-placement="top" title="Filter on Akuma">
                            <img src="/static/images/chars/usf4/akuma.png" width="22" height="25" alt="Akuma" class="charimg" />
                        </a>
                    
                </td>
                <td>17</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>7</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>115</td>
                <td>
                    <a href="/rankings/player/byname/Shine">Shine</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=YANG" data-toggle="tooltip" data-placement="top" title="Filter on Yang">
                            <img src="/static/images/chars/usf4/yang.png" width="22" height="25" alt="Yang" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>290</td>
                <td>
                    <a href="/rankings/player/byname/Ganoon">Ganoon</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAKURA" data-toggle="tooltip" data-placement="top" title="Filter on Sakura">
                            <img src="/static/images/chars/usf4/sakura.png" width="22" height="25" alt="Sakura" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=KW" data-toggle="tooltip" data-placement="top" title="Find players from Kuwait">
                            <img src="/static/images/countries/kw.png" class="countryflag" />
                            Kuwait
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>227</td>
                <td>
                    <a href="/rankings/player/byname/-R-">-R-</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BALROG" data-toggle="tooltip" data-placement="top" title="Filter on Balrog">
                            <img src="/static/images/chars/usf4/balrog.png" width="22" height="25" alt="Balrog" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>648</td>
                <td>
                    <a href="/rankings/player/byname/Pr3da">Pr3da</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROLENTO" data-toggle="tooltip" data-placement="top" title="Filter on Rolento">
                            <img src="/static/images/chars/usf4/rolento.png" width="22" height="25" alt="Rolento" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>78</td>
                <td>
                    <a href="/rankings/player/byname/WolfKrone">WolfKrone</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VIPER" data-toggle="tooltip" data-placement="top" title="Filter on C. Viper">
                            <img src="/static/images/chars/usf4/viper.png" width="22" height="25" alt="C. Viper" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>84</td>
                <td>
                    <a href="/rankings/player/byname/Air">Air</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=POISON" data-toggle="tooltip" data-placement="top" title="Filter on Poison">
                            <img src="/static/images/chars/usf4/poison.png" width="22" height="25" alt="Poison" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>8</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CA" data-toggle="tooltip" data-placement="top" title="Find players from Canada">
                            <img src="/static/images/countries/ca.png" class="countryflag" />
                            Canada
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>170</td>
                <td>
                    <a href="/rankings/player/byname/Shinba">Shinba</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ABEL" data-toggle="tooltip" data-placement="top" title="Filter on Abel">
                            <img src="/static/images/chars/usf4/abel.png" width="22" height="25" alt="Abel" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>393</td>
                <td>
                    <a href="/rankings/player/byname/Doomsday%20507">Doomsday 507</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=DUDLEY" data-toggle="tooltip" data-placement="top" title="Filter on Dudley">
                            <img src="/static/images/chars/usf4/dudley.png" width="22" height="25" alt="Dudley" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>648</td>
                <td>
                    <a href="/rankings/player/byname/FURY%20PROMETO">FURY PROMETO</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BALROG" data-toggle="tooltip" data-placement="top" title="Filter on Balrog">
                            <img src="/static/images/chars/usf4/balrog.png" width="22" height="25" alt="Balrog" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        72
                </td>
                <td>159</td>
                <td>
                    <a href="/rankings/player/byname/Jehosan">Jehosan</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=DECAPRE" data-toggle="tooltip" data-placement="top" title="Filter on Decapre">
                            <img src="/static/images/chars/usf4/decapre.png" width="22" height="25" alt="Decapre" class="charimg" />
                        </a>
                    
                </td>
                <td>16</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                            <img src="/static/images/countries/fr.png" class="countryflag" />
                            France
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        82
                </td>
                <td>88</td>
                <td>
                    <a href="/rankings/player/byname/Alucard">Alucard</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Flipside">F.3</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=HUGO" data-toggle="tooltip" data-placement="top" title="Filter on Hugo">
                            <img src="/static/images/chars/usf4/hugo.png" width="22" height="25" alt="Hugo" class="charimg" />
                        </a>
                    
                </td>
                <td>14</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        83
                </td>
                <td>137</td>
                <td>
                    <a href="/rankings/player/byname/God%20of%20Sky">God of Sky</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VEGA" data-toggle="tooltip" data-placement="top" title="Filter on Claw">
                            <img src="/static/images/chars/usf4/vega.png" width="22" height="25" alt="Claw" class="charimg" />
                        </a>
                    
                </td>
                <td>12</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CN" data-toggle="tooltip" data-placement="top" title="Find players from China">
                            <img src="/static/images/countries/cn.png" class="countryflag" />
                            China
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        83
                </td>
                <td>63</td>
                <td>
                    <a href="/rankings/player/byname/-6">-6</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=POISON" data-toggle="tooltip" data-placement="top" title="Filter on Poison">
                            <img src="/static/images/chars/usf4/poison.png" width="22" height="25" alt="Poison" class="charimg" />
                        </a>
                    
                </td>
                <td>12</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        83
                </td>
                <td>114</td>
                <td>
                    <a href="/rankings/player/byname/Joel">Joel</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=RYU" data-toggle="tooltip" data-placement="top" title="Filter on Ryu">
                            <img src="/static/images/chars/usf4/ryu.png" width="22" height="25" alt="Ryu" class="charimg" />
                        </a>
                    
                </td>
                <td>12</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>6</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        83
                </td>
                <td>40</td>
                <td>
                    <a href="/rankings/player/byname/Gagapa">Gagapa</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>12</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                            <img src="/static/images/countries/fr.png" class="countryflag" />
                            France
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        87
                </td>
                <td>86</td>
                <td>
                    <a href="/rankings/player/byname/Kawaguuchi">Kawaguuchi</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROSE" data-toggle="tooltip" data-placement="top" title="Filter on Rose">
                            <img src="/static/images/chars/usf4/rose.png" width="22" height="25" alt="Rose" class="charimg" />
                        </a>
                    
                </td>
                <td>11</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        87
                </td>
                <td>74</td>
                <td>
                    <a href="/rankings/player/byname/Brentt">Brentt</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=RUFUS" data-toggle="tooltip" data-placement="top" title="Filter on Rufus">
                            <img src="/static/images/chars/usf4/rufus.png" width="22" height="25" alt="Rufus" class="charimg" />
                        </a>
                    
                </td>
                <td>11</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>7</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        87
                </td>
                <td>64</td>
                <td>
                    <a href="/rankings/player/byname/Jayce%20The%20Ace">Jayce The Ace</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=DECAPRE" data-toggle="tooltip" data-placement="top" title="Filter on Decapre">
                            <img src="/static/images/chars/usf4/decapre.png" width="22" height="25" alt="Decapre" class="charimg" />
                        </a>
                    
                </td>
                <td>11</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        90
                </td>
                <td>54</td>
                <td>
                    <a href="/rankings/player/byname/Gachikun">Gachikun</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAGAT" data-toggle="tooltip" data-placement="top" title="Filter on Sagat">
                            <img src="/static/images/chars/usf4/sagat.png" width="22" height="25" alt="Sagat" class="charimg" />
                        </a>
                    
                </td>
                <td>10</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        90
                </td>
                <td>42</td>
                <td>
                    <a href="/rankings/player/byname/Kindevu">Kindevu</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ELENA" data-toggle="tooltip" data-placement="top" title="Filter on Elena">
                            <img src="/static/images/chars/usf4/elena.png" width="22" height="25" alt="Elena" class="charimg" />
                        </a>
                    
                </td>
                <td>10</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$1500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        90
                </td>
                <td>140</td>
                <td>
                    <a href="/rankings/player/byname/NativeImpact">NativeImpact</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=HAWK" data-toggle="tooltip" data-placement="top" title="Filter on T. Hawk">
                            <img src="/static/images/chars/usf4/hawk.png" width="22" height="25" alt="T. Hawk" class="charimg" />
                        </a>
                    
                </td>
                <td>10</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>3</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        90
                </td>
                <td>92</td>
                <td>
                    <a href="/rankings/player/byname/Hurricane237">Hurricane237</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=DECAPRE" data-toggle="tooltip" data-placement="top" title="Filter on Decapre">
                            <img src="/static/images/chars/usf4/decapre.png" width="22" height="25" alt="Decapre" class="charimg" />
                        </a>
                    
                </td>
                <td>10</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>3</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        90
                </td>
                <td>81</td>
                <td>
                    <a href="/rankings/player/byname/Afii">Afii</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=POISON" data-toggle="tooltip" data-placement="top" title="Filter on Poison">
                            <img src="/static/images/chars/usf4/poison.png" width="22" height="25" alt="Poison" class="charimg" />
                        </a>
                    
                </td>
                <td>10</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>6</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        90
                </td>
                <td>129</td>
                <td>
                    <a href="/rankings/player/byname/Pnoy">Pnoy</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>10</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=MX" data-toggle="tooltip" data-placement="top" title="Find players from Mexico">
                            <img src="/static/images/countries/mx.png" class="countryflag" />
                            Mexico
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        90
                </td>
                <td>173</td>
                <td>
                    <a href="/rankings/player/byname/Saunic">Saunic</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=IBUKI" data-toggle="tooltip" data-placement="top" title="Filter on Ibuki">
                            <img src="/static/images/chars/usf4/ibuki.png" width="22" height="25" alt="Ibuki" class="charimg" />
                        </a>
                    
                </td>
                <td>10</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                            <img src="/static/images/countries/fr.png" class="countryflag" />
                            France
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        97
                </td>
                <td>22</td>
                <td>
                    <a href="/rankings/player/byname/Pepedai">Pepedai</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=FUERTE" data-toggle="tooltip" data-placement="top" title="Filter on Fuerte">
                            <img src="/static/images/chars/usf4/fuerte.png" width="22" height="25" alt="Fuerte" class="charimg" />
                        </a>
                    
                </td>
                <td>9</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        97
                </td>
                <td>110</td>
                <td>
                    <a href="/rankings/player/byname/F-Word">F-Word</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=IBUKI" data-toggle="tooltip" data-placement="top" title="Filter on Ibuki">
                            <img src="/static/images/chars/usf4/ibuki.png" width="22" height="25" alt="Ibuki" class="charimg" />
                        </a>
                    
                </td>
                <td>9</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>179</td>
                <td>
                    <a href="/rankings/player/byname/QQEL">QQEL</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=FUERTE" data-toggle="tooltip" data-placement="top" title="Filter on Fuerte">
                            <img src="/static/images/chars/usf4/fuerte.png" width="22" height="25" alt="Fuerte" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CN" data-toggle="tooltip" data-placement="top" title="Find players from China">
                            <img src="/static/images/countries/cn.png" class="countryflag" />
                            China
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>248</td>
                <td>
                    <a href="/rankings/player/byname/ShoryuSengan">ShoryuSengan</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                            <img src="/static/images/chars/usf4/ken.png" width="22" height="25" alt="Ken" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>341</td>
                <td>
                    <a href="/rankings/player/byname/Danhill">Danhill</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAKURA" data-toggle="tooltip" data-placement="top" title="Filter on Sakura">
                            <img src="/static/images/chars/usf4/sakura.png" width="22" height="25" alt="Sakura" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>85</td>
                <td>
                    <a href="/rankings/player/byname/Hiro">Hiro</a>
                </td>
                <td>
                    
                        <a href="/rankings/team/byname/Empire%20Arcadia">EMP</a>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>121</td>
                <td>
                    <a href="/rankings/player/byname/KOJI">KOJI</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=AKUMA" data-toggle="tooltip" data-placement="top" title="Filter on Akuma">
                            <img src="/static/images/chars/usf4/akuma.png" width="22" height="25" alt="Akuma" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=SG" data-toggle="tooltip" data-placement="top" title="Find players from Singapore">
                            <img src="/static/images/countries/sg.png" class="countryflag" />
                            Singapore
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>530</td>
                <td>
                    <a href="/rankings/player/byname/Revenger32">Revenger32</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ABEL" data-toggle="tooltip" data-placement="top" title="Filter on Abel">
                            <img src="/static/images/chars/usf4/abel.png" width="22" height="25" alt="Abel" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=ID" data-toggle="tooltip" data-placement="top" title="Find players from Indonesia">
                            <img src="/static/images/countries/id.png" class="countryflag" />
                            Indonesia
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>442</td>
                <td>
                    <a href="/rankings/player/byname/Caju">Caju</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=HAKAN" data-toggle="tooltip" data-placement="top" title="Filter on Hakan">
                            <img src="/static/images/chars/usf4/hakan.png" width="22" height="25" alt="Hakan" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>234</td>
                <td>
                    <a href="/rankings/player/byname/Xiaohu">Xiaohu</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROSE" data-toggle="tooltip" data-placement="top" title="Filter on Rose">
                            <img src="/static/images/chars/usf4/rose.png" width="22" height="25" alt="Rose" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CN" data-toggle="tooltip" data-placement="top" title="Find players from China">
                            <img src="/static/images/countries/cn.png" class="countryflag" />
                            China
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>549</td>
                <td>
                    <a href="/rankings/player/byname/Guiller">Guiller</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                            <img src="/static/images/chars/usf4/guile.png" width="22" height="25" alt="Guile" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>173</td>
                <td>
                    <a href="/rankings/player/byname/Riceata">Riceata</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BLANKA" data-toggle="tooltip" data-placement="top" title="Filter on Blanka">
                            <img src="/static/images/chars/usf4/blanka.png" width="22" height="25" alt="Blanka" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CA" data-toggle="tooltip" data-placement="top" title="Find players from Canada">
                            <img src="/static/images/countries/ca.png" class="countryflag" />
                            Canada
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>71</td>
                <td>
                    <a href="/rankings/player/byname/Veggey">Veggey</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ZANGIEF" data-toggle="tooltip" data-placement="top" title="Filter on Zangief">
                            <img src="/static/images/chars/usf4/zangief.png" width="22" height="25" alt="Zangief" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>3</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=NO" data-toggle="tooltip" data-placement="top" title="Find players from Norway">
                            <img src="/static/images/countries/no.png" class="countryflag" />
                            Norway
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>248</td>
                <td>
                    <a href="/rankings/player/byname/Nox">Nox</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROLENTO" data-toggle="tooltip" data-placement="top" title="Filter on Rolento">
                            <img src="/static/images/chars/usf4/rolento.png" width="22" height="25" alt="Rolento" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$500</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=KW" data-toggle="tooltip" data-placement="top" title="Find players from Kuwait">
                            <img src="/static/images/countries/kw.png" class="countryflag" />
                            Kuwait
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>530</td>
                <td>
                    <a href="/rankings/player/byname/Kakaroto">Kakaroto</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=YUN" data-toggle="tooltip" data-placement="top" title="Filter on Yun">
                            <img src="/static/images/chars/usf4/yun.png" width="22" height="25" alt="Yun" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=PA" data-toggle="tooltip" data-placement="top" title="Find players from Panama">
                            <img src="/static/images/countries/pa.png" class="countryflag" />
                            Panama
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>120</td>
                <td>
                    <a href="/rankings/player/byname/Zaferino">Zaferino</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=FEI" data-toggle="tooltip" data-placement="top" title="Filter on Fei Long">
                            <img src="/static/images/chars/usf4/fei.png" width="22" height="25" alt="Fei Long" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>61</td>
                <td>
                    <a href="/rankings/player/byname/Leslie">Leslie</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAGAT" data-toggle="tooltip" data-placement="top" title="Filter on Sagat">
                            <img src="/static/images/chars/usf4/sagat.png" width="22" height="25" alt="Sagat" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=SG" data-toggle="tooltip" data-placement="top" title="Find players from Singapore">
                            <img src="/static/images/countries/sg.png" class="countryflag" />
                            Singapore
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        99
                </td>
                <td>124</td>
                <td>
                    <a href="/rankings/player/byname/Bebedero">Bebedero</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ZANGIEF" data-toggle="tooltip" data-placement="top" title="Filter on Zangief">
                            <img src="/static/images/chars/usf4/zangief.png" width="22" height="25" alt="Zangief" class="charimg" />
                        </a>
                    
                </td>
                <td>8</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CR" data-toggle="tooltip" data-placement="top" title="Find players from Costa Rica">
                            <img src="/static/images/countries/cr.png" class="countryflag" />
                            Costa Rica
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        115
                </td>
                <td>111</td>
                <td>
                    <a href="/rankings/player/byname/Cody">Cody</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=POISON" data-toggle="tooltip" data-placement="top" title="Filter on Poison">
                            <img src="/static/images/chars/usf4/poison.png" width="22" height="25" alt="Poison" class="charimg" />
                        </a>
                    
                </td>
                <td>7</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=HK" data-toggle="tooltip" data-placement="top" title="Find players from Hong Kong">
                            <img src="/static/images/countries/hk.png" class="countryflag" />
                            Hong Kong
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        115
                </td>
                <td>101</td>
                <td>
                    <a href="/rankings/player/byname/Kim1234">Kim1234</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>7</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>5</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        115
                </td>
                <td>101</td>
                <td>
                    <a href="/rankings/player/byname/Akimo">Akimo</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ELENA" data-toggle="tooltip" data-placement="top" title="Filter on Elena">
                            <img src="/static/images/chars/usf4/elena.png" width="22" height="25" alt="Elena" class="charimg" />
                        </a>
                    
                </td>
                <td>7</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        118
                </td>
                <td>122</td>
                <td>
                    <a href="/rankings/player/byname/Hsien%20Chang">Hsien Chang</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=YUN" data-toggle="tooltip" data-placement="top" title="Filter on Yun">
                            <img src="/static/images/chars/usf4/yun.png" width="22" height="25" alt="Yun" class="charimg" />
                        </a>
                    
                </td>
                <td>6</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>4</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        118
                </td>
                <td>56</td>
                <td>
                    <a href="/rankings/player/byname/Julio">Julio</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=YUN" data-toggle="tooltip" data-placement="top" title="Filter on Yun">
                            <img src="/static/images/chars/usf4/yun.png" width="22" height="25" alt="Yun" class="charimg" />
                        </a>
                    
                </td>
                <td>6</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>6</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        118
                </td>
                <td>155</td>
                <td>
                    <a href="/rankings/player/byname/Nando">Nando</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=FUERTE" data-toggle="tooltip" data-placement="top" title="Filter on Fuerte">
                            <img src="/static/images/chars/usf4/fuerte.png" width="22" height="25" alt="Fuerte" class="charimg" />
                        </a>
                    
                </td>
                <td>6</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>3</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        121
                </td>
                <td>202</td>
                <td>
                    <a href="/rankings/player/byname/Demulant">Demulant</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAGAT" data-toggle="tooltip" data-placement="top" title="Filter on Sagat">
                            <img src="/static/images/chars/usf4/sagat.png" width="22" height="25" alt="Sagat" class="charimg" />
                        </a>
                    
                </td>
                <td>5</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=DE" data-toggle="tooltip" data-placement="top" title="Find players from Germany">
                            <img src="/static/images/countries/de.png" class="countryflag" />
                            Germany
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        121
                </td>
                <td>80</td>
                <td>
                    <a href="/rankings/player/byname/RMZ">RMZ</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=YUN" data-toggle="tooltip" data-placement="top" title="Filter on Yun">
                            <img src="/static/images/chars/usf4/yun.png" width="22" height="25" alt="Yun" class="charimg" />
                        </a>
                    
                </td>
                <td>5</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>6</td>
                <td>$750</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>223</td>
                <td>
                    <a href="/rankings/player/byname/Fawwaz">Fawwaz</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VIPER" data-toggle="tooltip" data-placement="top" title="Filter on C. Viper">
                            <img src="/static/images/chars/usf4/viper.png" width="22" height="25" alt="C. Viper" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>132</td>
                <td>
                    <a href="/rankings/player/byname/Gabo">Gabo</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VIPER" data-toggle="tooltip" data-placement="top" title="Filter on C. Viper">
                            <img src="/static/images/chars/usf4/viper.png" width="22" height="25" alt="C. Viper" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=CR" data-toggle="tooltip" data-placement="top" title="Find players from Costa Rica">
                            <img src="/static/images/countries/cr.png" class="countryflag" />
                            Costa Rica
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>142</td>
                <td>
                    <a href="/rankings/player/byname/Flawless%20Deku">Flawless Deku</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=FEI" data-toggle="tooltip" data-placement="top" title="Filter on Fei Long">
                            <img src="/static/images/chars/usf4/fei.png" width="22" height="25" alt="Fei Long" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>314</td>
                <td>
                    <a href="/rankings/player/byname/Milligano">Milligano</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>133</td>
                <td>
                    <a href="/rankings/player/byname/Solidjin">Solidjin</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=VEGA" data-toggle="tooltip" data-placement="top" title="Filter on Claw">
                            <img src="/static/images/chars/usf4/vega.png" width="22" height="25" alt="Claw" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                            <img src="/static/images/countries/fr.png" class="countryflag" />
                            France
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>551</td>
                <td>
                    <a href="/rankings/player/byname/CamisaKOF98UMFE">CamisaKOF98UMFE</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAGAT" data-toggle="tooltip" data-placement="top" title="Filter on Sagat">
                            <img src="/static/images/chars/usf4/sagat.png" width="22" height="25" alt="Sagat" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>620</td>
                <td>
                    <a href="/rankings/player/byname/Dianminion">Dianminion</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BISON" data-toggle="tooltip" data-placement="top" title="Filter on M. Bison">
                            <img src="/static/images/chars/usf4/bison.png" width="22" height="25" alt="M. Bison" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=ID" data-toggle="tooltip" data-placement="top" title="Find players from Indonesia">
                            <img src="/static/images/countries/id.png" class="countryflag" />
                            Indonesia
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>239</td>
                <td>
                    <a href="/rankings/player/byname/Magneto1080P">Magneto1080P</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ELENA" data-toggle="tooltip" data-placement="top" title="Filter on Elena">
                            <img src="/static/images/chars/usf4/elena.png" width="22" height="25" alt="Elena" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>261</td>
                <td>
                    <a href="/rankings/player/byname/KichijojiKEN">KichijojiKEN</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                            <img src="/static/images/chars/usf4/ken.png" width="22" height="25" alt="Ken" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>314</td>
                <td>
                    <a href="/rankings/player/byname/eightgrade">eightgrade</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=AKUMA" data-toggle="tooltip" data-placement="top" title="Filter on Akuma">
                            <img src="/static/images/chars/usf4/akuma.png" width="22" height="25" alt="Akuma" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=MX" data-toggle="tooltip" data-placement="top" title="Find players from Mexico">
                            <img src="/static/images/countries/mx.png" class="countryflag" />
                            Mexico
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>341</td>
                <td>
                    <a href="/rankings/player/byname/Ray">Ray</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=FEI" data-toggle="tooltip" data-placement="top" title="Filter on Fei Long">
                            <img src="/static/images/chars/usf4/fei.png" width="22" height="25" alt="Fei Long" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>341</td>
                <td>
                    <a href="/rankings/player/byname/Huracan%20Azura">Huracan Azura</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=HAWK" data-toggle="tooltip" data-placement="top" title="Filter on T. Hawk">
                            <img src="/static/images/chars/usf4/hawk.png" width="22" height="25" alt="T. Hawk" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>908</td>
                <td>
                    <a href="/rankings/player/byname/Alexandro">Alexandro</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                            <img src="/static/images/chars/usf4/ken.png" width="22" height="25" alt="Ken" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>167</td>
                <td>
                    <a href="/rankings/player/byname/Shimauta">Shimauta</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=IBUKI" data-toggle="tooltip" data-placement="top" title="Filter on Ibuki">
                            <img src="/static/images/chars/usf4/ibuki.png" width="22" height="25" alt="Ibuki" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>908</td>
                <td>
                    <a href="/rankings/player/byname/Baby%20Brasil">Baby Brasil</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=RUFUS" data-toggle="tooltip" data-placement="top" title="Filter on Rufus">
                            <img src="/static/images/chars/usf4/rufus.png" width="22" height="25" alt="Rufus" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                            <img src="/static/images/countries/br.png" class="countryflag" />
                            Brazil
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>103</td>
                <td>
                    <a href="/rankings/player/byname/Ninja%20Shakz">Ninja Shakz</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ABEL" data-toggle="tooltip" data-placement="top" title="Filter on Abel">
                            <img src="/static/images/chars/usf4/abel.png" width="22" height="25" alt="Abel" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>290</td>
                <td>
                    <a href="/rankings/player/byname/Stanick">Stanick</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                            <img src="/static/images/chars/usf4/cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=MY" data-toggle="tooltip" data-placement="top" title="Find players from Malaysia">
                            <img src="/static/images/countries/my.png" class="countryflag" />
                            Malaysia
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>335</td>
                <td>
                    <a href="/rankings/player/byname/Khangaroo">Khangaroo</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=DUDLEY" data-toggle="tooltip" data-placement="top" title="Filter on Dudley">
                            <img src="/static/images/chars/usf4/dudley.png" width="22" height="25" alt="Dudley" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>452</td>
                <td>
                    <a href="/rankings/player/byname/Dudebag">Dudebag</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                            <img src="/static/images/chars/usf4/ken.png" width="22" height="25" alt="Ken" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>223</td>
                <td>
                    <a href="/rankings/player/byname/Kindo">Kindo</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=GUY" data-toggle="tooltip" data-placement="top" title="Filter on Guy">
                            <img src="/static/images/chars/usf4/guy.png" width="22" height="25" alt="Guy" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>113</td>
                <td>
                    <a href="/rankings/player/byname/Yossan">Yossan</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=JURI" data-toggle="tooltip" data-placement="top" title="Filter on Juri">
                            <img src="/static/images/chars/usf4/juri.png" width="22" height="25" alt="Juri" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>159</td>
                <td>
                    <a href="/rankings/player/byname/Bashfest">Bashfest</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=SAGAT" data-toggle="tooltip" data-placement="top" title="Filter on Sagat">
                            <img src="/static/images/chars/usf4/sagat.png" width="22" height="25" alt="Sagat" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=SE" data-toggle="tooltip" data-placement="top" title="Find players from Sweden">
                            <img src="/static/images/countries/se.png" class="countryflag" />
                            Sweden
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>620</td>
                <td>
                    <a href="/rankings/player/byname/ThunderBear">ThunderBear</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=CODY" data-toggle="tooltip" data-placement="top" title="Filter on Cody">
                            <img src="/static/images/chars/usf4/cody.png" width="22" height="25" alt="Cody" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>620</td>
                <td>
                    <a href="/rankings/player/byname/Doomed">Doomed</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=DECAPRE" data-toggle="tooltip" data-placement="top" title="Filter on Decapre">
                            <img src="/static/images/chars/usf4/decapre.png" width="22" height="25" alt="Decapre" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        123
                </td>
                <td>211</td>
                <td>
                    <a href="/rankings/player/byname/Mizoteru">Mizoteru</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=BLANKA" data-toggle="tooltip" data-placement="top" title="Filter on Blanka">
                            <img src="/static/images/chars/usf4/blanka.png" width="22" height="25" alt="Blanka" class="charimg" />
                        </a>
                    
                </td>
                <td>4</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>1</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                            <img src="/static/images/countries/jp.png" class="countryflag" />
                            Japan
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        148
                </td>
                <td>200</td>
                <td>
                    <a href="/rankings/player/byname/Onisan">Onisan</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ABEL" data-toggle="tooltip" data-placement="top" title="Filter on Abel">
                            <img src="/static/images/chars/usf4/abel.png" width="22" height="25" alt="Abel" class="charimg" />
                        </a>
                    
                </td>
                <td>3</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>3</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                            <img src="/static/images/countries/us.png" class="countryflag" />
                            United States
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        148
                </td>
                <td>376</td>
                <td>
                    <a href="/rankings/player/byname/AHo">AHo</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=ROLENTO" data-toggle="tooltip" data-placement="top" title="Filter on Rolento">
                            <img src="/static/images/chars/usf4/rolento.png" width="22" height="25" alt="Rolento" class="charimg" />
                        </a>
                    
                </td>
                <td>3</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=ID" data-toggle="tooltip" data-placement="top" title="Find players from Indonesia">
                            <img src="/static/images/countries/id.png" class="countryflag" />
                            Indonesia
                        </a>
                    
                </td>

            </tr>
        

            <tr class="unqual">
                <td class="">
                        148
                </td>
                <td>179</td>
                <td>
                    <a href="/rankings/player/byname/Gunslinga">Gunslinga</a>
                </td>
                <td>
                    
                </td>
                <td>
                    
                        <a href="/rankings/rank/USF4?pchar=GUY" data-toggle="tooltip" data-placement="top" title="Filter on Guy">
                            <img src="/static/images/chars/usf4/guy.png" width="22" height="25" alt="Guy" class="charimg" />
                        </a>
                    
                </td>
                <td>3</td>
                <td>
                    
                    
                        
                    
                </td>
                <td>+0</td>
                <td class="">
                    
                    
                </td>
                <td>2</td>
                <td>$0</td>
                <td>
                    
                        <a href="/rankings/rank/USF4?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                            <img src="/static/images/countries/gb.png" class="countryflag" />
                            United Kingdom
                        </a>
                    
                </td>

            </tr>
        

    </table></div>


<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title">Filter</h3>
    </div>

    <div class="panel-body">
        <form action="/rankings/cpt" method="get" name="filter" role="form" class="form-inline" id="filter" >
            <select name="pcountry" class="form-control" id="pcountry" >
<option value="any country" >any country</option>
<option value="Japan" >Japan</option>
<option value="United States" >United States</option>
<option value="Hong Kong" >Hong Kong</option>
<option value="Brazil" >Brazil</option>
<option value="France" >France</option>
<option value="Spain" >Spain</option>
<option value="United Kingdom" >United Kingdom</option>
<option value="Netherlands" >Netherlands</option>
<option value="Switzerland" >Switzerland</option>
<option value="Sweden" >Sweden</option>
<option value="Australia" >Australia</option>
<option value="China" >China</option>
<option value="Canada" >Canada</option>
<option value="Taiwan" >Taiwan</option>
<option value="Norway" >Norway</option>
<option value="Germany" >Germany</option>
<option value="Singapore" >Singapore</option>
<option value="Belgium" >Belgium</option>
<option value="Saudi Arabia" >Saudi Arabia</option>
<option value="Republic of Korea" >Republic of Korea</option>
<option value="Peru" >Peru</option>
<option value="Malaysia" >Malaysia</option>
<option value="Mexico" >Mexico</option>
<option value="Ireland" >Ireland</option>
<option value="Chile" >Chile</option>
<option value="Kuwait" >Kuwait</option>
<option value="Morocco" >Morocco</option>
<option value="Plurinational State of Bolivia" >Plurinational State of Bolivia</option>
<option value="Indonesia" >Indonesia</option>
<option value="Czech Republic" >Czech Republic</option>
<option value="Jordan" >Jordan</option>
<option value="Italy" >Italy</option>
<option value="Denmark" >Denmark</option>
<option value="Puerto Rico" >Puerto Rico</option>
<option value="United Arab Emirates" >United Arab Emirates</option>
<option value="Philippines" >Philippines</option>
<option value="Panama" >Panama</option>
<option value="Thailand" >Thailand</option>
<option value="Finland" >Finland</option>
<option value="Costa Rica" >Costa Rica</option>
<option value="Romania" >Romania</option>
<option value="Russian Federation" >Russian Federation</option>
<option value="Azerbaijan" >Azerbaijan</option>
<option value="India" >India</option>
<option value="Viet Nam" >Viet Nam</option>
<option value="Poland" >Poland</option>
<option value="New Zealand" >New Zealand</option>
<option value="Greece" >Greece</option>
<option value="Serbia" >Serbia</option>
<option value="Portugal" >Portugal</option>
</select>
            <select name="pchar" class="form-control" id="pchar" >
<option value="any character" >any character</option>
<option value="UNKNOWN" >UNKNOWN</option>
<option value="ABEL" >ABEL</option>
<option value="ADON" >ADON</option>
<option value="AKUMA" >AKUMA</option>
<option value="BALROG" >BALROG</option>
<option value="BLANKA" >BLANKA</option>
<option value="CAMMY" >CAMMY</option>
<option value="CHUN" >CHUN</option>
<option value="CODY" >CODY</option>
<option value="VIPER" >VIPER</option>
<option value="DAN" >DAN</option>
<option value="DJ" >DJ</option>
<option value="DHALSIM" >DHALSIM</option>
<option value="DUDLEY" >DUDLEY</option>
<option value="HONDA" >HONDA</option>
<option value="FUERTE" >FUERTE</option>
<option value="ERYU" >ERYU</option>
<option value="FEI" >FEI</option>
<option value="GEN" >GEN</option>
<option value="GOUKEN" >GOUKEN</option>
<option value="GUILE" >GUILE</option>
<option value="GUY" >GUY</option>
<option value="HAKAN" >HAKAN</option>
<option value="IBUKI" >IBUKI</option>
<option value="JURI" >JURI</option>
<option value="KEN" >KEN</option>
<option value="MAKOTO" >MAKOTO</option>
<option value="BISON" >BISON</option>
<option value="ONI" >ONI</option>
<option value="ROSE" >ROSE</option>
<option value="RUFUS" >RUFUS</option>
<option value="RYU" >RYU</option>
<option value="SAGAT" >SAGAT</option>
<option value="SAKURA" >SAKURA</option>
<option value="SETH" >SETH</option>
<option value="HAWK" >HAWK</option>
<option value="VEGA" >VEGA</option>
<option value="YANG" >YANG</option>
<option value="YUN" >YUN</option>
<option value="ZANGIEF" >ZANGIEF</option>
<option value="ROLENTO" >ROLENTO</option>
<option value="HUGO" >HUGO</option>
<option value="ELENA" >ELENA</option>
<option value="DECAPRE" >DECAPRE</option>
<option value="POISON" >POISON</option>
</select>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>
<script type="text/javascript" charset="utf-8">
    $(document).ready(function ()
    {
        $('table[id^="datatable"]').each(function (index)
        {
            $(this).tablecloth({
                theme: "default",
                striped: false,
                sortable: true,
                condensed: true})
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