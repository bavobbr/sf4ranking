<%@ page import="be.bbr.sf4ranking.TournamentFormat; be.bbr.sf4ranking.TournamentType; be.bbr.sf4ranking.ScoringSystem" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="overviews"/>
    <title>SRK Ranking - Hardware and controllers</title>
</head>

<body>
<h2>Game Controllers</h2>

This is a list if the most commonly used arcade sticks, controllers and converters by top players. You can get more detailed info and prices of the device. Pricing is dynamically set by Amazon across regions United States, United Kingdom, Grmany and France.


<div class="row" align="center">
    <div class="col-md-4">
        <img src="https://s3.amazonaws.com/srkranking/controllers/madcatz_family_small.jpeg" class="img-responsive"
             alt="Mad catz controller prices" data-toggle="tooltip" data-placement="top"
             title="Mad catz arcade stick and controller prices"/>
    </div>

    <div class="col-md-4">
        <img src="https://s3.amazonaws.com/srkranking/controllers/hori_rap5_small.jpeg" class="img-responsive"
             alt="Hori controller prices" data-toggle="tooltip" data-placement="top"
             title="Hori arcade stick controller prices"/>
    </div>

    <div class="col-md-4">
        <img src="https://s3.amazonaws.com/srkranking/controllers/mc_te2plus_small.jpeg" class="img-responsive"
             alt="Mad catz controller prices" data-toggle="tooltip" data-placement="top"
             title="Mad catz arcade stick and controller prices"/>
    </div>
</div>

<div class="table-responsive">
    <table class="tablehead" id="datatable">
        <thead>
        <tr class="stathead">
            <th>Name</th>
            <th>Details</th>
            <th>Vendor</th>
            <th>Known Players</th>
        </tr>
        </thead>
        <g:each in="${controllers}" var="controller">
            <tr>
                <td>
                    <g:link action="show" params="[id: controller.id]">
                        ${controller.shortname}
                    </g:link>
                </td>
                <td>
                    ${controller.name}
                </td>
                <td>
                    ${controller.website}
                </td>
                <td>
                    ${controller.players.size()}
                </td>
            </tr>
        </g:each>
        <g:render template="/templates/prettify"/>
    </table>
</div>

<div class="row" align="center">
    <div class="col-md-12" align="center">
        <script type="text/javascript">
            amzn_assoc_placement = "adunit0";
            amzn_assoc_search_bar = "true";
            amzn_assoc_tracking_id = "topstuff0e-20";
            amzn_assoc_search_bar_position = "bottom";
            amzn_assoc_ad_mode = "search";
            amzn_assoc_ad_type = "smart";
            amzn_assoc_marketplace = "amazon";
            amzn_assoc_region = "US";
            amzn_assoc_title = "Arcade Controller";
            amzn_assoc_default_search_phrase = "arcade controller";
            amzn_assoc_default_category = "All";
            amzn_assoc_linkid = "88b3499db3b10427f617b23a220cb13b";
        </script>
        <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US"></script>

           </div>
</div>

</body>
</html>