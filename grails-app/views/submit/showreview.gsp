<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial">
    <title>Tournament placed for review</title>
</head>

<body>

<h2>Thank you for submitting!</h2>
Following data will be reviewed and either comitted or rejected in ~24h. You can check status on the <g:link action="list">Submit list</g:link><br/>
Want to make sure we see this? Tweet it!
<div>
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
<g:if test="${flash.message}">
    <div class="alert alert-warning">${flash.message}</div>
</g:if>


<div class="table-responsive">
    <table class="table table-striped table-hover tdetails">
        <thead>
        <tr>
            <td>Key</td>
            <td>Value</td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Name</td>
            <td>${review.name}</td>
        </tr>
        <tr>
            <td>Country</td>
            <td>${review.countryCode}</td>
        </tr>
        <tr>
            <td>Date</td>
            <td>${review.date}</td>
        </tr>
        <tr>
            <td>Coverage</td>
            <td>${review.coverage}</td>
        </tr>
        <tr>
            <td>Game</td>
            <td>${review.game}</td>
        </tr>
        <tr>
            <td>Creator</td>
            <td>${review.creator}</td>
        </tr>
        <tr>
            <td>Reviewed</td>
            <td>${review.reviewed}</td>
        </tr>
        <tr>
            <td>Results</td>
            <td>${review.content}</td>
        </tr>
        </tbody>
    </table>
</div>

</body>

</html>