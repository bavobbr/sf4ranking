<%@ page import="be.bbr.sf4ranking.CharacterType; org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version; be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial">
    <title>${game?.value} Balance Statistics</title>
</head>

<body>

<h2>Character statistics</h2>


<ul class="nav nav-pills">
    <g:each in="${Version.values().findAll { it != Version.UNKNOWN }}" var="g">
        <li class="${game == g ? 'active' : 'passive'}"><g:link controller="stats" action="index"
                                                                params="[game: g.name()]">${g.name()}</g:link></li>
    </g:each>
</ul>
&nbsp;

<div class="table-responsive">
    <table class="tablehead table" id="datatable">
        <thead>
        <tr class="stathead">
            <th>Character</th>
            <th>Actual Score <a href="#" data-toggle="tooltip" data-placement="top"
                              title="Sum of time-adjusted scores earned by players who used this character in tournaments">(?)</a>
            </th>
            <th>Times listed <a href="#" data-toggle="tooltip" data-placement="top"
                                title="Number of times this character appeared in the tournament results">(?)</a></th>
            <th>Alltime Score <a href="#" data-toggle="tooltip" data-placement="top"
                         title="Sum of scores earned by all players who used this character in all tournaments">(?)</a>
            </th>
            <th>Trending Score <a href="#" data-toggle="tooltip" data-placement="top"
                         title="Trending score earned by players who used this character in recent tournaments">(?)</a>
            </th>
            <th>Trend <a href="#" data-toggle="tooltip" data-placement="top"
                                  title="Short time trend compared to actual placing based on 18 months of data">(?)</a>
            </th>
            <th>Main top 50 <a href="#" data-toggle="tooltip" data-placement="top"
                               title="Number of top 50 players who use this character as main">(?)</a></th>
            <th>Main top 100 <a href="#" data-toggle="tooltip" data-placement="top"
                                title="Number of top 100 players who use this character as main">(?)</a></th>
            <th>Main total <a href="#" data-toggle="tooltip" data-placement="top"
                              title="Number of players who use this character as main">(?)</a>
            </th>
            <th>Top 1<a href="#" data-toggle="tooltip" data-placement="top"
                        title="Number of times this character won a non-local tournaments">(?)</a>
            </th>
            <th>Top 3<a href="#" data-toggle="tooltip" data-placement="top"
                        title="Number of times this character laned in top3 of non-local tournaments">(?)</a>
            </th>
            <th>Best player <a href="#" data-toggle="tooltip" data-placement="top"
                               title="Highest ranked player who uses this char as main">(?)</a></th>
            <th>Best rank <a href="#" data-toggle="tooltip" data-placement="top"
                             title="Highest rank of this character as main">(?)</a></th>
        </tr>
        </thead>
        <g:each in="${results}" var="cstat">
            <tr>
              <td>
            <g:link action="character" controller="stats"
                    params="[charname: cstat.characterType.name(), game: game.name()]"
                    data-toggle="tooltip" data-placement="top"
                    title="Details on ${cstat.characterType.value}">
                <g:img dir="images/chars/${Version.generalize(game).name().toLowerCase()}"
                       file="${cstat.characterType.name().toLowerCase() + '.png'}" width="22" height="25"
                       alt="${cstat.characterType.value}"
                       class="charimg"/>
                ${cstat.characterType.value}
            </g:link>
            </td>
            <td>${cstat.decayedScoreAccumulated}</td>
            <td>${cstat.totalTimesUsed}</td>
            <td>${cstat.scoreAccumulated}</td>
            <td>${cstat.trendingScoreAccumulated}</td>
            <td class="${cstat?.diffTrendRank() == 0 ? '' : cstat?.diffTrendRank() > 0 ? 'success' : 'danger'}">
                <g:if test="${cstat.diffTrendRank() > 0}">
                    <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
                </g:if>
                <g:elseif test="${cstat?.diffTrendRank() < 0}">
                    <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
                </g:elseif>
                <g:if test="${cstat?.diffTrendRank() != 0 && cstat?.diffTrendRank() != null}">
                    ${Math.abs(cstat?.diffTrendRank())}
                </g:if>
            </td>
            <td>${cstat.asMainInTop50}</td>
            <td>${cstat.asMainInTop100}</td>
            <td>${cstat.asMain}</td>
            <td>
                <g:link action="character" params="[charname: cstat.characterType, game: cstat.game]">
                    ${cstat.top1finishes}
                </g:link>
            </td>
            <td>
            <g:link action="character" params="[charname: cstat.characterType, game: cstat.game]">
                ${cstat.top3finishes}
            </g:link>
            </td>
            <td>
            <g:if test="${cstat.player}">
                <g:link controller="rankings" mapping="playerByName" action="player"
                        params="[name: cstat.player.name]">${cstat.player.name}</g:link>
            </g:if>
        </td>
            <td>${cstat.player?.rank(game)}</td>

        </g:each>

    </table>
</div>

<h3>
    Game Character Balance
</h3>

<div class="table-responsive">
    <table class="table table-striped table-hover table-condensed">
        <thead>
        <tr>
            <td>Statistic</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${game.name()}</td>
            </g:each>
        </tr>
        </thead>
        <tr>
            <td>Game character Total</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${CharacterType.count(game)}</td>
            </g:each>
        </tr>
        <tr>
            <td>Players registered</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].players()}</td>
            </g:each>
        </tr>
        <tr>
            <td>Characters registered</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].sampleSize}</td>
            </g:each>
        </tr>
        <tr>
            <td>Statistic data series length</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].usageSeries.split(",").size()}</td>
            </g:each>
        </tr>
        <tr>
            <td>Percentage of chars in Top 50</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].percentageInTop50}</td>
            </g:each>
        </tr>
        <tr>
            <td>Percentage of chars in Top 100</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].percentageInTop100}</td>
            </g:each>
        </tr>
        <tr>
            <td>Lowest rank of character in 25th percentile</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].rankOfCharAt25Percent}</td>
            </g:each>
        </tr>
        <tr>
            <td>Lowest rank of character in 50th percentile</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].rankOfCharAt50Percent}</td>
            </g:each>
        </tr>
        <tr>
            <td>Lowest rank of character in 75th percentile</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].rankOfCharAt75Percent}</td>
            </g:each>
        </tr>
        <tr>
            <td>Lowest rank of all characters</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].rankOfCharAt100Percent}</td>
            </g:each>
        </tr>
        <tr>
            <td>Mean value on player scores</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].meanOnScore.round(1)}</td>
            </g:each>
        </tr>
        <tr>
            <td>Standard deviation in player scores</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].standardDeviationOnScore.round(1)}</td>
            </g:each>
        </tr>
        <tr>
            <td>Mean value on character main usage</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].meanOnMain.round(1)} / ${gamestats[game].mainTotal()}</td>
            </g:each>
        </tr>
        <tr>
            <td>Standard deviation on character main usage</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].standardDeviationOnMain.round(1)} / ${gamestats[game].mainTotal()}</td>
            </g:each>
        </tr>
        <tr>
            <td>Mean value on character total usage</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].meanOnUsage.round(1)} / ${gamestats[game].usageTotal()}</td>
            </g:each>
        </tr>
        <tr>
            <td>Standard deviation on character total usage</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].standardDeviationOnUsage.round(1)} / ${gamestats[game].usageTotal()}</td>
            </g:each>
        </tr>
        <tr>
            <td>Mean value on character frequency</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].meanOnUsagePercent.round(1)}</td>
            </g:each>
        </tr>
        <tr>
            <td>Standard deviation on character frequency</td>
            <g:each in="${gamestats.keySet()}" var="game">
                <td>${gamestats[game].standardDeviationOnUsagePercent.round(1)}</td>
            </g:each>
        </tr>
    </table>
</div>


<g:if test="${SecurityUtils.subject.isPermitted("admin")}">

    Do a new analyse on
    <ol>
        <g:each in="${Version.values()}" var="game">
            <li><g:link controller="stats" action="analyze" params="[game: game.name()]">${game.name()}</g:link></li>
        </g:each>

    </ol>
</g:if>
<script type="text/javascript" charset="utf-8">
    $(document).ready(function () {
        $('table[id^="datatable"]').each(function (index) {
            $(this).tablecloth({
                theme: "default",
                striped: true,
                sortable: true,
                condensed: true
            });
            //$(this).tablesorter({sortList: [[1,1]]})
        })
    });

    var Anterec;
    (function (Anterec) {
        var JsDragTable = (function () {
            function JsDragTable(target) {
                this.offsetX = 5;
                this.offsetY = 5;
                this.container = target;
                this.rebind();
            }
            JsDragTable.prototype.rebind = function () {
                var _this = this;
                $(this.container).find("th").each(function (headerIndex, header) {
                    $(header).off("mousedown touchstart");
                    $(header).off("mouseup touchend");
                    $(header).on("mousedown touchstart", function (event) {
                        _this.selectColumn($(header), event);
                    });
                    $(header).on("mouseup touchend", function (event) {
                        _this.dropColumn($(header), event);
                    });
                });
                $(this.container).on("mouseup touchend", function () {
                    _this.cancelColumn();
                });
            };

            JsDragTable.prototype.selectColumn = function (header, event) {
                var _this = this;
                event.preventDefault();
                var userEvent = new UserEvent(event);
                this.selectedHeader = header;
                var sourceIndex = this.selectedHeader.index() + 1;
                var cells = [];

                $(this.container).find("tr td:nth-child(" + sourceIndex + ")").each(function (cellIndex, cell) {
                    cells[cells.length] = cell;
                });

                this.draggableContainer = $("<div/>");
                this.draggableContainer.addClass("jsdragtable-contents");
                this.draggableContainer.css({ position: "absolute", left: userEvent.event.pageX + this.offsetX, top: userEvent.event.pageY + this.offsetY });

                var dragtable = this.createDraggableTable(header);

                $(cells).each(function (cellIndex, cell) {
                    var tr = $("<tr/>");
                    var td = $("<td/>");
                    $(td).html($(cells[cellIndex]).html());
                    $(tr).append(td);
                    $(dragtable).find("tbody").append(tr);
                });

                this.draggableContainer.append(dragtable);
                $("body").append(this.draggableContainer);
                $(this.container).on("mousemove touchmove", function (event) {
                    _this.moveColumn($(header), event);
                });
                $(".jsdragtable-contents").on("mouseup touchend", function () {
                    _this.cancelColumn();
                });
            };

            JsDragTable.prototype.moveColumn = function (header, event) {
                event.preventDefault();
                if (this.selectedHeader !== null) {
                    var userEvent = new UserEvent(event);
                    this.draggableContainer.css({ left: userEvent.event.pageX + this.offsetX, top: userEvent.event.pageY + this.offsetY });
                }
            };

            JsDragTable.prototype.dropColumn = function (header, event) {
                var _this = this;
                event.preventDefault();
                var sourceIndex = this.selectedHeader.index() + 1;
                var targetIndex = $(event.target).index() + 1;
                var tableColumns = $(this.container).find("th").length;

                var userEvent = new UserEvent(event);
                if (userEvent.isTouchEvent) {
                    header = $(document.elementFromPoint(userEvent.event.clientX, userEvent.event.clientY));
                    targetIndex = $(header).prevAll().length + 1;
                }

                if (sourceIndex !== targetIndex) {
                    var cells = [];
                    $(this.container).find("tr td:nth-child(" + sourceIndex + ")").each(function (cellIndex, cell) {
                        cells[cells.length] = cell;
                        $(cell).remove();
                        $(_this.selectedHeader).remove();
                    });

                    if (targetIndex >= tableColumns) {
                        targetIndex = tableColumns - 1;
                        this.insertCells(cells, targetIndex, function (cell, element) {
                            $(cell).after(element);
                        });
                    } else {
                        this.insertCells(cells, targetIndex, function (cell, element) {
                            $(cell).before(element);
                        });
                    }

                    $(this.container).off("mousemove touchmove");
                    $(".jsdragtable-contents").remove();
                    this.draggableContainer = null;
                    this.selectedHeader = null;
                    this.rebind();
                }
            };

            JsDragTable.prototype.cancelColumn = function () {
                $(this.container).off("mousemove touchmove");
                $(".jsdragtable-contents").remove();
                this.draggableContainer = null;
                this.selectedHeader = null;
            };

            JsDragTable.prototype.createDraggableTable = function (header) {
                var table = $("<table/>");
                var thead = $("<thead/>");
                var tbody = $("<tbody/>");
                var tr = $("<tr/>");
                var th = $("<th/>");
                $(table).addClass($(this.container).attr("class"));
                $(table).width($(header).width());
                $(th).html($(header).html());
                $(tr).append(th);
                $(thead).append(tr);
                $(table).append(thead);
                $(table).append(tbody);
                return table;
            };

            JsDragTable.prototype.insertCells = function (cells, columnIndex, callback) {
                var _this = this;
                $(this.container).find("tr td:nth-child(" + columnIndex + ")").each(function (cellIndex, cell) {
                    callback(cell, $(cells[cellIndex]));
                });
                $(this.container).find("th:nth-child(" + columnIndex + ")").each(function (cellIndex, cell) {
                    callback(cell, $(_this.selectedHeader));
                });
            };
            return JsDragTable;
        })();
        Anterec.JsDragTable = JsDragTable;

        var UserEvent = (function () {
            function UserEvent(event) {
                this.event = event;
                if (event.originalEvent && event.originalEvent.touches && event.originalEvent.changedTouches) {
                    this.event = event.originalEvent.touches[0] || event.originalEvent.changedTouches[0];
                    this.isTouchEvent = true;
                }
            }
            return UserEvent;
        })();
    })(Anterec || (Anterec = {}));
    jQuery.fn.extend({
        jsdragtable: function () {
            return new Anterec.JsDragTable(this);
        }
    });

</script>
<script>
    $(document).ready(function() {
        $("table").jsdragtable();
    });
</script>
</body>
</html>