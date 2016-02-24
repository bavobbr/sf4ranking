<%--
  Created by IntelliJ IDEA.
  User: bbr
  Date: 1/16/14
  Time: 1:51 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
  <meta name="layout" content="overviews">
  <title>Tournament Data Submit</title>
</head>

<body>
<script>
  $(function ()
    {
      $("#dialog").dialog({
                            autoOpen: false,
                            modal: true,
                            height: 600,
                            width: 800
                          });
        $("#info").dialog({
            autoOpen: false,
            modal: true,
            height: 600,
            width: 800
        });
      $("#validatePlayers").click(function ()
                         {
                           $.ajax({

                                    url: "${createLink(action: 'validateResults', controller: 'submit')}",
                                    type: "POST",
                                    data: {content: $('textarea#tresults').val(), game: $('#tgame').val(), type: 'players'},
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

                                    url: "${createLink(action: 'validateResults', controller: 'submit')}",
                                    type: "POST",
                                    data: {content: $('textarea#tresults').val(), game: $('#tgame').val(), type: 'chars'},
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

                                           url: "${createLink(action: 'renderCharacterNames', controller: 'submit')}",
                                           type: "POST",
                                           data: {game: $('#tgame').val()},
                                           success: function (data)
                                           {
                                             $("#info").html(data);
                                             $("#info").dialog("open");
                                           }
                                         });
                                });
        $("#example").click(function ()
        {
            $.ajax({

                url: "${createLink(action: 'example', controller: 'submit')}",
                type: "POST",
                data: {game: $('#tgame').val()},
                success: function (data)
                {
                    $("#info").html(data);
                    $("#info").dialog("open");
                }
            });
        });

    });
</script>

<h2>Submit new tournament results for review</h2>
The better you format your data, the larger the chance the results will be included. Please take your time
to use the 'validate' buttons before submitting, and to use the 'Help' buttons to see what data is expected. The system will save your data regardless of correct input, but it makes review and editing harder.
<br/>
<g:if test="${flash.message}">
  <div class="alert alert-warning">${flash.message}</div>
</g:if>
<g:form action="review" controller="submit" name="importform" role="form">
  <div class="form-group">
    <label for="tname">(*) Tournament Name (needs to be unique, system will add game name)</label>
    <g:textField name="tname" class="form-control" placeholder="tournament name and year"/>
  </div>

  <div class="form-group">
    <label for="tdate">(*) Tournament Date (when it occurred)</label>
    <g:datePicker name="tdate" class="form-control" precision="day" years="${2000..2020}" value="${suggestedDate?: new Date()}"/>
  </div>

  <div class="form-group">
    <label for="tgame">(*) Tournament Game (characters will be validated against this)</label>
    <g:select name="tgame" from="${be.bbr.sf4ranking.Version.values()}" class="form-control"/>
  </div>

  <div class="form-group">
    <label for="tformat">(*) Tournament Format (different formats have different score systems)</label>
    <g:select name="tformat" from="${be.bbr.sf4ranking.TournamentFormat.values()}" class="form-control" value="${be.bbr.sf4ranking.TournamentFormat.DOUBLE_BRACKET}"/>
  </div>

  <div class="form-group">
    <label for="tcountry">Country (ISO code)</label>
    <g:select name="tcountry" from="${be.bbr.sf4ranking.CountryCode.values()}" class="form-control" value="${suggestedCountry?: be.bbr.sf4ranking.CountryCode.US}"/>
  </div>

  <div class="form-group">
    <label for="tcoverage">Link to source (full link)</label>
    <g:textField name="tcoverage" class="form-control" placeholder="http://site"/>
  </div>

  <div class="form-group">
    <label for="tresults">(*) Results (1 to 64 max, use help buttons below for formatting tips and data validation)</label>
    <g:textArea name="tresults" class="form-control" rows="20" placeholder="first player (RYU,SAGAT)"
                title="${hint}"/><br/>
      <button type="button" id="validatePlayers" class="btn btn-success">Validate Players</button>
      <button type="button" id="validateChars" class="btn btn-success">Validate Chars</button>
      <button type="button" id="renderCharacterNames" class="btn btn-info">Show all char names</button>
      <button type="button" id="example" class="btn btn-info">Show formatting example</button>

  </div>
    <div class="form-group">
        <label for="answer">(*) Who is Ryu's best friend, hidden in Hadoken?</label>
        <g:textField name="answer" class="form-control" placeholder="" value=""/><br/>
    </div>
    <div class="form-group">
        <label for="tcreator">(*) Your name (you will be credited as such) </label>
        <g:textField name="tcreator" class="form-control" placeholder="" value=""/><br/>
        <button type="submit" class="btn btn-primary">Create</button>
    </div>
</g:form>
<br/>

<div id="dialog" title="Validation feedback">
  <p></p>
</div>
<div id="info" title="Help guide">
    <p></p>
</div>

</body>

</html>