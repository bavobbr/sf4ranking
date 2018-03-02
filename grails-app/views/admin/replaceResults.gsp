<%--
  Created by IntelliJ IDEA.
  User: bbr
  Date: 1/16/14
  Time: 1:51 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial">
  <title>Admin panel</title>
</head>

<body>
<script>
    function replace(original, newvalue, pid)
    {
        console.log("Replacing ${orginal} with ${newvalue}");
        var str = document.getElementById("results").value;
        var n = str.replace(original, newvalue);
        document.getElementById("results").value = n;
        document.getElementById(pid).style.display = 'none';
    }
</script>
<script>
  $(function ()
    {
      $("#dialog").dialog({
                            autoOpen: false,
                            modal: true,
          height: 800,
          width: 1000
                          });
      $("#validatePlayers").click(function ()
                                  {
                                    $.ajax({

                                             url: "${createLink(action: 'validateResults', controller: 'admin')}",
                                             type: "POST",
                                             data: {content: $('textarea#results').val(), game: $('#game').val(), type: 'players'},
                                             success: function (data)
                                             {
                                               $("#dialog").html(data);
                                               $("#dialog").dialog("open");
                                             }
                                           });
                                  });
      $("#validateChars").click(function ()
                                {
                                  $.ajax({

                                           url: "${createLink(action: 'validateResults', controller: 'admin')}",
                                           type: "POST",
                                           data: {content: $('textarea#results').val(), game: $('#game').val(), type: 'chars'},
                                           success: function (data)
                                           {
                                             $("#dialog").html(data);
                                             $("#dialog").dialog("open");
                                           }
                                         });
                                });
      $("#renderCharacterNames").click(function ()
                                       {
                                         $.ajax({

                                                  url: "${createLink(action: 'renderCharacterNames', controller: 'admin')}",
                                                  type: "POST",
                                                  data: {game: $('#game').val()},
                                                  success: function (data)
                                                  {
                                                    $("#dialog").html(data);
                                                    $("#dialog").dialog("open");
                                                  }
                                                });
                                       });

    });
</script>
<h2>Admin replace results for ${tournament.name}</h2>








<g:if test="${flash.message}">
  <div class="alert alert-warning">${flash.message}</div>
</g:if>
<g:form action="updateTournamentResults" controller="admin" name="importform" role="form">
    <g:hiddenField name="game" class="form-control" value="${tournament.game}"/>
  <div class="form-group">
    <label for="results">Results (1 up to 64 max, mouse over for tips. Make sure the character name matches a known character type)</label>
    <g:textArea id="results" name="results" class="form-control" rows="20" placeholder="first player (RYU,SAGAT)"
                value="${results}"/>
    <button type="button" id="validatePlayers" class="btn btn-secondary">Validate Players</button>
    <button type="button" id="validateChars" class="btn btn-secondary">Validate Chars</button>
    <button type="button" id="renderCharacterNames" class="btn btn-secondary">Show char guide</button>
    <button type="submit" class="btn btn-primary">Create</button>
  </div>
  <g:hiddenField name="id" value="${tournament.id}"/>
</g:form>
<br/>

<div id="dialog" title="Validation feedback">
  <p></p>
</div>
</body>
</html>