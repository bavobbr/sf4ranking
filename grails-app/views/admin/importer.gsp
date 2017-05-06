<%--
  Created by IntelliJ IDEA.
  User: bbr
  Date: 1/16/14
  Time: 1:51 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews">
    <title>Admin panel</title>
</head>

<body>
<script>
    $(function () {
        $("#dialog").dialog({
            autoOpen: false,
            modal: true,
            height: 600,
            width: 800
        });
        $("#validatePlayers").click(function () {
            $.ajax({

                url: "${createLink(action: 'validateResults', controller: 'admin')}",
                type: "POST",
                data: {content: $('textarea#tresults').val(), game: $('#tgame').val(), type: 'players'},
                success: function (data) {
                    $("#dialog").html(data);
                    $("#dialog").dialog("open");
                }
            });
        });
        $("#validateChars").click(function () {
            $.ajax({

                url: "${createLink(action: 'validateResults', controller: 'admin')}",
                type: "POST",
                data: {content: $('textarea#tresults').val(), game: $('#tgame').val(), type: 'chars'},
                success: function (data) {
                    $("#dialog").html(data);
                    $("#dialog").dialog("open");
                }
            });
        });
        $("#renderCharacterNames").click(function () {
            $.ajax({

                url: "${createLink(action: 'renderCharacterNames', controller: 'admin')}",
                type: "POST",
                data: {game: $('#tgame').val()},
                success: function (data) {
                    $("#dialog").html(data);
                    $("#dialog").dialog("open");
                }
            });
        });

    });
</script>

<h2>Admin import new tournament</h2>
<g:if test="${flash.message}">
    <div class="alert alert-warning">${flash.message}</div>
</g:if>
<g:form action="importTournament" controller="admin" name="importform" role="form">
    <div class="form-group">
        <label for="tname">Name (required, system auto-appends the game)</label>
        <g:textField name="tname" class="form-control" placeholder="tournament name and year" value="${suggestedName}"/>
    </div>

    <div class="form-group">
        <label for="tdate">Date (required)</label>
        <g:datePicker name="tdate" class="form-control" precision="day" years="${2000..2020}"
                      value="${suggestedDate ?: new Date()}"/>
    </div>

    <div class="form-group">
        <label for="tgame">Game (required)</label>
        <g:select name="tgame" from="${be.bbr.sf4ranking.Version.values()}" class="form-control"
                  value="${suggestedGame}"/>
    </div>

    <div class="form-group">
        <label for="tformat">Format (different formats have different score systems)</label>
        <g:select name="tformat" from="${be.bbr.sf4ranking.TournamentFormat.values()}" class="form-control"
                  value="${suggestedFormat}"/>
    </div>

    <div class="form-group">
        <label for="tweight">Weighting type (use AUTO to let the app decide the type, unless GRAND SLAM or LOCAL type)</label>
        <g:select name="tweight" from="${be.bbr.sf4ranking.WeightingType.values()}" class="form-control"
                  value="${be.bbr.sf4ranking.WeightingType.AUTO}"/>
    </div>

    <div class="form-group">
        <label for="ttype">Tournament Type (only needed if weighting is FIXED)</label>
        <g:select name="ttype" from="${be.bbr.sf4ranking.TournamentType.values()}" class="form-control"/>
    </div>

    <div class="form-group">
        <label for="cpttype">CPT Type (only needed for SF5 CPT)</label>
        <g:select name="cpttype" from="${be.bbr.sf4ranking.CptTournament.values()}" class="form-control"/>
    </div>

    <div class="form-group">
        <label for="tcountry">Country (ISO code, optional)</label>
        <g:select name="tcountry" from="${be.bbr.sf4ranking.CountryCode.values()}" class="form-control"
                  value="${suggestedCountry ?: be.bbr.sf4ranking.CountryCode.US}"/>
    </div>
    <div class="form-group">
        <label for="tregion">Region (optional, mandatory for CPT regional events to decide on region board)</label>
        <g:select name="tregion" from="${be.bbr.sf4ranking.Region.values()}" class="form-control"
                  value="${suggestedRegion ?: be.bbr.sf4ranking.Region.NA}"/>
    </div>

%{--    <div class="form-group">
        <label for="tvideos">Videos (seperated with a space)</label>
        <g:textField name="tvideos" class="form-control" placeholder="qJGSz-aQDO0 Go1vdkf-xvY"/>
    </div>--}%

    <div class="form-group">
        <label for="tcoverage">Link to source data (full link, preferably SRK page)</label>
        <g:textField name="tcoverage" class="form-control" placeholder="" value="${suggestedSource}"/>
    </div>

    <div class="form-group">
        <label for="tresults">Results (1 up 64 max, mouse over for tips. Use the validate buttons before submit to verify)<br/>
        Ranking numbers and team names are stripped automatically if in format 'rank. team | playername'<br/>
        Characters are defined by follwing player name with '(character)'
        </label>
        <g:textArea name="tresults" class="form-control" rows="20" placeholder="first player (RYU,SAGAT)"
                    title="${hint}" value="${suggestedContent}"/>
        <button type="button" id="validatePlayers" class="btn btn-secondary">Validate Players</button>
        <button type="button" id="validateChars" class="btn btn-secondary">Validate Chars</button>
        <button type="button" id="renderCharacterNames" class="btn btn-secondary">Show char guide</button>
        <button type="submit" class="btn btn-primary">Create</button>
        <g:hiddenField name="creator" value=" ${suggestedCreator}"/>
    </div>
</g:form>
<br/>

<div id="dialog" title="Validation feedback">
    <p></p>
</div>

</body>

</html>