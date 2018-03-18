

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Capcom Pro Tour Rankings 2016 - Street Fighter 5</title>


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

    <div class="row">

        <div class="col-md-12">

            <div class="starter-template">

                <center>
                    <h2 class="title">SF5 Capcom Pro Tour Rankings 2016</h2>
                </center>

                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Rules</h3>
                            </div>

                            <div class="panel-body">
                                This Street Fighter 5 ranking follows the <a
                                    href="http://capcomprotour.com/rules/">Capcom Pro Tour ruleset</a>
                                <ul>
                                    <li>12 qualify via Global Premier Events</li>
                                    <li>4 qualify via Regional Finals, 1 player from each event</li>
                                    <li>8 qualify via regional point leaderboards, top 2 from each region</li>
                                    <li>8 qualify via the global point leaderboards.</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">



                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">Updates</h3>
                            </div>
                            <div class="panel-body">
                                Follow for updates on <div class="fb-follow" data-href="https://www.facebook.com/fgcworldranking/" data-layout="button" data-size="small" data-show-faces="false"></div> or <a class="twitter-follow-button" href="https://twitter.com/srkranking" data-size="small"></a>

                            </div>
                        </div>

                    </div>
                </div>

                <h3>Global leader board</h3>

                Green means directly qualified, blue means will qualify by points in the open global spots. When a player directly qualifed or double-qualifies (via global points, direct and/or regional finals) extra blue spots are opened. This means players on the edge can still get in by extension of blue zone.
                Any global point spots above top 8 are granted due to shifting caused by direct qualifiers and double qualifiers.

                <div class="table-responsive">

                    <table class="tablehead" id="datatable">

                        <thead>
                        <tr class="stathead">
                            <th>CPT Rank</th>
                            <th>Country</th>
                            <th>Name</th>
                            <th>Team</th>
                            <th>Character</th>
                            <th>CPT Score <a href="#" data-toggle="tooltip" data-placement="top"
                                             title="Score as granted by the Capcom Pro Tour 2016 ranking system">(?)</a></th>
                            <th>Qualifications <a href="#" data-toggle="tooltip" data-placement="top"
                                                  title="Qualifications for the Capcom Cup Finals">(?)</a></th>
                            <th>Score diff<a href="#" data-toggle="tooltip" data-placement="top"
                                             title="Diff against score before update at 2017-03-18">(?)</a>
                            </th>
                            <th>Rank diff<a href="#" data-toggle="tooltip" data-placement="top"
                                            title="Diff against rank before update at 2017-03-18">(?)</a></th>
                            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
                            <th>Fight Money<a href="#" data-toggle="tooltip" data-placement="top"
                                              title="Estimated Prize money assigned by CPT budget">(?)</a></th>
                        </tr>
                        </thead>



                        <tr class="unqual direct">
                            <td class="warning">
                                1
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=KR" data-toggle="tooltip" data-placement="top" title="Find players from Republic of Korea">
                                    <img src="/static/images/countries/kr.png" class="countryflag" />
                                    KR
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Infiltration">Infiltration</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Razer">RZR</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>1670
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via NorCal Regionals 2016 - SF5<br/>via Final Round 19 - SF5<br/>via Evolution 2016 - SF5<br/>opened 2 extra spots</ul><ul><li>Global rank is 1 and score is 1670 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>8</td>
                            <td>$37000</td>
                        </tr>


                        <tr class="unqual direct">
                            <td class="warning">
                                2
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Tokido">Tokido</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Echo%20Fox">FOX</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_AKUMA" data-toggle="tooltip" data-placement="top" title="Filter on Akuma">
                                    <img src="/static/images/chars/sf5/sf5_akuma.png" width="22" height="25" alt="Akuma" class="charimg" />
                                </a>

                            </td>
                            <td>1048
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via SEAM 2016 - SF5<br/>via CEO 2016 - SF5<br/>opened 1 extra spots</ul><ul><li>Global rank is 2 and score is 1048 pts<li>LA rank is 22 and score is 64 pts<li>AO rank is 15 and score is 80 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>13</td>
                            <td>$23000</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                3
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Justin%20Wong">Justin Wong</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Echo%20Fox">FOX</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>984
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 984 pts / rank: 3<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 3 and score is 984 pts<li>LA rank is 2 and score is 256 pts<li>NA rank is 2 and score is 520 pts<li>AO rank is 12 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>16</td>
                            <td>$1500</td>
                        </tr>


                        <tr class="unqual direct">
                            <td class="warning">
                                4
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/NuckleDu">NuckleDu</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Liquid%20Pro">Liquid</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                                    <img src="/static/images/chars/sf5/sf5_guile.png" width="22" height="25" alt="Guile" class="charimg" />
                                </a>

                            </td>
                            <td>869
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via CPT Regional Finals NA 2016 - SF5<br/>via Canada Cup 2016 - SF5<br/>opened 1 extra spots<li>Qualified for regionals in NA region</ul><ul><li>Global rank is 4 and score is 869 pts<li>NA rank is 1 and score is 561 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>17</td>
                            <td>$129250</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                5
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Fuudo">Fuudo</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Grapht">GRPT</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RMIKA" data-toggle="tooltip" data-placement="top" title="Filter on Mika">
                                    <img src="/static/images/chars/sf5/sf5_rmika.png" width="22" height="25" alt="Mika" class="charimg" />
                                </a>

                            </td>
                            <td>804
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 804 pts / rank: 5<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 5 and score is 804 pts<li>AO rank is 54 and score is 4 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>8</td>
                            <td>$27000</td>
                        </tr>


                        <tr class="unqual direct">
                            <td class="warning">
                                5
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=CN" data-toggle="tooltip" data-placement="top" title="Find players from China">
                                    <img src="/static/images/countries/cn.png" class="countryflag" />
                                    CN
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Xiaohai">Xiaohai</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Qanba">Qanba</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>804
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via SCR 2016 - SF5<br/>via G-League 2016  - SF5<br/>opened 1 extra spots<li>Qualified for regionals in AO region</ul><ul><li>Global rank is 5 and score is 804 pts<li>AO rank is 12 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>12</td>
                            <td>$18000</td>
                        </tr>


                        <tr class="unqual direct">
                            <td class="warning">
                                7
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=TW" data-toggle="tooltip" data-placement="top" title="Find players from Taiwan">
                                    <img src="/static/images/countries/tw.png" class="countryflag" />
                                    TW
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/GamerBee">GamerBee</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Zowie">ZW</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>732
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via Japan Cup 2016 - SF5<br/>via EGX 2016 - SF5<br/>opened 1 extra spots<li>Qualified for regionals in AO region</ul><ul><li>Global rank is 7 and score is 732 pts<li>AO rank is 6 and score is 200 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>14</td>
                            <td>$7000</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                8
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/MOV">MOV</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Grapht">GRPT</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>600
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 600 pts / rank: 8<li>Qualified for regionals in AO region<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 8 and score is 600 pts<li>AO rank is 10 and score is 136 pts<li>EU rank is 3 and score is 384 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>13</td>
                            <td>$12500</td>
                        </tr>


                        <tr class="unqual direct">
                            <td class="warning">
                                9
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Daigo%20Umehara">Daigo Umehara</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Cygames%20Beast">Beast</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RYU" data-toggle="tooltip" data-placement="top" title="Filter on Ryu">
                                    <img src="/static/images/chars/sf5/sf5_ryu.png" width="22" height="25" alt="Ryu" class="charimg" />
                                </a>

                            </td>
                            <td>563
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via CPT Regional Finals EU 2016 - SF5<li>Qualified for regionals in AO region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 9 and score is 563 pts<li>NA rank is 58 and score is 2 pts<li>AO rank is 2 and score is 353 pts<li>EU rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>15</td>
                            <td>$3500</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                10
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Julio%20Fuentes">Julio Fuentes</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Echo%20Fox">FOX</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>548
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 548 pts / rank: 10<li>Qualified for regionals in NA region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 10 and score is 548 pts<li>LA rank is 13 and score is 96 pts<li>NA rank is 3 and score is 434 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>18</td>
                            <td>$750</td>
                        </tr>


                        <tr class="unqual direct">
                            <td class="warning">
                                11
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=NO" data-toggle="tooltip" data-placement="top" title="Find players from Norway">
                                    <img src="/static/images/countries/no.png" class="countryflag" />
                                    NO
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Phenom">Phenom</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20BX3">BX3</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>546
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via Dreamhack Summer 2016 - SF5<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 11 and score is 546 pts<li>EU rank is 6 and score is 210 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>10</td>
                            <td>$9250</td>
                        </tr>


                        <tr class="unqual direct">
                            <td class="warning">
                                12
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Momochi">Momochi</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Echo%20Fox">FOX</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>528
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via Stunfest 2016 - SF5</ul><ul><li>Global rank is 12 and score is 528 pts<li>AO rank is 21 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>10</td>
                            <td>$12000</td>
                        </tr>


                        <tr class="unqual direct">
                            <td class="warning">
                                13
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=SG" data-toggle="tooltip" data-placement="top" title="Find players from Singapore">
                                    <img src="/static/images/countries/sg.png" class="countryflag" />
                                    SG
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Xian">Xian</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Razer">RZR</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_FANG" data-toggle="tooltip" data-placement="top" title="Filter on FANG">
                                    <img src="/static/images/chars/sf5/sf5_fang.png" width="22" height="25" alt="FANG" class="charimg" />
                                </a>

                            </td>
                            <td>520
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<li>Qualified for regionals in AO region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 13 and score is 520 pts<li>AO rank is 5 and score is 216 pts<li>EU rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>17</td>
                            <td>$4250</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                14
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Haitani">Haitani</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Grapht">GRPT</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>492
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 492 pts / rank: 14<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 14 and score is 492 pts<li>AO rank is 7 and score is 176 pts<li>EU rank is 17 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>19</td>
                            <td>$22250</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                15
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Eita">Eita</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/GameWith">GW</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>482
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 482 pts / rank: 15<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 15 and score is 482 pts<li>AO rank is 1 and score is 354 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>17</td>
                            <td>$4250</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                16
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                                    <img src="/static/images/countries/fr.png" class="countryflag" />
                                    FR
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Luffy">Luffy</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Red%20Bull%20eSports">RB</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RMIKA" data-toggle="tooltip" data-placement="top" title="Filter on Mika">
                                    <img src="/static/images/chars/sf5/sf5_rmika.png" width="22" height="25" alt="Mika" class="charimg" />
                                </a>

                            </td>
                            <td>455
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 455 pts / rank: 16<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 16 and score is 455 pts<li>EU rank is 1 and score is 435 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>15</td>
                            <td>$750</td>
                        </tr>


                        <tr class="unqual direct">
                            <td class="warning">
                                17
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Mago">Mago</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>426
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via CPT Regional Finals AO 2016 - SF5<li>Qualified for regionals in AO region</ul><ul><li>Global rank is 17 and score is 426 pts<li>AO rank is 3 and score is 288 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>15</td>
                            <td>$3500</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                18
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/GO1">GO1</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Cyclops%20Osaka">CO</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>414
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 414 pts / rank: 18<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 18 and score is 414 pts<li>NA rank is 15 and score is 64 pts<li>AO rank is 8 and score is 140 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>17</td>
                            <td>$12000</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                19
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Filipino%20Champ">Filipino Champ</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Splyce">Splyce</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_DHALSIM" data-toggle="tooltip" data-placement="top" title="Filter on Dhalsim">
                                    <img src="/static/images/chars/sf5/sf5_dhalsim.png" width="22" height="25" alt="Dhalsim" class="charimg" />
                                </a>

                            </td>
                            <td>400
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 400 pts / rank: 19<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 19 and score is 400 pts<li>LA rank is 9 and score is 128 pts<li>NA rank is 4 and score is 268 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>15</td>
                            <td>$0</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                20
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=BE" data-toggle="tooltip" data-placement="top" title="Find players from Belgium">
                                    <img src="/static/images/countries/be.png" class="countryflag" />
                                    BE
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/CCL">CCL</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Mousesports">Mouz</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>397
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 397 pts / rank: 20<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 20 and score is 397 pts<li>EU rank is 2 and score is 397 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>11</td>
                            <td>$0</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                21
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Chris%20Tatarian">Chris Tatarian</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Denial%20Esports">DNL</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>386
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 386 pts / rank: 21<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 21 and score is 386 pts<li>LA rank is 9 and score is 128 pts<li>NA rank is 7 and score is 190 pts<li>EU rank is 17 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>14</td>
                            <td>$0</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                22
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                                    <img src="/static/images/countries/fr.png" class="countryflag" />
                                    FR
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Mister%20Crimson">Mister Crimson</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Meltdown">MD</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_DHALSIM" data-toggle="tooltip" data-placement="top" title="Filter on Dhalsim">
                                    <img src="/static/images/chars/sf5/sf5_dhalsim.png" width="22" height="25" alt="Dhalsim" class="charimg" />
                                </a>

                            </td>
                            <td>361
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 361 pts / rank: 22<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 22 and score is 361 pts<li>EU rank is 4 and score is 353 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>14</td>
                            <td>$0</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                23
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Kazunoko">Kazunoko</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/GodsGarden%20x%20G-Tune">GGP</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>349
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 349 pts / rank: 23<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 23 and score is 349 pts<li>AO rank is 4 and score is 247 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>17</td>
                            <td>$25500</td>
                        </tr>


                        <tr class="qual unqual">
                            <td class="warning">
                                24
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Yukadon">Yukadon</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/YOUDEAL">YD</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>346
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 346 pts / rank: 24<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 24 and score is 346 pts<li>AO rank is 14 and score is 90 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>11</td>
                            <td>$12000</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                25
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/K-Brad">K-Brad</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Evil%20Geniuses">EG</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>332
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified for regionals in NA region</ul><ul><li>Global rank is 25 and score is 332 pts<li>LA rank is 4 and score is 196 pts<li>NA rank is 16 and score is 48 pts<li>AO rank is 29 and score is 18 pts<li>EU rank is 61 and score is 2 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>22</td>
                            <td>$1500</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                26
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                                    <img src="/static/images/countries/br.png" class="countryflag" />
                                    BR
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Brolynho">Brolynho</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Flipside">F.3</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>305
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified by score in LA board: 305 pts / rank: 1</ul><ul><li>Global rank is 26 and score is 305 pts<li>LA rank is 1 and score is 305 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>7</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                27
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Ricki%20Ortiz">Ricki Ortiz</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Evil%20Geniuses">EG</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>289
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region<li>Qualified by score in NA board: 247 pts / rank: 5</ul><ul><li>Global rank is 27 and score is 289 pts<li>LA rank is 37 and score is 16 pts<li>NA rank is 5 and score is 247 pts<li>AO rank is 32 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>21</td>
                            <td>$60500</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                28
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=CN" data-toggle="tooltip" data-placement="top" title="Find players from China">
                                    <img src="/static/images/countries/cn.png" class="countryflag" />
                                    CN
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Jiewa">Jiewa</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/PandaTV">PTV</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>276
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 28 and score is 276 pts<li>LA rank is 5 and score is 193 pts<li>NA rank is 20 and score is 36 pts<li>AO rank is 47 and score is 7 pts<li>EU rank is 20 and score is 40 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>15</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                29
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                                    <img src="/static/images/countries/gb.png" class="countryflag" />
                                    GB
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Ryan%20Hart">Ryan Hart</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>275
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in EU board: 143 pts / rank: 7</ul><ul><li>Global rank is 29 and score is 275 pts<li>EU rank is 7 and score is 143 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>regional pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>13</td>
                            <td>$3000</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                30
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                                    <img src="/static/images/countries/gb.png" class="countryflag" />
                                    GB
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Problem%20X">Problem X</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Problem%20X%20Promotions">PxP</a>

                                <a href="/rankings/team/byname/Mousesports">Mouz</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BIRDIE" data-toggle="tooltip" data-placement="top" title="Filter on Birdie">
                                    <img src="/static/images/chars/sf5/sf5_birdie.png" width="22" height="25" alt="Birdie" class="charimg" />
                                </a>

                            </td>
                            <td>222
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in EU region<li>Qualified by score in EU board: 218 pts / rank: 5</ul><ul><li>Global rank is 30 and score is 222 pts<li>EU rank is 5 and score is 218 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>14</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                31
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=CL" data-toggle="tooltip" data-placement="top" title="Find players from Chile">
                                    <img src="/static/images/countries/cl.png" class="countryflag" />
                                    CL
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Misterio">Misterio</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Brook">Brook</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>203
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified by score in LA board: 203 pts / rank: 3</ul><ul><li>Global rank is 31 and score is 203 pts<li>LA rank is 3 and score is 203 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>6</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                32
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/XsK%20Samurai">XsK Samurai</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Winterfox">WFX</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RYU" data-toggle="tooltip" data-placement="top" title="Filter on Ryu">
                                    <img src="/static/images/chars/sf5/sf5_ryu.png" width="22" height="25" alt="Ryu" class="charimg" />
                                </a>

                            </td>
                            <td>202
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region<li>Qualified by score in NA board: 202 pts / rank: 6</ul><ul><li>Global rank is 32 and score is 202 pts<li>NA rank is 6 and score is 202 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>12</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                33
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                                    <img src="/static/images/countries/fr.png" class="countryflag" />
                                    FR
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Will2Pac">Will2Pac</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Melty%20eSport">Melty</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_LAURA" data-toggle="tooltip" data-placement="top" title="Filter on Laura">
                                    <img src="/static/images/chars/sf5/sf5_laura.png" width="22" height="25" alt="Laura" class="charimg" />
                                </a>

                            </td>
                            <td>188
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 33 and score is 188 pts<li>LA rank is 17 and score is 80 pts<li>NA rank is 46 and score is 4 pts<li>EU rank is 13 and score is 88 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>12</td>
                            <td>$750</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                34
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/John%20Takeuchi">John Takeuchi</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RASHID" data-toggle="tooltip" data-placement="top" title="Filter on Rashid">
                                    <img src="/static/images/chars/sf5/sf5_rashid.png" width="22" height="25" alt="Rashid" class="charimg" />
                                </a>

                            </td>
                            <td>181
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 34 and score is 181 pts<li>NA rank is 8 and score is 144 pts<li>AO rank is 96 and score is 1 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>7</td>
                            <td>$1000</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                35
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Sako">Sako</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20HORI">HORI</a>

                                <a href="/rankings/team/byname/Scarz">Scarz</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>173
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in AO region<li>Qualified by score in AO board: 137 pts / rank: 9</ul><ul><li>Global rank is 35 and score is 173 pts<li>AO rank is 9 and score is 137 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>9</td>
                            <td>$1000</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                36
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=MX" data-toggle="tooltip" data-placement="top" title="Find players from Mexico">
                                    <img src="/static/images/countries/mx.png" class="countryflag" />
                                    MX
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/KusanagiMX">KusanagiMX</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>172
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 36 and score is 172 pts<li>LA rank is 6 and score is 172 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>5</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                37
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/PR%20Balrog">PR Balrog</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Cygames%20Beast">Beast</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BALROG" data-toggle="tooltip" data-placement="top" title="Filter on Balrog">
                                    <img src="/static/images/chars/sf5/sf5_balrog.png" width="22" height="25" alt="Balrog" class="charimg" />
                                </a>

                            </td>
                            <td>158
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 37 and score is 158 pts<li>LA rank is 48 and score is 8 pts<li>NA rank is 9 and score is 142 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>13</td>
                            <td>$500</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                38
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=KR" data-toggle="tooltip" data-placement="top" title="Find players from Republic of Korea">
                                    <img src="/static/images/countries/kr.png" class="countryflag" />
                                    KR
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Poongko">Poongko</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Team%20Secret">Secret</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>146
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 38 and score is 146 pts<li>AO rank is 36 and score is 12 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>12</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                39
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                                    <img src="/static/images/countries/gb.png" class="countryflag" />
                                    GB
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/ImStillDaDaddy">ImStillDaDaddy</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Unequalled%20Media">UM</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                                    <img src="/static/images/chars/sf5/sf5_guile.png" width="22" height="25" alt="Guile" class="charimg" />
                                </a>

                            </td>
                            <td>135
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in EU region</ul><ul><li>Global rank is 39 and score is 135 pts<li>EU rank is 8 and score is 133 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>8</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                39
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                                    <img src="/static/images/countries/br.png" class="countryflag" />
                                    BR
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Dark817">Dark817</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_ALEX" data-toggle="tooltip" data-placement="top" title="Filter on Alex">
                                    <img src="/static/images/chars/sf5/sf5_alex.png" width="22" height="25" alt="Alex" class="charimg" />
                                </a>

                            </td>
                            <td>135
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 39 and score is 135 pts<li>LA rank is 7 and score is 135 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>5</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                41
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=HK" data-toggle="tooltip" data-placement="top" title="Find players from Hong Kong">
                                    <img src="/static/images/countries/hk.png" class="countryflag" />
                                    HK
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Tse4444">Tse4444</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>132
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in AO region<li>Qualified by score in AO board: 132 pts / rank: 11</ul><ul><li>Global rank is 41 and score is 132 pts<li>AO rank is 11 and score is 132 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>4</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                41
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=CL" data-toggle="tooltip" data-placement="top" title="Find players from Chile">
                                    <img src="/static/images/countries/cl.png" class="countryflag" />
                                    CL
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Baek">Baek</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>132
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 41 and score is 132 pts<li>LA rank is 8 and score is 132 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>3</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                43
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=DO" data-toggle="tooltip" data-placement="top" title="Find players from Dominican Republic">
                                    <img src="/static/images/countries/do.png" class="countryflag" />
                                    DO
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Crossover">Crossover</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/REFORCE">RF</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_MBISON" data-toggle="tooltip" data-placement="top" title="Filter on Bison">
                                    <img src="/static/images/chars/sf5/sf5_mbison.png" width="22" height="25" alt="Bison" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 43 and score is 128 pts<li>LA rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>2</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                43
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=BR" data-toggle="tooltip" data-placement="top" title="Find players from Brazil">
                                    <img src="/static/images/countries/br.png" class="countryflag" />
                                    BR
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Ericke%20Maciel">Ericke Maciel</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 43 and score is 128 pts<li>LA rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>2</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                45
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=GB" data-toggle="tooltip" data-placement="top" title="Find players from United Kingdom">
                                    <img src="/static/images/countries/gb.png" class="countryflag" />
                                    GB
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Packz">Packz</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>120
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 45 and score is 120 pts<li>EU rank is 11 and score is 108 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>11</td>
                            <td>$500</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                46
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Flash">Flash</a>
                            </td>
                            <td>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_VEGA" data-toggle="tooltip" data-placement="top" title="Filter on Vega">
                                    <img src="/static/images/chars/sf5/sf5_vega.png" width="22" height="25" alt="Vega" class="charimg" />
                                </a>

                            </td>
                            <td>110
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 46 and score is 110 pts<li>LA rank is 48 and score is 8 pts<li>NA rank is 12 and score is 92 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>11</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                46
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Alucard">Alucard</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Flipside">F.3</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BALROG" data-toggle="tooltip" data-placement="top" title="Filter on Balrog">
                                    <img src="/static/images/chars/sf5/sf5_balrog.png" width="22" height="25" alt="Balrog" class="charimg" />
                                </a>

                            </td>
                            <td>110
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 46 and score is 110 pts<li>NA rank is 10 and score is 110 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>13</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                48
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=FR" data-toggle="tooltip" data-placement="top" title="Find players from France">
                                    <img src="/static/images/countries/fr.png" class="countryflag" />
                                    FR
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Akainu">Akainu</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/Awsomniac">aws</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                                    <img src="/static/images/chars/sf5/sf5_guile.png" width="22" height="25" alt="Guile" class="charimg" />
                                </a>

                            </td>
                            <td>104
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 48 and score is 104 pts<li>EU rank is 12 and score is 104 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>5</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                49
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=US" data-toggle="tooltip" data-placement="top" title="Find players from United States">
                                    <img src="/static/images/countries/us.png" class="countryflag" />
                                    US
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Ludovic">Ludovic</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/No%20Surrender%20Gaming">NS</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>102
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 49 and score is 102 pts<li>NA rank is 11 and score is 98 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>7</td>
                            <td>$0</td>
                        </tr>


                        <tr class="unqual unqual">
                            <td class="">
                                49
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?country=JP" data-toggle="tooltip" data-placement="top" title="Find players from Japan">
                                    <img src="/static/images/countries/jp.png" class="countryflag" />
                                    JP
                                </a>

                            </td>
                            <td>
                                <a href="/rankings/player/byname/Nuki">Nuki</a>
                            </td>
                            <td>

                                <a href="/rankings/team/byname/CyberZ">CBZ</a>

                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>102
                            </td></td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 49 and score is 102 pts<li>AO rank is 54 and score is 4 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>+0</td>
                            <td class="">


                            </td>
                            <td>10</td>
                            <td>$3250</td>
                        </tr>


                    </table>
                    The global board has 11 direct qualified players, 8 global points spots and 6 spots opened by double qualification amounting to 25 qualified players out of a possible 24.
                </div>

                <div class="row" align="center">
                    <div class="col-md-12" align="center">
                        <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US&adInstanceId=4999401e-3b6b-483e-855a-486935992318&storeId=fgwora-20"></script>
                    </div>
                </div>




                <h3>AO Regional Board</h3>
                The first two non-qualified players will directly qualify for Capcom Cup. Global board ranking has precedence, so players qualifying by global points are excluded for direct qualifaction in the region.
                Green means directly qualified, yellow means qualified via global. Blue players will qualify via their regional score.
                Note that 1 player in regional finals will qualify directly, so that may shift down the blue zone.<br/>
                <strong>Curent qualifying players:</strong>
                Sako and Tse4444
                <p>&nbsp;</p>
                <div class="table-responsive">

                    <table class="tablehead" id="datatable2">

                        <thead>
                        <tr class="stathead">
                            <th>CPT Rank</th>
                            <th>Name</th>
                            <th>Character</th>
                            <th>Regional Score <a href="#" data-toggle="tooltip" data-placement="top"
                                                  title="Score as granted by the Capcom Pro Tour 2016 ranking system for region">(?)</a>
                            </th>
                            <th>Qualifications <a href="#" data-toggle="tooltip" data-placement="top"
                                                  title="Qualifications for Pro Tour">(?)</a></th>
                            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
                            <th>Score diff<a href="#" data-toggle="tooltip" data-placement="top"
                                             title="Diff against score before update at 2017-03-18">(?)</a>
                            </th>
                            <th>Rank diff<a href="#" data-toggle="tooltip" data-placement="top"
                                            title="Diff against rank before update at 2017-03-18">(?)</a></th>
                            <th>Country</th>
                        </tr>
                        </thead>



                        <tr class="unqual global ">
                            <td>
                                1
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Eita">Eita</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>354
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 482 pts / rank: 15<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 15 and score is 482 pts<li>AO rank is 1 and score is 354 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>17</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                2
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Daigo%20Umehara">Daigo Umehara</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RYU" data-toggle="tooltip" data-placement="top" title="Filter on Ryu">
                                    <img src="/static/images/chars/sf5/sf5_ryu.png" width="22" height="25" alt="Ryu" class="charimg" />
                                </a>

                            </td>
                            <td>353
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via CPT Regional Finals EU 2016 - SF5<li>Qualified for regionals in AO region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 9 and score is 563 pts<li>NA rank is 58 and score is 2 pts<li>AO rank is 2 and score is 353 pts<li>EU rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>15</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                3
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Mago">Mago</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>288
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via CPT Regional Finals AO 2016 - SF5<li>Qualified for regionals in AO region</ul><ul><li>Global rank is 17 and score is 426 pts<li>AO rank is 3 and score is 288 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>15</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                4
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Kazunoko">Kazunoko</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>247
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 349 pts / rank: 23<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 23 and score is 349 pts<li>AO rank is 4 and score is 247 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>17</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                5
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Xian">Xian</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_FANG" data-toggle="tooltip" data-placement="top" title="Filter on FANG">
                                    <img src="/static/images/chars/sf5/sf5_fang.png" width="22" height="25" alt="FANG" class="charimg" />
                                </a>

                            </td>
                            <td>216
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<li>Qualified for regionals in AO region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 13 and score is 520 pts<li>AO rank is 5 and score is 216 pts<li>EU rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>17</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/sg.png" class="countryflag" />
                                Singapore

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                6
                            </td>
                            <td>
                                <a href="/rankings/player/byname/GamerBee">GamerBee</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>200
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via Japan Cup 2016 - SF5<br/>via EGX 2016 - SF5<br/>opened 1 extra spots<li>Qualified for regionals in AO region</ul><ul><li>Global rank is 7 and score is 732 pts<li>AO rank is 6 and score is 200 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>14</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/tw.png" class="countryflag" />
                                Taiwan

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                7
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Haitani">Haitani</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>176
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 492 pts / rank: 14<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 14 and score is 492 pts<li>AO rank is 7 and score is 176 pts<li>EU rank is 17 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>19</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                8
                            </td>
                            <td>
                                <a href="/rankings/player/byname/GO1">GO1</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>140
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 414 pts / rank: 18<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 18 and score is 414 pts<li>NA rank is 15 and score is 64 pts<li>AO rank is 8 and score is 140 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>17</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="qual  ">
                            <td>
                                9
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Sako">Sako</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>137
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in AO region<li>Qualified by score in AO board: 137 pts / rank: 9</ul><ul><li>Global rank is 35 and score is 173 pts<li>AO rank is 9 and score is 137 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>9</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                10
                            </td>
                            <td>
                                <a href="/rankings/player/byname/MOV">MOV</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>136
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 600 pts / rank: 8<li>Qualified for regionals in AO region<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 8 and score is 600 pts<li>AO rank is 10 and score is 136 pts<li>EU rank is 3 and score is 384 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>13</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="qual  ">
                            <td>
                                11
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Tse4444">Tse4444</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>132
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in AO region<li>Qualified by score in AO board: 132 pts / rank: 11</ul><ul><li>Global rank is 41 and score is 132 pts<li>AO rank is 11 and score is 132 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>4</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/hk.png" class="countryflag" />
                                Hong Kong

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                12
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Xiaohai">Xiaohai</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via SCR 2016 - SF5<br/>via G-League 2016  - SF5<br/>opened 1 extra spots<li>Qualified for regionals in AO region</ul><ul><li>Global rank is 5 and score is 804 pts<li>AO rank is 12 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>12</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/cn.png" class="countryflag" />
                                China

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                12
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Justin%20Wong">Justin Wong</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 984 pts / rank: 3<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 3 and score is 984 pts<li>LA rank is 2 and score is 256 pts<li>NA rank is 2 and score is 520 pts<li>AO rank is 12 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>16</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                14
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Yukadon">Yukadon</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>90
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 346 pts / rank: 24<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 24 and score is 346 pts<li>AO rank is 14 and score is 90 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts</small>
                            </td>
                            <td>11</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                15
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Tokido">Tokido</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_AKUMA" data-toggle="tooltip" data-placement="top" title="Filter on Akuma">
                                    <img src="/static/images/chars/sf5/sf5_akuma.png" width="22" height="25" alt="Akuma" class="charimg" />
                                </a>

                            </td>
                            <td>80
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via SEAM 2016 - SF5<br/>via CEO 2016 - SF5<br/>opened 1 extra spots</ul><ul><li>Global rank is 2 and score is 1048 pts<li>LA rank is 22 and score is 64 pts<li>AO rank is 15 and score is 80 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct</small>
                            </td>
                            <td>13</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                16
                            </td>
                            <td>
                                <a href="/rankings/player/byname/HumanBomb">HumanBomb</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>72
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 51 and score is 88 pts<li>AO rank is 16 and score is 72 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>12</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/hk.png" class="countryflag" />
                                Hong Kong

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                17
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Chris%20Wong">Chris Wong</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>70
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 60 and score is 70 pts<li>AO rank is 17 and score is 70 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>7</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/hk.png" class="countryflag" />
                                Hong Kong

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                18
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Saunic">Saunic</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_LAURA" data-toggle="tooltip" data-placement="top" title="Filter on Laura">
                                    <img src="/static/images/chars/sf5/sf5_laura.png" width="22" height="25" alt="Laura" class="charimg" />
                                </a>

                            </td>
                            <td>68
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 60 and score is 70 pts<li>AO rank is 18 and score is 68 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>5</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                19
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Xiaohu">Xiaohu</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>67
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 64 and score is 67 pts<li>AO rank is 19 and score is 67 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>4</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/cn.png" class="countryflag" />
                                China

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                20
                            </td>
                            <td>
                                <a href="/rankings/player/byname/MindRPG">MindRPG</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_MBISON" data-toggle="tooltip" data-placement="top" title="Filter on Bison">
                                    <img src="/static/images/chars/sf5/sf5_mbison.png" width="22" height="25" alt="Bison" class="charimg" />
                                </a>

                            </td>
                            <td>66
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 66 and score is 66 pts<li>AO rank is 20 and score is 66 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>4</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/th.png" class="countryflag" />
                                Thailand

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                21
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Momochi">Momochi</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>64
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via Stunfest 2016 - SF5</ul><ul><li>Global rank is 12 and score is 528 pts<li>AO rank is 21 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct</small>
                            </td>
                            <td>10</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                22
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Itabashi%20Zangief">Itabashi Zangief</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_ZANGIEF" data-toggle="tooltip" data-placement="top" title="Filter on Gief">
                                    <img src="/static/images/chars/sf5/sf5_zangief.png" width="22" height="25" alt="Gief" class="charimg" />
                                </a>

                            </td>
                            <td>47
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in AO region</ul><ul><li>Global rank is 73 and score is 63 pts<li>AO rank is 22 and score is 47 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>14</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                23
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Bonchan">Bonchan</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>43
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 59 and score is 71 pts<li>AO rank is 23 and score is 43 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>17</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                24
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Kofmaster">Kofmaster</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_FANG" data-toggle="tooltip" data-placement="top" title="Filter on FANG">
                                    <img src="/static/images/chars/sf5/sf5_fang.png" width="22" height="25" alt="FANG" class="charimg" />
                                </a>

                            </td>
                            <td>40
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 82 and score is 40 pts<li>AO rank is 24 and score is 40 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/my.png" class="countryflag" />
                                Malaysia

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                25
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Beibei">Beibei</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>36
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 85 and score is 36 pts<li>AO rank is 25 and score is 36 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>2</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/cn.png" class="countryflag" />
                                China

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/GambleBoxer">GambleBoxer</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BALROG" data-toggle="tooltip" data-placement="top" title="Filter on Balrog">
                                    <img src="/static/images/chars/sf5/sf5_balrog.png" width="22" height="25" alt="Balrog" class="charimg" />
                                </a>

                            </td>
                            <td>33
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 90 and score is 33 pts<li>AO rank is 26 and score is 33 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/sg.png" class="countryflag" />
                                Singapore

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/NL">NL</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RYU" data-toggle="tooltip" data-placement="top" title="Filter on Ryu">
                                    <img src="/static/images/chars/sf5/sf5_ryu.png" width="22" height="25" alt="Ryu" class="charimg" />
                                </a>

                            </td>
                            <td>33
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 77 and score is 49 pts<li>AO rank is 26 and score is 33 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>5</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/kr.png" class="countryflag" />
                                Republic of Korea

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                28
                            </td>
                            <td>
                                <a href="/rankings/player/byname/SKZ">SKZ</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>20
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 107 and score is 20 pts<li>AO rank is 28 and score is 20 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/sg.png" class="countryflag" />
                                Singapore

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                29
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Gackt">Gackt</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>18
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 111 and score is 18 pts<li>AO rank is 29 and score is 18 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/sg.png" class="countryflag" />
                                Singapore

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                29
                            </td>
                            <td>
                                <a href="/rankings/player/byname/K-Brad">K-Brad</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>18
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified for regionals in NA region</ul><ul><li>Global rank is 25 and score is 332 pts<li>LA rank is 4 and score is 196 pts<li>NA rank is 16 and score is 48 pts<li>AO rank is 29 and score is 18 pts<li>EU rank is 61 and score is 2 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>22</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                    </table>
                </div>



                <h3>LA Regional Board</h3>
                The first two non-qualified players will directly qualify for Capcom Cup. Global board ranking has precedence, so players qualifying by global points are excluded for direct qualifaction in the region.
                Green means directly qualified, yellow means qualified via global. Blue players will qualify via their regional score.
                Note that 1 player in regional finals will qualify directly, so that may shift down the blue zone.<br/>
                <strong>Curent qualifying players:</strong>
                Brolynho and Misterio
                <p>&nbsp;</p>
                <div class="table-responsive">

                    <table class="tablehead" id="datatable3">

                        <thead>
                        <tr class="stathead">
                            <th>CPT Rank</th>
                            <th>Name</th>
                            <th>Character</th>
                            <th>Regional Score <a href="#" data-toggle="tooltip" data-placement="top"
                                                  title="Score as granted by the Capcom Pro Tour 2016 ranking system for region">(?)</a>
                            </th>
                            <th>Qualifications <a href="#" data-toggle="tooltip" data-placement="top"
                                                  title="Qualifications for Pro Tour">(?)</a></th>
                            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
                            <th>Score diff<a href="#" data-toggle="tooltip" data-placement="top"
                                             title="Diff against score before update at 2017-03-18">(?)</a>
                            </th>
                            <th>Rank diff<a href="#" data-toggle="tooltip" data-placement="top"
                                            title="Diff against rank before update at 2017-03-18">(?)</a></th>
                            <th>Country</th>
                        </tr>
                        </thead>



                        <tr class="qual  ">
                            <td>
                                1
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Brolynho">Brolynho</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>305
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified by score in LA board: 305 pts / rank: 1</ul><ul><li>Global rank is 26 and score is 305 pts<li>LA rank is 1 and score is 305 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>7</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/br.png" class="countryflag" />
                                Brazil

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                2
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Justin%20Wong">Justin Wong</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>256
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 984 pts / rank: 3<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 3 and score is 984 pts<li>LA rank is 2 and score is 256 pts<li>NA rank is 2 and score is 520 pts<li>AO rank is 12 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>16</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="qual  ">
                            <td>
                                3
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Misterio">Misterio</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>203
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified by score in LA board: 203 pts / rank: 3</ul><ul><li>Global rank is 31 and score is 203 pts<li>LA rank is 3 and score is 203 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>6</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/cl.png" class="countryflag" />
                                Chile

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                4
                            </td>
                            <td>
                                <a href="/rankings/player/byname/K-Brad">K-Brad</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>196
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified for regionals in NA region</ul><ul><li>Global rank is 25 and score is 332 pts<li>LA rank is 4 and score is 196 pts<li>NA rank is 16 and score is 48 pts<li>AO rank is 29 and score is 18 pts<li>EU rank is 61 and score is 2 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>22</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                5
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Jiewa">Jiewa</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>193
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 28 and score is 276 pts<li>LA rank is 5 and score is 193 pts<li>NA rank is 20 and score is 36 pts<li>AO rank is 47 and score is 7 pts<li>EU rank is 20 and score is 40 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>15</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/cn.png" class="countryflag" />
                                China

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                6
                            </td>
                            <td>
                                <a href="/rankings/player/byname/KusanagiMX">KusanagiMX</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>172
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 36 and score is 172 pts<li>LA rank is 6 and score is 172 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>5</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/mx.png" class="countryflag" />
                                Mexico

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                7
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Dark817">Dark817</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_ALEX" data-toggle="tooltip" data-placement="top" title="Filter on Alex">
                                    <img src="/static/images/chars/sf5/sf5_alex.png" width="22" height="25" alt="Alex" class="charimg" />
                                </a>

                            </td>
                            <td>135
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 39 and score is 135 pts<li>LA rank is 7 and score is 135 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>5</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/br.png" class="countryflag" />
                                Brazil

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                8
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Baek">Baek</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>132
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 41 and score is 132 pts<li>LA rank is 8 and score is 132 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/cl.png" class="countryflag" />
                                Chile

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                9
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Chris%20Tatarian">Chris Tatarian</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 386 pts / rank: 21<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 21 and score is 386 pts<li>LA rank is 9 and score is 128 pts<li>NA rank is 7 and score is 190 pts<li>EU rank is 17 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>14</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                9
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Crossover">Crossover</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_MBISON" data-toggle="tooltip" data-placement="top" title="Filter on Bison">
                                    <img src="/static/images/chars/sf5/sf5_mbison.png" width="22" height="25" alt="Bison" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 43 and score is 128 pts<li>LA rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>2</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/do.png" class="countryflag" />
                                Dominican Republic

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                9
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Filipino%20Champ">Filipino Champ</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_DHALSIM" data-toggle="tooltip" data-placement="top" title="Filter on Dhalsim">
                                    <img src="/static/images/chars/sf5/sf5_dhalsim.png" width="22" height="25" alt="Dhalsim" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 400 pts / rank: 19<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 19 and score is 400 pts<li>LA rank is 9 and score is 128 pts<li>NA rank is 4 and score is 268 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>15</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                9
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Ericke%20Maciel">Ericke Maciel</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 43 and score is 128 pts<li>LA rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>2</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/br.png" class="countryflag" />
                                Brazil

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                13
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Julio%20Fuentes">Julio Fuentes</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>96
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 548 pts / rank: 10<li>Qualified for regionals in NA region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 10 and score is 548 pts<li>LA rank is 13 and score is 96 pts<li>NA rank is 3 and score is 434 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts</small>
                            </td>
                            <td>18</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                14
                            </td>
                            <td>
                                <a href="/rankings/player/byname/MenaRD">MenaRD</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BIRDIE" data-toggle="tooltip" data-placement="top" title="Filter on Birdie">
                                    <img src="/static/images/chars/sf5/sf5_birdie.png" width="22" height="25" alt="Birdie" class="charimg" />
                                </a>

                            </td>
                            <td>84
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 53 and score is 84 pts<li>LA rank is 14 and score is 84 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>4</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/do.png" class="countryflag" />
                                Dominican Republic

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                15
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Keoma">Keoma</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>82
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 54 and score is 82 pts<li>LA rank is 15 and score is 82 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>5</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/br.png" class="countryflag" />
                                Brazil

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                16
                            </td>
                            <td>
                                <a href="/rankings/player/byname/ElTigre">ElTigre</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_LAURA" data-toggle="tooltip" data-placement="top" title="Filter on Laura">
                                    <img src="/static/images/chars/sf5/sf5_laura.png" width="22" height="25" alt="Laura" class="charimg" />
                                </a>

                            </td>
                            <td>81
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 55 and score is 81 pts<li>LA rank is 16 and score is 81 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/mx.png" class="countryflag" />
                                Mexico

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                17
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Will2Pac">Will2Pac</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_LAURA" data-toggle="tooltip" data-placement="top" title="Filter on Laura">
                                    <img src="/static/images/chars/sf5/sf5_laura.png" width="22" height="25" alt="Laura" class="charimg" />
                                </a>

                            </td>
                            <td>80
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 33 and score is 188 pts<li>LA rank is 17 and score is 80 pts<li>NA rank is 46 and score is 4 pts<li>EU rank is 13 and score is 88 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>12</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                18
                            </td>
                            <td>
                                <a href="/rankings/player/byname/DR%20Ray">DR Ray</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_VEGA" data-toggle="tooltip" data-placement="top" title="Filter on Vega">
                                    <img src="/static/images/chars/sf5/sf5_vega.png" width="22" height="25" alt="Vega" class="charimg" />
                                </a>

                            </td>
                            <td>72
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via CPT Regional Finals LA 2016 - SF5<li>Qualified for regionals in LA region</ul><ul><li>Global rank is 51 and score is 88 pts<li>LA rank is 18 and score is 72 pts<li>NA rank is 26 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>6</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/do.png" class="countryflag" />
                                Dominican Republic

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                18
                            </td>
                            <td>
                                <a href="/rankings/player/byname/DeathGun">DeathGun</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RYU" data-toggle="tooltip" data-placement="top" title="Filter on Ryu">
                                    <img src="/static/images/chars/sf5/sf5_ryu.png" width="22" height="25" alt="Ryu" class="charimg" />
                                </a>

                            </td>
                            <td>72
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 58 and score is 72 pts<li>LA rank is 18 and score is 72 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>2</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/br.png" class="countryflag" />
                                Brazil

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                20
                            </td>
                            <td>
                                <a href="/rankings/player/byname/ZeusB">ZeusB</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>68
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 62 and score is 68 pts<li>LA rank is 20 and score is 68 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/br.png" class="countryflag" />
                                Brazil

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                21
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Chancho%20Kay">Chancho Kay</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_LAURA" data-toggle="tooltip" data-placement="top" title="Filter on Laura">
                                    <img src="/static/images/chars/sf5/sf5_laura.png" width="22" height="25" alt="Laura" class="charimg" />
                                </a>

                            </td>
                            <td>66
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 66 and score is 66 pts<li>LA rank is 21 and score is 66 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/cl.png" class="countryflag" />
                                Chile

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                22
                            </td>
                            <td>
                                <a href="/rankings/player/byname/CapitanMDLuffy">CapitanMDLuffy</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_MBISON" data-toggle="tooltip" data-placement="top" title="Filter on Bison">
                                    <img src="/static/images/chars/sf5/sf5_mbison.png" width="22" height="25" alt="Bison" class="charimg" />
                                </a>

                            </td>
                            <td>64
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 70 and score is 64 pts<li>LA rank is 22 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>1</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/ar.png" class="countryflag" />
                                Argentina

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                22
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Gama">Gama</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>64
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 70 and score is 64 pts<li>LA rank is 22 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>2</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/mx.png" class="countryflag" />
                                Mexico

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                22
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Tokido">Tokido</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_AKUMA" data-toggle="tooltip" data-placement="top" title="Filter on Akuma">
                                    <img src="/static/images/chars/sf5/sf5_akuma.png" width="22" height="25" alt="Akuma" class="charimg" />
                                </a>

                            </td>
                            <td>64
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via SEAM 2016 - SF5<br/>via CEO 2016 - SF5<br/>opened 1 extra spots</ul><ul><li>Global rank is 2 and score is 1048 pts<li>LA rank is 22 and score is 64 pts<li>AO rank is 15 and score is 80 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct</small>
                            </td>
                            <td>13</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                25
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Pikoro">Pikoro</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_MBISON" data-toggle="tooltip" data-placement="top" title="Filter on Bison">
                                    <img src="/static/images/chars/sf5/sf5_mbison.png" width="22" height="25" alt="Bison" class="charimg" />
                                </a>

                            </td>
                            <td>44
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 80 and score is 44 pts<li>LA rank is 25 and score is 44 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/pe.png" class="countryflag" />
                                Peru

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/DidimoKOF">DidimoKOF</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_DHALSIM" data-toggle="tooltip" data-placement="top" title="Filter on Dhalsim">
                                    <img src="/static/images/chars/sf5/sf5_dhalsim.png" width="22" height="25" alt="Dhalsim" class="charimg" />
                                </a>

                            </td>
                            <td>36
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 85 and score is 36 pts<li>LA rank is 26 and score is 36 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/br.png" class="countryflag" />
                                Brazil

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Goro">Goro</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BIRDIE" data-toggle="tooltip" data-placement="top" title="Filter on Birdie">
                                    <img src="/static/images/chars/sf5/sf5_birdie.png" width="22" height="25" alt="Birdie" class="charimg" />
                                </a>

                            </td>
                            <td>36
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 85 and score is 36 pts<li>LA rank is 26 and score is 36 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>2</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/mx.png" class="countryflag" />
                                Mexico

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                28
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Cabe%C3%A7a">Cabeça</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>34
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 88 and score is 34 pts<li>LA rank is 28 and score is 34 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>2</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/br.png" class="countryflag" />
                                Brazil

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                28
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Erickof">Erickof</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_JURI" data-toggle="tooltip" data-placement="top" title="Filter on Juri">
                                    <img src="/static/images/chars/sf5/sf5_juri.png" width="22" height="25" alt="Juri" class="charimg" />
                                </a>

                            </td>
                            <td>34
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 88 and score is 34 pts<li>LA rank is 28 and score is 34 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>2</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/do.png" class="countryflag" />
                                Dominican Republic

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                30
                            </td>
                            <td>
                                <a href="/rankings/player/byname/K3lvinZetsu3i">K3lvinZetsu3i</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>33
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 90 and score is 33 pts<li>LA rank is 30 and score is 33 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>2</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/br.png" class="countryflag" />
                                Brazil

                            </td>
                        </tr>


                    </table>
                </div>



                <h3>EU Regional Board</h3>
                The first two non-qualified players will directly qualify for Capcom Cup. Global board ranking has precedence, so players qualifying by global points are excluded for direct qualifaction in the region.
                Green means directly qualified, yellow means qualified via global. Blue players will qualify via their regional score.
                Note that 1 player in regional finals will qualify directly, so that may shift down the blue zone.<br/>
                <strong>Curent qualifying players:</strong>
                Problem X and Ryan Hart
                <p>&nbsp;</p>
                <div class="table-responsive">

                    <table class="tablehead" id="datatable4">

                        <thead>
                        <tr class="stathead">
                            <th>CPT Rank</th>
                            <th>Name</th>
                            <th>Character</th>
                            <th>Regional Score <a href="#" data-toggle="tooltip" data-placement="top"
                                                  title="Score as granted by the Capcom Pro Tour 2016 ranking system for region">(?)</a>
                            </th>
                            <th>Qualifications <a href="#" data-toggle="tooltip" data-placement="top"
                                                  title="Qualifications for Pro Tour">(?)</a></th>
                            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
                            <th>Score diff<a href="#" data-toggle="tooltip" data-placement="top"
                                             title="Diff against score before update at 2017-03-18">(?)</a>
                            </th>
                            <th>Rank diff<a href="#" data-toggle="tooltip" data-placement="top"
                                            title="Diff against rank before update at 2017-03-18">(?)</a></th>
                            <th>Country</th>
                        </tr>
                        </thead>



                        <tr class="unqual global ">
                            <td>
                                1
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Luffy">Luffy</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RMIKA" data-toggle="tooltip" data-placement="top" title="Filter on Mika">
                                    <img src="/static/images/chars/sf5/sf5_rmika.png" width="22" height="25" alt="Mika" class="charimg" />
                                </a>

                            </td>
                            <td>435
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 455 pts / rank: 16<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 16 and score is 455 pts<li>EU rank is 1 and score is 435 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>15</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                2
                            </td>
                            <td>
                                <a href="/rankings/player/byname/CCL">CCL</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>397
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 397 pts / rank: 20<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 20 and score is 397 pts<li>EU rank is 2 and score is 397 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>11</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/be.png" class="countryflag" />
                                Belgium

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                3
                            </td>
                            <td>
                                <a href="/rankings/player/byname/MOV">MOV</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>384
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 600 pts / rank: 8<li>Qualified for regionals in AO region<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 8 and score is 600 pts<li>AO rank is 10 and score is 136 pts<li>EU rank is 3 and score is 384 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>13</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                4
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Mister%20Crimson">Mister Crimson</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_DHALSIM" data-toggle="tooltip" data-placement="top" title="Filter on Dhalsim">
                                    <img src="/static/images/chars/sf5/sf5_dhalsim.png" width="22" height="25" alt="Dhalsim" class="charimg" />
                                </a>

                            </td>
                            <td>353
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 361 pts / rank: 22<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 22 and score is 361 pts<li>EU rank is 4 and score is 353 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>14</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="qual  ">
                            <td>
                                5
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Problem%20X">Problem X</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BIRDIE" data-toggle="tooltip" data-placement="top" title="Filter on Birdie">
                                    <img src="/static/images/chars/sf5/sf5_birdie.png" width="22" height="25" alt="Birdie" class="charimg" />
                                </a>

                            </td>
                            <td>218
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in EU region<li>Qualified by score in EU board: 218 pts / rank: 5</ul><ul><li>Global rank is 30 and score is 222 pts<li>EU rank is 5 and score is 218 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>14</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/gb.png" class="countryflag" />
                                United Kingdom

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                6
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Phenom">Phenom</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>210
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via Dreamhack Summer 2016 - SF5<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 11 and score is 546 pts<li>EU rank is 6 and score is 210 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>10</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/no.png" class="countryflag" />
                                Norway

                            </td>
                        </tr>


                        <tr class="qual  ">
                            <td>
                                7
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Ryan%20Hart">Ryan Hart</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>143
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in EU board: 143 pts / rank: 7</ul><ul><li>Global rank is 29 and score is 275 pts<li>EU rank is 7 and score is 143 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>regional pts</small>
                            </td>
                            <td>13</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/gb.png" class="countryflag" />
                                United Kingdom

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                8
                            </td>
                            <td>
                                <a href="/rankings/player/byname/ImStillDaDaddy">ImStillDaDaddy</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                                    <img src="/static/images/chars/sf5/sf5_guile.png" width="22" height="25" alt="Guile" class="charimg" />
                                </a>

                            </td>
                            <td>133
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in EU region</ul><ul><li>Global rank is 39 and score is 135 pts<li>EU rank is 8 and score is 133 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>8</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/gb.png" class="countryflag" />
                                United Kingdom

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                9
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Xian">Xian</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_FANG" data-toggle="tooltip" data-placement="top" title="Filter on FANG">
                                    <img src="/static/images/chars/sf5/sf5_fang.png" width="22" height="25" alt="FANG" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<li>Qualified for regionals in AO region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 13 and score is 520 pts<li>AO rank is 5 and score is 216 pts<li>EU rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>17</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/sg.png" class="countryflag" />
                                Singapore

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                9
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Daigo%20Umehara">Daigo Umehara</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RYU" data-toggle="tooltip" data-placement="top" title="Filter on Ryu">
                                    <img src="/static/images/chars/sf5/sf5_ryu.png" width="22" height="25" alt="Ryu" class="charimg" />
                                </a>

                            </td>
                            <td>128
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via CPT Regional Finals EU 2016 - SF5<li>Qualified for regionals in AO region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 9 and score is 563 pts<li>NA rank is 58 and score is 2 pts<li>AO rank is 2 and score is 353 pts<li>EU rank is 9 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>15</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                11
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Packz">Packz</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>108
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 45 and score is 120 pts<li>EU rank is 11 and score is 108 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>11</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/gb.png" class="countryflag" />
                                United Kingdom

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                12
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Akainu">Akainu</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                                    <img src="/static/images/chars/sf5/sf5_guile.png" width="22" height="25" alt="Guile" class="charimg" />
                                </a>

                            </td>
                            <td>104
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 48 and score is 104 pts<li>EU rank is 12 and score is 104 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>5</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                13
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Will2Pac">Will2Pac</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_LAURA" data-toggle="tooltip" data-placement="top" title="Filter on Laura">
                                    <img src="/static/images/chars/sf5/sf5_laura.png" width="22" height="25" alt="Laura" class="charimg" />
                                </a>

                            </td>
                            <td>88
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region</ul><ul><li>Global rank is 33 and score is 188 pts<li>LA rank is 17 and score is 80 pts<li>NA rank is 46 and score is 4 pts<li>EU rank is 13 and score is 88 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>12</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                14
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Cobelcog">Cobelcog</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>81
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in EU region</ul><ul><li>Global rank is 55 and score is 81 pts<li>EU rank is 14 and score is 81 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>9</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/ie.png" class="countryflag" />
                                Ireland

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                15
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Cuongster">Cuongster</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>70
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 57 and score is 74 pts<li>EU rank is 15 and score is 70 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>5</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                16
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Big%20Bird">Big Bird</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>68
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in EU region</ul><ul><li>Global rank is 62 and score is 68 pts<li>EU rank is 16 and score is 68 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/ae.png" class="countryflag" />
                                United Arab Emirates

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                17
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Halibel">Halibel</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_DHALSIM" data-toggle="tooltip" data-placement="top" title="Filter on Dhalsim">
                                    <img src="/static/images/chars/sf5/sf5_dhalsim.png" width="22" height="25" alt="Dhalsim" class="charimg" />
                                </a>

                            </td>
                            <td>64
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 70 and score is 64 pts<li>EU rank is 17 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>1</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/de.png" class="countryflag" />
                                Germany

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                17
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Chris%20Tatarian">Chris Tatarian</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>64
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 386 pts / rank: 21<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 21 and score is 386 pts<li>LA rank is 9 and score is 128 pts<li>NA rank is 7 and score is 190 pts<li>EU rank is 17 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>14</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                17
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Haitani">Haitani</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>64
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 492 pts / rank: 14<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 14 and score is 492 pts<li>AO rank is 7 and score is 176 pts<li>EU rank is 17 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts</small>
                            </td>
                            <td>19</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                20
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Jiewa">Jiewa</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>40
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 28 and score is 276 pts<li>LA rank is 5 and score is 193 pts<li>NA rank is 20 and score is 36 pts<li>AO rank is 47 and score is 7 pts<li>EU rank is 20 and score is 40 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>15</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/cn.png" class="countryflag" />
                                China

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                21
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Gen1us">Gen1us</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BIRDIE" data-toggle="tooltip" data-placement="top" title="Filter on Birdie">
                                    <img src="/static/images/chars/sf5/sf5_birdie.png" width="22" height="25" alt="Birdie" class="charimg" />
                                </a>

                            </td>
                            <td>35
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 83 and score is 39 pts<li>EU rank is 21 and score is 35 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>5</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                22
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Brian">Brian</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>33
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 90 and score is 33 pts<li>EU rank is 22 and score is 33 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/gb.png" class="countryflag" />
                                United Kingdom

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                22
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Infexious">Infexious</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_ZANGIEF" data-toggle="tooltip" data-placement="top" title="Filter on Gief">
                                    <img src="/static/images/chars/sf5/sf5_zangief.png" width="22" height="25" alt="Gief" class="charimg" />
                                </a>

                            </td>
                            <td>33
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 84 and score is 37 pts<li>EU rank is 22 and score is 33 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>4</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/gb.png" class="countryflag" />
                                United Kingdom

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                24
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Linkexelo">Linkexelo</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>32
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 93 and score is 32 pts<li>EU rank is 24 and score is 32 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>1</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                24
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Niine90">Niine90</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NASH" data-toggle="tooltip" data-placement="top" title="Filter on Nash">
                                    <img src="/static/images/chars/sf5/sf5_nash.png" width="22" height="25" alt="Nash" class="charimg" />
                                </a>

                            </td>
                            <td>32
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 93 and score is 32 pts<li>EU rank is 24 and score is 32 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>1</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/nl.png" class="countryflag" />
                                Netherlands

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Afii">Afii</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_LAURA" data-toggle="tooltip" data-placement="top" title="Filter on Laura">
                                    <img src="/static/images/chars/sf5/sf5_laura.png" width="22" height="25" alt="Laura" class="charimg" />
                                </a>

                            </td>
                            <td>24
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 103 and score is 24 pts<li>EU rank is 26 and score is 24 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>7</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/gb.png" class="countryflag" />
                                United Kingdom

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                27
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Real%20Menace">Real Menace</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>18
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 111 and score is 18 pts<li>EU rank is 27 and score is 18 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/gb.png" class="countryflag" />
                                United Kingdom

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                28
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Valmaster">Valmaster</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>17
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 114 and score is 17 pts<li>EU rank is 28 and score is 17 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/fr.png" class="countryflag" />
                                France

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                29
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Fruit">Fruit</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_LAURA" data-toggle="tooltip" data-placement="top" title="Filter on Laura">
                                    <img src="/static/images/chars/sf5/sf5_laura.png" width="22" height="25" alt="Laura" class="charimg" />
                                </a>

                            </td>
                            <td>16
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 116 and score is 16 pts<li>EU rank is 29 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/ae.png" class="countryflag" />
                                United Arab Emirates

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                29
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Hurricane">Hurricane</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>16
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 103 and score is 24 pts<li>EU rank is 29 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>4</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/gb.png" class="countryflag" />
                                United Kingdom

                            </td>
                        </tr>


                    </table>
                </div>



                <h3>NA Regional Board</h3>
                The first two non-qualified players will directly qualify for Capcom Cup. Global board ranking has precedence, so players qualifying by global points are excluded for direct qualifaction in the region.
                Green means directly qualified, yellow means qualified via global. Blue players will qualify via their regional score.
                Note that 1 player in regional finals will qualify directly, so that may shift down the blue zone.<br/>
                <strong>Curent qualifying players:</strong>
                Ricki Ortiz and XsK Samurai
                <p>&nbsp;</p>
                <div class="table-responsive">

                    <table class="tablehead" id="datatable5">

                        <thead>
                        <tr class="stathead">
                            <th>CPT Rank</th>
                            <th>Name</th>
                            <th>Character</th>
                            <th>Regional Score <a href="#" data-toggle="tooltip" data-placement="top"
                                                  title="Score as granted by the Capcom Pro Tour 2016 ranking system for region">(?)</a>
                            </th>
                            <th>Qualifications <a href="#" data-toggle="tooltip" data-placement="top"
                                                  title="Qualifications for Pro Tour">(?)</a></th>
                            <th>Tournaments<a href="#" data-toggle="tooltip" data-placement="top"
                                              title="Amount of CPT ranking/premier tournaments played">(?)</a></th>
                            <th>Score diff<a href="#" data-toggle="tooltip" data-placement="top"
                                             title="Diff against score before update at 2017-03-18">(?)</a>
                            </th>
                            <th>Rank diff<a href="#" data-toggle="tooltip" data-placement="top"
                                            title="Diff against rank before update at 2017-03-18">(?)</a></th>
                            <th>Country</th>
                        </tr>
                        </thead>



                        <tr class="unqual  direct">
                            <td>
                                1
                            </td>
                            <td>
                                <a href="/rankings/player/byname/NuckleDu">NuckleDu</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_GUILE" data-toggle="tooltip" data-placement="top" title="Filter on Guile">
                                    <img src="/static/images/chars/sf5/sf5_guile.png" width="22" height="25" alt="Guile" class="charimg" />
                                </a>

                            </td>
                            <td>561
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via CPT Regional Finals NA 2016 - SF5<br/>via Canada Cup 2016 - SF5<br/>opened 1 extra spots<li>Qualified for regionals in NA region</ul><ul><li>Global rank is 4 and score is 869 pts<li>NA rank is 1 and score is 561 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct | RF</small>
                            </td>
                            <td>17</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                2
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Justin%20Wong">Justin Wong</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>520
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 984 pts / rank: 3<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 3 and score is 984 pts<li>LA rank is 2 and score is 256 pts<li>NA rank is 2 and score is 520 pts<li>AO rank is 12 and score is 128 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>16</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                3
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Julio%20Fuentes">Julio Fuentes</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>434
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 548 pts / rank: 10<li>Qualified for regionals in NA region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 10 and score is 548 pts<li>LA rank is 13 and score is 96 pts<li>NA rank is 3 and score is 434 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>18</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                4
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Filipino%20Champ">Filipino Champ</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_DHALSIM" data-toggle="tooltip" data-placement="top" title="Filter on Dhalsim">
                                    <img src="/static/images/chars/sf5/sf5_dhalsim.png" width="22" height="25" alt="Dhalsim" class="charimg" />
                                </a>

                            </td>
                            <td>268
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 400 pts / rank: 19<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 19 and score is 400 pts<li>LA rank is 9 and score is 128 pts<li>NA rank is 4 and score is 268 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>15</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="qual  ">
                            <td>
                                5
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Ricki%20Ortiz">Ricki Ortiz</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>247
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region<li>Qualified by score in NA board: 247 pts / rank: 5</ul><ul><li>Global rank is 27 and score is 289 pts<li>LA rank is 37 and score is 16 pts<li>NA rank is 5 and score is 247 pts<li>AO rank is 32 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>21</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="qual  ">
                            <td>
                                6
                            </td>
                            <td>
                                <a href="/rankings/player/byname/XsK%20Samurai">XsK Samurai</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RYU" data-toggle="tooltip" data-placement="top" title="Filter on Ryu">
                                    <img src="/static/images/chars/sf5/sf5_ryu.png" width="22" height="25" alt="Ryu" class="charimg" />
                                </a>

                            </td>
                            <td>202
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region<li>Qualified by score in NA board: 202 pts / rank: 6</ul><ul><li>Global rank is 32 and score is 202 pts<li>NA rank is 6 and score is 202 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF | regional pts</small>
                            </td>
                            <td>12</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                7
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Chris%20Tatarian">Chris Tatarian</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>190
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 386 pts / rank: 21<li>Qualified for regionals in LA region<li>Qualified for regionals in NA region<li>Qualified for regionals in EU region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 21 and score is 386 pts<li>LA rank is 9 and score is 128 pts<li>NA rank is 7 and score is 190 pts<li>EU rank is 17 and score is 64 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts | RF</small>
                            </td>
                            <td>14</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                8
                            </td>
                            <td>
                                <a href="/rankings/player/byname/John%20Takeuchi">John Takeuchi</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RASHID" data-toggle="tooltip" data-placement="top" title="Filter on Rashid">
                                    <img src="/static/images/chars/sf5/sf5_rashid.png" width="22" height="25" alt="Rashid" class="charimg" />
                                </a>

                            </td>
                            <td>144
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 34 and score is 181 pts<li>NA rank is 8 and score is 144 pts<li>AO rank is 96 and score is 1 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>7</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                9
                            </td>
                            <td>
                                <a href="/rankings/player/byname/PR%20Balrog">PR Balrog</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BALROG" data-toggle="tooltip" data-placement="top" title="Filter on Balrog">
                                    <img src="/static/images/chars/sf5/sf5_balrog.png" width="22" height="25" alt="Balrog" class="charimg" />
                                </a>

                            </td>
                            <td>142
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 37 and score is 158 pts<li>LA rank is 48 and score is 8 pts<li>NA rank is 9 and score is 142 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>13</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                10
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Alucard">Alucard</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_BALROG" data-toggle="tooltip" data-placement="top" title="Filter on Balrog">
                                    <img src="/static/images/chars/sf5/sf5_balrog.png" width="22" height="25" alt="Balrog" class="charimg" />
                                </a>

                            </td>
                            <td>110
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 46 and score is 110 pts<li>NA rank is 10 and score is 110 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>13</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                11
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Ludovic">Ludovic</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>98
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 49 and score is 102 pts<li>NA rank is 11 and score is 98 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>7</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                12
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Flash">Flash</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_VEGA" data-toggle="tooltip" data-placement="top" title="Filter on Vega">
                                    <img src="/static/images/chars/sf5/sf5_vega.png" width="22" height="25" alt="Vega" class="charimg" />
                                </a>

                            </td>
                            <td>92
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 46 and score is 110 pts<li>LA rank is 48 and score is 8 pts<li>NA rank is 12 and score is 92 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>11</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                13
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Punk">Punk</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>65
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in NA region</ul><ul><li>Global rank is 68 and score is 65 pts<li>NA rank is 13 and score is 65 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                13
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Takuyasugi">Takuyasugi</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_ALEX" data-toggle="tooltip" data-placement="top" title="Filter on Alex">
                                    <img src="/static/images/chars/sf5/sf5_alex.png" width="22" height="25" alt="Alex" class="charimg" />
                                </a>

                            </td>
                            <td>65
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 68 and score is 65 pts<li>NA rank is 13 and score is 65 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual global ">
                            <td>
                                15
                            </td>
                            <td>
                                <a href="/rankings/player/byname/GO1">GO1</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>64
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified by score in global board: 414 pts / rank: 18<li>Qualified for regionals in AO region<li>Currently in global top24 so likely to qualify by points</ul><ul><li>Global rank is 18 and score is 414 pts<li>NA rank is 15 and score is 64 pts<li>AO rank is 8 and score is 140 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>global pts</small>
                            </td>
                            <td>17</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/jp.png" class="countryflag" />
                                Japan

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                16
                            </td>
                            <td>
                                <a href="/rankings/player/byname/K-Brad">K-Brad</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>48
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified for regionals in NA region</ul><ul><li>Global rank is 25 and score is 332 pts<li>LA rank is 4 and score is 196 pts<li>NA rank is 16 and score is 48 pts<li>AO rank is 29 and score is 18 pts<li>EU rank is 61 and score is 2 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small>RF</small>
                            </td>
                            <td>22</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                17
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Hsien%20Chang">Hsien Chang</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>47
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 76 and score is 51 pts<li>NA rank is 17 and score is 47 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>8</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                18
                            </td>
                            <td>
                                <a href="/rankings/player/byname/RayRay">RayRay</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>45
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 79 and score is 45 pts<li>NA rank is 18 and score is 45 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>10</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                19
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Snake%20Eyez">Snake Eyez</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_ZANGIEF" data-toggle="tooltip" data-placement="top" title="Filter on Gief">
                                    <img src="/static/images/chars/sf5/sf5_zangief.png" width="22" height="25" alt="Gief" class="charimg" />
                                </a>

                            </td>
                            <td>38
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 74 and score is 58 pts<li>LA rank is 37 and score is 16 pts<li>NA rank is 19 and score is 38 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>13</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                20
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Jiewa">Jiewa</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>36
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified for regionals in LA region<li>Qualified for regionals in EU region</ul><ul><li>Global rank is 28 and score is 276 pts<li>LA rank is 5 and score is 193 pts<li>NA rank is 20 and score is 36 pts<li>AO rank is 47 and score is 7 pts<li>EU rank is 20 and score is 40 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>15</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/cn.png" class="countryflag" />
                                China

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                21
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Saionide">Saionide</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KEN" data-toggle="tooltip" data-placement="top" title="Filter on Ken">
                                    <img src="/static/images/chars/sf5/sf5_ken.png" width="22" height="25" alt="Ken" class="charimg" />
                                </a>

                            </td>
                            <td>32
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 93 and score is 32 pts<li>NA rank is 21 and score is 32 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>3</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                22
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Alex%20Myers">Alex Myers</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CAMMY" data-toggle="tooltip" data-placement="top" title="Filter on Cammy">
                                    <img src="/static/images/chars/sf5/sf5_cammy.png" width="22" height="25" alt="Cammy" class="charimg" />
                                </a>

                            </td>
                            <td>28
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 80 and score is 44 pts<li>NA rank is 22 and score is 28 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>7</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                22
                            </td>
                            <td>
                                <a href="/rankings/player/byname/LPN">LPN</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_URIEN" data-toggle="tooltip" data-placement="top" title="Filter on Urien">
                                    <img src="/static/images/chars/sf5/sf5_urien.png" width="22" height="25" alt="Urien" class="charimg" />
                                </a>

                            </td>
                            <td>28
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 102 and score is 28 pts<li>NA rank is 22 and score is 28 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>11</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                24
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Filipinoman">Filipinoman</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_CHUNLI" data-toggle="tooltip" data-placement="top" title="Filter on Chun">
                                    <img src="/static/images/chars/sf5/sf5_chunli.png" width="22" height="25" alt="Chun" class="charimg" />
                                </a>

                            </td>
                            <td>20
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 93 and score is 32 pts<li>NA rank is 24 and score is 20 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>7</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                25
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Stupendous">Stupendous</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_ZANGIEF" data-toggle="tooltip" data-placement="top" title="Filter on Gief">
                                    <img src="/static/images/chars/sf5/sf5_zangief.png" width="22" height="25" alt="Gief" class="charimg" />
                                </a>

                            </td>
                            <td>17
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 110 and score is 19 pts<li>NA rank is 25 and score is 17 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>7</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Shine">Shine</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_KARIN" data-toggle="tooltip" data-placement="top" title="Filter on Karin">
                                    <img src="/static/images/chars/sf5/sf5_karin.png" width="22" height="25" alt="Karin" class="charimg" />
                                </a>

                            </td>
                            <td>16
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 116 and score is 16 pts<li>NA rank is 26 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>4</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Sabaody">Sabaody</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RMIKA" data-toggle="tooltip" data-placement="top" title="Filter on Mika">
                                    <img src="/static/images/chars/sf5/sf5_rmika.png" width="22" height="25" alt="Mika" class="charimg" />
                                </a>

                            </td>
                            <td>16
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 116 and score is 16 pts<li>NA rank is 26 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>1</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Vagabond">Vagabond</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_NECALLI" data-toggle="tooltip" data-placement="top" title="Filter on Necalli">
                                    <img src="/static/images/chars/sf5/sf5_necalli.png" width="22" height="25" alt="Necalli" class="charimg" />
                                </a>

                            </td>
                            <td>16
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 116 and score is 16 pts<li>NA rank is 26 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>4</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                        <tr class="unqual  direct">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/DR%20Ray">DR Ray</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_VEGA" data-toggle="tooltip" data-placement="top" title="Filter on Vega">
                                    <img src="/static/images/chars/sf5/sf5_vega.png" width="22" height="25" alt="Vega" class="charimg" />
                                </a>

                            </td>
                            <td>16
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul><li>Qualified directly in global board<br/>via CPT Regional Finals LA 2016 - SF5<li>Qualified for regionals in LA region</ul><ul><li>Global rank is 51 and score is 88 pts<li>LA rank is 18 and score is 72 pts<li>NA rank is 26 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <img src="http://capcomprotour.com/wp-content/uploads/2014/03/logo-qualified.jpg" width="24"
                                     height="24"/>

                                <small>direct</small>
                            </td>
                            <td>6</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/do.png" class="countryflag" />
                                Dominican Republic

                            </td>
                        </tr>


                        <tr class="unqual  ">
                            <td>
                                26
                            </td>
                            <td>
                                <a href="/rankings/player/byname/Fubarduck">Fubarduck</a>
                            </td>
                            <td>

                                <a href="/rankings/rank/SF5?pchar=SF5_RMIKA" data-toggle="tooltip" data-placement="top" title="Filter on Mika">
                                    <img src="/static/images/chars/sf5/sf5_rmika.png" width="22" height="25" alt="Mika" class="charimg" />
                                </a>

                            </td>
                            <td>16
                            </td>
                            <td>
                                <button type="button" class="btn btn-xs btn-info" data-container="body" data-toggle="popover" data-placement="bottom"
                                        data-content="Qualifications: <ul></ul><ul><li>Global rank is 116 and score is 16 pts<li>NA rank is 26 and score is 16 pts</ul>"
                                        data-html="true" data-trigger="focus">
                                    info
                                </button>

                                <small></small>
                            </td>
                            <td>6</td>

                            <td>+0</td>
                            <td class="">


                            </td>


                            <td>

                                <img src="/static/images/countries/us.png" class="countryflag" />
                                United States

                            </td>
                        </tr>


                    </table>
                </div>



                <div class="row" align="center">
                    <div class="col-md-12" align="center">
                        <script type="text/javascript">
                            amzn_assoc_placement = "adunit0";
                            amzn_assoc_search_bar = "false";
                            amzn_assoc_tracking_id = "fgwora-20";
                            amzn_assoc_ad_mode = "search";
                            amzn_assoc_ad_type = "smart";
                            amzn_assoc_marketplace = "amazon";
                            amzn_assoc_region = "US";
                            amzn_assoc_title = "Shop Related Products";
                            amzn_assoc_default_search_phrase = "nintendo switch";
                            amzn_assoc_default_category = "All";
                            amzn_assoc_linkid = "919899be79cdf14ca1b81c0b22f6c130";
                        </script>
                        <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US"></script>
                    </div>

                    <script type="text/javascript" charset="utf-8">
                        $(document).ready(function () {
                            $('table[id^="datatable"]').each(function (index) {
                                try {
                                    $(this).tablecloth({
                                        theme: "default",
                                        striped: false,
                                        sortable: true,
                                        condensed: true
                                    })
                                }
                                catch (err) {
                                }
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