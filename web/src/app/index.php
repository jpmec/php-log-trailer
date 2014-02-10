<!DOCTYPE html>
<html lang="en" ng-app="LogTrailerApp">
  <head>
    <meta charset="utf-8">
    <title>Log Trailer</title>

    <!-- build:css css/app.css -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/ng-grid.min.css">
    <!-- endbuild -->

  </head>
  <body>


    <div class="container">

      <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">

          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><i class="fa fa-road fa-fw"></i> Log Trailer</a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
              <li class="active"><a href="#/dashboard"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a></li>
              <li><a href="#"><i class="fa fa-files-o fa-fw"></i> Logs</a></li>
              <li><a href="#/table"><i class="fa fa-table fa-fw"></i> Table</a></li>
            </ul>
          </div>

        </div>
      </nav>

      <ng-view></ng-view>

    </div>

    <!-- build:js js/app.js -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/angular.min.js"></script>
    <script type="text/javascript" src="js/angular-route.min.js"></script>
    <script type="text/javascript" src="js/lodash.min.js"></script>
    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src="js/ng-grid-2.0.7.min.js"></script>
    <script type="text/javascript" src="js/ui-bootstrap-tpls.min.js"></script>

    <script type="text/javascript" src="js/Chart.min.js"></script>

    <script type="text/javascript" src="js/angular-chartjs.js"></script>

    <script type="text/javascript" src="js/app.js"></script>
    <script type="text/javascript" src="js/app-views.js"></script>
    <!-- endbuild -->

  </body>
</html>

