<!DOCTYPE html>
<html lang="en">
<head>
  %{--<meta name="viewport" content="width=device-width, initial-scale=1.0">--}%
  <title><g:layoutTitle/></title>
  <r:layoutResources/>
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'responsive-video.css')}" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'style_worldrank.css')}" type="text/css">
  <link href='http://fonts.googleapis.com/css?family=Lato:400,700,900' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Oswald:700' rel='stylesheet' type='text/css'>
  <style>
  .ui-autocomplete-loading {
    background: white url('images/ui-anim_basic_16x16.gif') right center no-repeat;
  }
  </style>
  <script>
    $(function ()
      {
        function search(uid)
        {
          window.location = "${createLink(action: 'player', controller: 'rankings')}/" + uid
        }

        $("#playerSearch").autocomplete({
                                          source: "${createLink(action: 'autocompletePlayer', controller: 'rankings')}",
                                          minLength: 2,
                                          select: function (event, ui)
                                          {
                                            if (ui.item) search(ui.item.id);
                                          }
                                        });
      });
  </script>
  <script>
    $(function ()
      {
        function searchTournament(uid)
        {
          window.location = "${createLink(action: 'tournament', controller: 'rankings')}/" + uid
        }

        $("#tournamentSearch").autocomplete({
                                              source: "${createLink(action: 'autocompleteTournament', controller: 'rankings')}",
                                              minLength: 2,
                                              select: function (event, ui)
                                              {
                                                if (ui.item) searchTournament(ui.item.id);
                                              }
                                            });
      });
  </script>
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
      <a class="navbar-brand" href="/sf4ranking/">Shoryuken Rankings</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <form class="navbar-form navbar-right top-search" role="search">
        <div class="form-group">
          <input id="playerSearch" class="form-control" placeholder="Find a Player">
        </div>
		<div class="form-group">
          <input id="tournamentSearch" class="form-control" placeholder="Search Tournaments">
        </div>
      </form>
      <ul class="nav navbar-nav navbar-right">
	      <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">RANKINGS <b class="caret"></b></a>
          <ul class="dropdown-menu">
			<li><g:link action="index" controller="rankings">World Rankings</g:link></li>
        	<li><g:link action="tournaments" controller="rankings">View Tournaments</g:link></li>
            <li class="divider"></li>
            <li><a href="#">FAQ</a></li>
          </ul>
        </li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">PARTICIPATE <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">Rankings Discussion</a></li>
            <li class="divider"></li>
			<li><a href="#">Contact Us</a></li>
            <li><a href="#">Shoryuken.com</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

  <div class="row">

    <div class="col-md-12">
      
      <div class="starter-template">
        <g:layoutBody/>
        

      <div class="footer">
        <p class="large">Street Fighter World Rankings &copy; 2014 Bavo Bruylandt</p>
		<p>Developed by <a href="https://twitter.com/bavobbr">Bavo Bruylandt</a> &middot; Hosted by <a href="http://www.shoryuken.com">Shoryuken</a>  &middot; Bootstrap mods by <a <a href="http://www.kineda.com">Kineda</a> &middot For more info, visit <a href="#">official thread</a>.</p>
	  <ul class="nav navbar-nav">
		 <g:if test="${session.user != null}">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Admin <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><g:link action="index" controller="admin">[Actions]</g:link></li>
              <li><g:link action="index" controller="tournament">[Tournaments]</g:link></li>
              <li><g:link action="index" controller="player">[Players]</g:link></li>
              <li><g:link action="index" controller="result">[Results]</g:link></li>
              <li><g:link action="index" controller="user">[User]</g:link></li>
            </ul>
          </li>
        </g:if>
      </ul>
      </div>
    </div>
  </div>

</div>

<r:layoutResources/>

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

  ga('create', 'UA-47390615-1', 'cloudbees.net');
  ga('send', 'pageview');

</script>
</body>
</html>