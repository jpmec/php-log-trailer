### jshint -W093 ###

'use strict'




appModule = angular.module 'LogTrailerApp', [
   'ngRoute'
   'appViews'
   'ui.bootstrap'
   'angular-chartjs-directive'
]




appModule.config ($routeProvider) ->
  $routeProvider.when('/',
    templateUrl: 'app/app_view.html'
  ).when('/dashboard',
    templateUrl: 'app/app_dashboard_view.html'
  ).when('/table',
    templateUrl: 'app/app_table_view.html'
  ).otherwise redirectTo: '/'




appModule.factory 'Logs', () ->
  object:
    value: null


appModule.factory 'LogsSizeChartData', () ->
  object:
    labels: []
    datasets : [
      fillColor : "rgba(151,187,205,0.5)",
      strokeColor : "rgba(151,187,205,1)",
      data : []
    ]



appModule.service 'LogsService', ($http, Logs, LogsSizeChartData) ->

  @url = 'api/0/'

  @get = (onSuccess, onError) ->

    $http.get(@url)
    .success (data, status, headers, config) ->


      # _.each data, (value, key, collection) ->
      #   console.log(value)



      Logs.object.value = data

      sizedata = []
      LogsSizeChartData.object.datasets[0].data.length = 0
      _.each _.values(data), (value, key, collection) ->

        if value
          v = Math.log(value.size) / Math.log(10)
          LogsSizeChartData.object.datasets[0].data.push(v)
        else
          LogsSizeChartData.object.datasets[0].data.push(0)

      , LogsSizeChartData.object.datasets[0].data


      LogsSizeChartData.object.labels.length = 0
      _.each _.keys(data), (value, key, collection) ->

        LogsSizeChartData.object.labels.push(key)
      , LogsSizeChartData.object.labels


      if onSuccess
        onSuccess()

      return

    .error (data, status, headers, config) ->
      Logs.object.value = null

      if onError
        onError()

      return

  return





appModule.controller 'LogsCtrl', ($scope, $timeout, Logs, LogsService) ->
  $scope.logs = Logs.object
  $scope.timeoutMilliseconds = 10000

  $scope.files = ->
    _.keys($scope.logs.value)


  $scope.get = () ->
    LogsService.get( ()->
      $timeout( () ->
        $scope.get()
      , $scope.timeoutMilliseconds)
    )

  $scope.get()
  return




appModule.controller 'LogsTableCtrl', ($scope, $timeout, Logs, LogsService) ->
  $scope.logs = Logs.object




appModule.controller 'LogsSizeChartCtrl', ($scope, Logs, LogsSizeChartData) ->
  $scope.log = Logs.object
  $scope.chartOptions = null
  $scope.chartData = LogsSizeChartData.object


  # $scope.$watch 'Logs.object', (newValue, oldValue) ->

  #   console.log('watched')
  #   console.log($scope.log.value)

  #   if $scope.log.value

  #     $scope.chartData =
  #       labels : _.keys($scope.log.value),
  #       datasets : [
  #         fillColor : "rgba(151,187,205,0.5)",
  #         strokeColor : "rgba(151,187,205,1)",
  #         data : _.pluck(_.values($scope.log.value), "size")
  #       ]

  #     console.log('new chartData')
  #     console.log($scope.chartData)


