<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@tag description="Simple Wrapper Tag" pageEncoding="UTF-8"%>
<%@attribute name="title" required="true" %>
<%@attribute name="body" fragment="true" %>
<%@attribute name="scripts" fragment="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>${title}</title>
    <spring:url value="/resources/css/bootstrap.css" var="bootstrap"/>
    <spring:url value="/resources/css/white.css" var="white"/>
    <spring:url value="/resources/css/modern-business.css" var="startertemplate"/>
    <spring:url value="/resources/css/lightbox.css" var="lightbox"/>
    <link href="${bootstrap}" rel="stylesheet" />
    <link href="${startertemplate}" rel="stylesheet" />
    <link href="${white}" rel="stylesheet" />
    <link href="${lightbox}" rel="stylesheet">

</head>

<body id="body" style='overflow-x: hidden;'>

<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">Photohost</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="/photo">Upload</a>
                </li>
                <li>
                    <a href="/edit">Edit</a>
                </li>
                <li>
                    <a href="/album">Create Album</a>
                </li>
                <li>
                    <a href="/login?logout">Logout</a>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>

<!--!!!!!!!!!! body -->
<jsp:invoke fragment="body" />


<footer style="vertical-align: bottom; text-align: center">
    Copyright © Park 2016
</footer>

<!-- /.container -->

<jsp:invoke fragment="scripts" />

</body>
</html>
