<!DOCTYPE html>
<html>
<head>
  <title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
  <meta name="layout" content="admin">
  <g:if env="development"><link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css"></g:if>
  <g:elseif test="${session.user != null}"><link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css"></g:elseif>
</head>

<body>
<g:if env="development">
  <g:renderException exception="${exception}"/>
</g:if>
<g:elseif test="${session.user != null}">
  <g:renderException exception="${exception}"/>
</g:elseif>
<g:else>
  <ul class="errors">
    <li>KO. You lose.</li>
    <li>You might want to talk to support</li>
  </ul>
</g:else>
</body>
</html>
