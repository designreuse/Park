<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
  <title>Main</title>
  <spring:url value="resources/css/bootstrap.css" var="bootstrap"/>
  <spring:url value="/resources/css/modern-business.css" var="startertemplate"/>
  <link href="${bootstrap}" rel="stylesheet" />
  <link href="${startertemplate}" rel="stylesheet" />
</head>

<body>

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
          <a href="/login">Sign in</a>
        </li>
      </ul>
    </div>
    <!-- /.navbar-collapse -->
  </div>
  <!-- /.container -->
</nav>

<!-- Header Carousel -->
<header id="myCarousel" class="carousel slide">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner">
    <div class="item active">
      <div class="fill" style="background-image:url('http://placehold.it/1900x1080&text=Slide One');"></div>
      <div class="carousel-caption">
        <h2>Caption 1</h2>
      </div>
    </div>
    <div class="item">
      <div class="fill" style="background-image:url('http://placehold.it/1900x1080&text=Slide Two');"></div>
      <div class="carousel-caption">
        <h2>Caption 2</h2>
      </div>
    </div>
    <div class="item">
      <div class="fill" style="background-image:url('http://placehold.it/1900x1080&text=Slide Three');"></div>
      <div class="carousel-caption">
        <h2>Caption 3</h2>
      </div>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
    <span class="icon-prev"></span>
  </a>
  <a class="right carousel-control" href="#myCarousel" data-slide="next">
    <span class="icon-next"></span>
  </a>
</header>

<!-- Page Content -->
<div class="container">

  <!-- Marketing Icons Section -->
  <div class="row">
    <div class="col-lg-12">
      <h1 class="page-header">
        Welcome to Modern Business
      </h1>
    </div>
    <div class="col-md-4">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4><i class="fa fa-fw fa-check"></i> Bootstrap v3.2.0</h4>
        </div>
        <div class="panel-body">
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque, optio corporis quae nulla aspernatur in alias at numquam rerum ea excepturi expedita tenetur assumenda voluptatibus eveniet incidunt dicta nostrum quod?</p>
          <a href="#" class="btn btn-default">Learn More</a>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4><i class="fa fa-fw fa-gift"></i> Free &amp; Open Source</h4>
        </div>
        <div class="panel-body">
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque, optio corporis quae nulla aspernatur in alias at numquam rerum ea excepturi expedita tenetur assumenda voluptatibus eveniet incidunt dicta nostrum quod?</p>
          <a href="#" class="btn btn-default">Learn More</a>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4><i class="fa fa-fw fa-compass"></i> Easy to Use</h4>
        </div>
        <div class="panel-body">
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque, optio corporis quae nulla aspernatur in alias at numquam rerum ea excepturi expedita tenetur assumenda voluptatibus eveniet incidunt dicta nostrum quod?</p>
          <a href="#" class="btn btn-default">Learn More</a>
        </div>
      </div>
    </div>
  </div>
  <!-- /.row -->

  <hr>

  <!-- Call to Action Section -->
  <div class="well">
    <div class="row">
      <div class="col-md-8">
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Molestias, expedita, saepe, vero rerum deleniti beatae veniam harum neque nemo praesentium cum alias asperiores commodi.</p>
      </div>
      <div class="col-md-4">
        <a class="btn btn-lg btn-default btn-block" href="#">Call to Action</a>
      </div>
    </div>
  </div>

  <hr>

</div>
<!-- /.container -->

<!-- jQuery -->
<script src="resources/js/jquery.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="resources/js/bootstrap.min.js"></script>

<!-- Script to Activate the Carousel -->
<script>
  $('.carousel').carousel({
    interval: 5000 //changes the speed
  })
</script>

</body>

</html>
