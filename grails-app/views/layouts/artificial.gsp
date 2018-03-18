<%@ page import="org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <r:layoutResources/>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <title><g:layoutTitle/></title>

    <link rel="shortcut icon" href="${resource(dir: 'assets/img', file: 'favicon.png')}" />

    <meta name="description" content="">

    <!-- CSS -->
    <link href="${resource(dir: 'assets/css', file: 'preload.css')}" rel="stylesheet">

    <!-- Compiled in vendors.js -->
    <!--
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/bootstrap-switch.min.css" rel="stylesheet">
    <link href="assets/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/css/animate.min.css" rel="stylesheet">
    <link href="assets/css/slidebars.min.css" rel="stylesheet">
    <link href="assets/css/lightbox.css" rel="stylesheet">
    <link href="assets/css/jquery.bxslider.css" rel="stylesheet" />
    <link href="assets/css/buttons.css" rel="stylesheet">
    -->

    <link href="${resource(dir: 'assets/css', file: 'vendors.css')}" rel="stylesheet">
    <link href="${resource(dir: 'assets/css/syntaxhighlighter', file: 'shCore.css')}" rel="stylesheet" >

    <!-- RS5.0 Stylesheet -->
    <!--<link rel="stylesheet" type="text/css" href="assets/css/settings.css">
    <link rel="stylesheet" type="text/css" href="assets/css/layers.css">
    <link rel="stylesheet" type="text/css" href="assets/css/navigation.css">-->

    <link href="${resource(dir: 'assets/css', file: 'style-blue2.css')}" rel="stylesheet" title="default">
    <link href="${resource(dir: 'assets/css', file: 'width-full.css')}" rel="stylesheet" title="default">



    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <script src="${resource(dir: 'assets/js', file: 'html5shiv.min.js')}"></script>
        <script src="${resource(dir: 'assets/js', file: 'respond.min.js')}"></script>
    <![endif]-->

    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.0/themes/smoothness/jquery-ui.css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'tablecloth.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'prettify.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'artificial-custom.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-tables.css')}" type="text/css">

    <!-- Facebook Pixel Code -->
    <script>
        !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
            n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
            n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
            t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
            document,'script','//connect.facebook.net/en_US/fbevents.js');

        fbq('init', '1552062418442064');
        fbq('track', "PageView");</script>
    <noscript>
        <img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=1552062418442064&ev=PageView&noscript=1"/>
    </noscript>

    <script src="${resource(dir: 'assets/js', file: 'vendors.js')}"></script>


</head>

<!-- Preloader -->
<div id="preloader">
    <div id="status">&nbsp;</div>
</div>

<body>

<div class="sb-site-container">
    <div class="boxed">


        <nav class="navbar navbar-default navbar-dark yamm navbar-static-top" role="navigation" id="header">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <i class="fa fa-bars"></i>
                    </button>
                    <a id="ar-brand" class="navbar-brand" href="/">data</a>
                </div> <!-- navbar-header -->

            <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="pull-right">
                    <a href="javascript:void(0);" class="sb-icon-navbar sb-toggle-right"><i class="fa fa-bars"></i></a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">Rankings</a>
                            <ul class="dropdown-menu dropdown-menu-left animated-2x animated fadeIn">
                                <li><g:link action="index" controller="rankings">Overview</g:link></li>
                                <li><g:link action="teams" controller="rankings">Player Teams</g:link></li>
                                <li><g:link action="index" controller="stats">Character Balance and Tiers</g:link></li>
                                <li class="divider"></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.SF5.name()]">World Rankings Street Fighter 5</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.MVCI.name()]">World Rankings Marvel Infinite</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.DBFZ.name()]">World Rankings Dragon Ball Fighterz</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.MKX.name()]">World Rankings Mortal Kombat X</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.T7.name()]">World Rankings Tekken 7</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.INJUSTICE2.name()]">World Rankings Injustice 2</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.GGXRD.name()]">World Rankings Guilty Gear</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.UMVC3.name()]">World Rankings Marvel vs Capcom 3</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.KI.name()]">World Rankings Killer Instinct</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.SKULLGIRLS.name()]">World Rankings Skullgirls</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.BBCP.name()]">World Rankings Blazblue</g:link></li>
                                <li class="divider"></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.IGAU.name()]">World Rankings Injustice</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.USF4.name()]">World Rankings Ultra SF4</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.AE2012.name()]">World Rankings SF4:AE 2012</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.AE.name()]">World Rankings SF4:AE</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.SUPER.name()]">World Rankings SSF4</g:link></li>
                                <li><g:link action="rank" controller="rankings"
                                            params="['id': Version.VANILLA.name()]">World Rankings SF4</g:link></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">Tournaments</a>
                            <ul class="dropdown-menu dropdown-menu-left animated-2x animated fadeIn">
                                <li><g:link action="events" controller="rankings">Events</g:link></li>
                                <li class="divider"></li>
                                <li><g:link action="tournaments" controller="rankings" params="['id': Version.SF5.name()]">Street Fighter 5</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.MVCI.name()]">Marvel Infinite</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.DBFZ.name()]">Dragon Ball Fighterz</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.MKX.name()]">Mortal Kombat X</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.INJUSTICE2.name()]">Injustice 2</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.GGXRD.name()]">Guilty Gear Xrd</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.T7.name()]">Tekken 7</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.UMVC3.name()]">Marvel vs Capcom 3</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.KI.name()]">Killer Instinct</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.SKULLGIRLS.name()]">Skullgirls</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.BBCP.name()]">Blazblue CP</g:link></li>
                                <li class="divider"></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.IGAU.name()]">Injustice</g:link></li>
                                <li><g:link action="tournaments" controller="rankings" params="['id': Version.USF4.name()]">USF4</g:link></li>
                                <li><g:link action="tournaments" controller="rankings"
                                            params="['id': Version.AE2012.name()]">SF4:AE 2012</g:link></li>
                                <li><g:link action="tournaments" controller="rankings" params="['id': Version.AE.name()]">SF4:AE</g:link></li>
                                <li><g:link action="tournaments" controller="rankings" params="['id': Version.SUPER.name()]">SSF4</g:link></li>
                                <li><g:link action="tournaments" controller="rankings" params="['id': Version.VANILLA.name()]">SF4</g:link></li>
                            </ul>
                        </li>
                        <li><g:link controller="gear">Controllers</g:link></li>


                        <li class="dropdown">
                            <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">Capcom Pro Tour</a>
                            <ul class="dropdown-menu dropdown-menu-left animated-2x animated fadeIn">
                                <li><g:link action="cpt" controller="rankings">Standings</g:link></li>
                                <li><g:link action="cptStats" controller="rankings">Tournaments and countries</g:link></li>
                                <li><g:link action="cptCharacterStats" controller="rankings">Players and Characters</g:link></li>
                                <li class="divider"></li>
                                <li><g:link action="cpt_2015" controller="rankings">Archived Standings 2015</g:link></li>
                                <li><g:link action="cptStats_2015" controller="rankings">Archived Tournaments and countries 2015</g:link></li>
                                <li><g:link action="cptCharacterStats_2015" controller="rankings">Archived Characters used 2015</g:link></li>
                                <li class="divider"></li>
                                <li><g:link action="cpt_2016" controller="rankings">Archived Standings 2016</g:link></li>
                                <li><g:link action="cptStats_2016" controller="rankings">Archived Tournaments and countries 2016</g:link></li>
                                <li><g:link action="cptCharacterStats_2016" controller="rankings">Archived Characters used 2016</g:link></li>
                                <li class="divider"></li>
                                <li><g:link action="cpt_2017" controller="rankings">Archived Standings 2017</g:link></li>
                                <li><g:link action="cptStats_2017" controller="rankings">Archived Tournaments and countries 2017</g:link></li>
                                <li><g:link action="cptCharacterStats_2017" controller="rankings">Archived Characters used 2017</g:link></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">About</a>
                            <ul class="dropdown-menu dropdown-menu-left animated-2x animated fadeIn">
                                <li><g:link controller="about">FAQ</g:link></li>
                                <li class="divider"></li>
                                <li><g:link controller="submit">Submit new tournament</g:link></li>
                                <li><g:link controller="submit" action="list">List submitted tournaments</g:link></li>
                                <li class="divider"></li>
                                <li><g:link controller="api">Public REST/JSON API</g:link></li>
                            </ul>
                        </li>
                        <g:if test="${SecurityUtils.subject.hasRole("Administrator")}">
                            <li class="dropdown">
                                <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">Admin</a>
                                <ul class="dropdown-menu dropdown-menu-left animated-2x animated fadeIn">
                                    <li><g:link action="index" controller="admin">[Actions]</g:link></li>
                                    <li><g:link action="index" controller="tournament">[Tournaments]</g:link></li>
                                    <li><g:link action="index" controller="player">[Players]</g:link></li>
                                    <li><g:link action="index" controller="result">[Results]</g:link></li>
                                    <li><g:link action="index" controller="team">[Teams]</g:link></li>
                                    <li><g:link action="index" controller="user">[User]</g:link></li>
                                    <li><g:link action="index" controller="tournamentReview">[Review]</g:link></li>
                                    <li><g:link action="index" controller="hardware">[Hardware]</g:link></li>
                                    <li><g:link action="index" controller="query">[Query]</g:link></li>
                                    <li><g:link action="index" controller="configuration">[Configuration]</g:link></li>
                                    <li><g:link action="signOut"
                                                controller="auth">[Sign out ${org.apache.shiro.SecurityUtils.subject.principal}]</g:link></li>
                                </ul>
                            </li>
                        </g:if>
                        <g:elseif test="${SecurityUtils.subject.hasRole("Moderator")}">
                            <li class="dropdown">
                                <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">Mod</a>
                                <ul class="dropdown-menu dropdown-menu-left animated-2x animated fadeIn">
                                    <li><g:link action="index" controller="admin">[Actions]</g:link></li>
                                    <li><g:link action="index" controller="tournament">[Tournaments]</g:link></li>
                                    <li><g:link action="index" controller="player">[Players]</g:link></li>
                                    <li><g:link action="index" controller="result">[Results]</g:link></li>
                                    <li><g:link action="index" controller="team">[Teams]</g:link></li>
                                    <li><g:link action="index" controller="tournamentReview">[Reviews]</g:link></li>
                                    <li><g:link action="index" controller="hardware">[Hardware]</g:link></li>
                                    <li><g:link action="index" controller="query">[Query]</g:link></li>
                                    <li><g:link action="signOut"
                                                controller="auth">[Sign out ${org.apache.shiro.SecurityUtils.subject.principal}]</g:link></li>
                                </ul>
                            </li>
                        </g:elseif>

                    </ul>
                </div><!-- navbar-collapse -->
            </div><!-- container -->
        </nav>

        <header class="main-header">
            <div class="container">
                <h1 class="page-title"><g:layoutTitle/></h1>

 %{--               <ol class="breadcrumb pull-right">
                    <li><a href="#">Pages</a></li>
                    <li><a href="#">About us & Team</a></li>
                    <li class="active">About us Option 2</li>
                </ol>--}%
            </div>
        </header>

        <div class="container">
            <div class="row">
                <g:layoutBody/>
            </div> <!-- row -->
        </div> <!-- container -->

        <aside id="footer-widgets">
            <div class="container">
                <div class="row">
                        <div class="col-md-6">
                            <h4>SRK Data &copy; 2013-2017 Bavo Bruylandt</h4>
                        </div>
                </div> <!-- row -->
                <div class="row">
                Developed by <a href="https://twitter.com/bavobbr">Bavo Bruylandt</a> &middot; Hosted on <a
                        href="http://www.shoryuken.com">Shoryuken</a> &middot; Follow us on Twitter at <a
                        href="https://twitter.com/SRKRanking">@SRKranking</a>
                </div>
            </div> <!-- container -->
        </aside> <!-- footer-widgets -->
        <footer id="footer">
            <p>&copy; 2017 <a href="#">SRK</a>, inc. All rights reserved.</p>
        </footer>

    </div> <!-- boxed -->
</div> <!-- sb-site -->

<div class="sb-slidebar sb-right sb-style-overlay">

%{--    <form class="navbar-form navbar-right top-search" role="search"
          action="${createLink(action: 'search', controller: 'rankings')}" id="searchForm">
        <div class="form-group">
            <input type="text" id="playerSearch" class="form-control" placeholder="Find a Player" name="player"
                   title="Press <ENTER> for advanced search">
            <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
            </span>
        </div>

        <div class="form-group">
            <input id="tournamentSearch" class="form-control" placeholder="Search Tournaments" name="tournament">
        </div>
    </form>--}%
    <form role="search"
          action="${createLink(action: 'search', controller: 'rankings')}" id="searchForm">
        <div class="input-group">
            <input type="text" id="playerSearch" class="form-control" placeholder="Find a Player" name="player"
                   title="Press <ENTER> for advanced search">
            <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
            </span>
        </div>
    </form>

    <form role="search"
          action="${createLink(action: 'searchTournament', controller: 'rankings')}" id="searchTournamentForm">
        <div class="input-group">
            <input type="text" id="tournamentSearch" class="form-control" placeholder="Find a Tournament" name="tournament"
                   title="Press <ENTER> for advanced search">
            <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
            </span>
        </div>
    </form>

%{--    <form role="search"
          action="${createLink(action: 'search', controller: 'rankings')}" id="searchForm">
        <div class="input-group">
            <input type="text" id="tournamentSearch" class="form-control" placeholder="Find a Tournament" name="tournament"
                   title="Press <ENTER> for advanced search">
            <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
            </span>
        </div>
    </form>--}%

%{--    <div class="input-group">
        <input type="text" class="form-control" placeholder="Search...">
        <span class="input-group-btn">
            <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
        </span>
    </div><!-- /input-group -->--}%

    <h2 class="slidebar-header no-margin-bottom">Navigation</h2>
    <ul class="slidebar-menu">
        <li><g:link controller="rankings" action="index">Home</g:link></li>
        <li><g:link controller="rankings" action="cpt">Pro Tour</g:link></li>
        <li><g:link controller="rankings" action="teams">Teams</g:link></li>
        <li><g:link controller="rankings" action="events">Events</g:link></li>
        <li><g:link controller="rankings" action="rank" params="[id: Version.SF5.name()]">SF5 rankings</g:link></li>
        <li><g:link controller="rankings" action="rank" params="[id: Version.T7.name()]">Tekken rankings</g:link></li>
        <li><g:link controller="rankings" action="rank" params="[id: Version.INJUSTICE2.name()]">Injustice rankings</g:link></li>
        <li><g:link controller="rankings" action="rank" params="[id: Version.GGXRD.name()]">GG rankings</g:link></li>
        <li><g:link controller="rankings" action="rank" params="[id: Version.UMVC3.name()]">Marvel rankings</g:link></li>
    </ul>

    <h2 class="slidebar-header">Social Media</h2>
    <div class="slidebar-social-icons">
        <a href="https://www.facebook.com/fgcworldranking/" class="social-icon-ar facebook"><i class="fa fa-facebook"></i></a>
        <a href="https://twitter.com/SRKRanking" class="social-icon-ar twitter"><i class="fa fa-twitter"></i></a>
    </div>
</div> <!-- sb-slidebar sb-right -->
<div id="back-top">
    <a href="#header"><i class="fa fa-chevron-up"></i></a>
</div>

<!-- Scripts -->
<!-- Compiled in vendors.js -->
<!--
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/jquery.cookie.js"></script>
<script src="assets/js/imagesloaded.pkgd.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/bootstrap-switch.min.js"></script>
<script src="assets/js/wow.min.js"></script>
<script src="assets/js/slidebars.min.js"></script>
<script src="assets/js/jquery.bxslider.min.js"></script>
<script src="assets/js/holder.js"></script>
<script src="assets/js/buttons.js"></script>
<script src="assets/js/jquery.mixitup.min.js"></script>
<script src="assets/js/circles.min.js"></script>
<script src="assets/js/masonry.pkgd.min.js"></script>
<script src="assets/js/jquery.matchHeight-min.js"></script>
-->


<script src="http://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>

<!--<script type="text/javascript" src="assets/js/jquery.themepunch.tools.min.js?rev=5.0"></script>
<script type="text/javascript" src="assets/js/jquery.themepunch.revolution.min.js?rev=5.0"></script>-->


<script src="${resource(dir: 'assets/js', file: 'styleswitcher.js')}"></script>

<!-- Syntaxhighlighter -->
<script src="${resource(dir: 'assets/js/syntaxhighlighter', file: 'shCore.js')}"></script>
<script src="${resource(dir: 'assets/js/syntaxhighlighter', file: 'shBrushXml.js')}"></script>
<script src="${resource(dir: 'assets/js/syntaxhighlighter', file: 'shBrushJScript.js')}"></script>

<script src="${resource(dir: 'assets/js', file: 'DropdownHover.js')}"></script>
<script src="${resource(dir: 'assets/js', file: 'app.js')}"></script>
<script src="${resource(dir: 'assets/js', file: 'holder.js')}"></script>




<script>
    $(function ()
    {
        function search(uid)
        {
            window.location = "${createLink(action: 'player', controller: 'rankings')}/byname/" + uid
        }

        $("#playerSearch").autocomplete({
            source: ["c++", "java", "php", "coldfusion", "javascript", "asp", "ruby"]
            //source: "${createLink(action: 'autocompletePlayer', controller: 'rankings')}",
            //minLength: 3,
/*            select: function (event, ui)
            {
                if (ui.item) search(ui.item.value);
            }*/
        });
    });
</script>
<script>
    $(function ()
    {
        function searchTournament(uid)
        {
            window.location = "${createLink(action: 'tournament', controller: 'rankings')}/byname/" + uid
        }

        function searchEvent(uid)
        {
            window.location = "${createLink(action: 'event', controller: 'rankings')}/byname/" + uid
        }

        $("#tournamentSearch").autocomplete({
            source: "${createLink(action: 'autocompleteTournament', controller: 'rankings')}",
            minLength: 2,
            select: function (event, ui)
            {
                if (ui.item && ui.item.type === "tournament") {
                    searchTournament(ui.item.value);
                }
                else if (ui.item && ui.item.type === "event") {
                    searchEvent(ui.item.value);
                }
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
<script src="${resource(dir: 'js', file: 'jquery.tablesorter.min.js')}"></script>
<script src="${resource(dir: 'js', file: 'jquery.tablecloth.js')}"></script>
<g:render template="/templates/prettify"/>


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

<div id="amzn-assoc-ad-2f4b7c46-0821-4d87-830b-ca653ac3c9fb"></div>
<script async src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US&adInstanceId=2f4b7c46-0821-4d87-830b-ca653ac3c9fb"></script>

</body>

</html>
