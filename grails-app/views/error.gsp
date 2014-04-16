<%@ page import="org.apache.shiro.SecurityUtils" %>
<!DOCTYPE html>
<html>
<head>
  <title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
  <meta name="layout" content="overviews">
  <r:require modules="bootstrap"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
</head>

<body>
<g:if env="development">
  <g:renderException exception="${exception}"/>
</g:if>
<g:elseif test="${SecurityUtils.subject.hasRoles(["Administrator","Moderator"])}">
  <g:renderException exception="${exception}"/>
</g:elseif>
<g:else>
  <ul class="errors">
    <li>KO. You lose!</li>
    <li>You might want to talk to support @bavobbr</li>
  </ul>
</g:else>
</body>
</html>
