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
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'paginate.css')}" type="text/css">
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

<nav class="navbar navbar-default" role="navigation">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <g:link action="index" controller="rankings" class="navbar-brand">SF4 World Ranking</g:link>
    </div>




    <!-- Collect the nav links, forms, and other content for toggling -->

    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        <li><g:link action="index" controller="rankings">Ranking</g:link></li>
        <li><g:link action="tournaments" controller="rankings">Tournaments</g:link></li>
        <li><g:link action="index" controller="about">How it works</g:link></li>

        <form class="navbar-form navbar-left" role="search">
          <div class="form-group">
            <input id="playerSearch" class="form-control" placeholder="player">
          </div>
        </form>

        <form class="navbar-form navbar-left" role="search">
          <div class="form-group">
            <input id="tournamentSearch" class="form-control" placeholder="tournament">
          </div>
        </form>

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
    </div><!-- /.navbar-collapse -->

  </div>
</nav>


<div class="container">
  <div class="row">

    <div class="col-md-10">
      <g:img dir="images" file="sf4_stage2.jpg" class="img-responsive"/>
      <div class="starter-template">
        <g:layoutBody/>
        <div class="panel panel-info">
          <div class="panel-heading">
            <h3 class="panel-title">Share</h3>
          </div>

          <div class="panel-body">
            <div class="row">
              <div class="col-md-4">

                <a href="https://twitter.com/share" class="twitter-share-button" data-via="bavobbr">Tweet</a>
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
                <a href="https://twitter.com/bavobbr" class="twitter-follow-button" data-show-count="false">Follow @bavobbr</a>
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
                <div class="fb-share-button" data-href="http://sf4ranking.bavobbr.eu.cloudbees.net/" data-type="button_count"></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="footer">
        <p>Street Fighter 4 World Tournament Ranking &copy; Bavo Bruylandt 2013</p>
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