

m = angular.module("angular-chartjs-directive", [])



m.directive 'chartjs', ($filter) ->

  restrict: "E"
  replace: true
  template: '<canvas></canvas>'
  transclude: true
  scope:
    data: '=data',
    options: '=options',
    width: "=width",
    height: "=height",
    responsive: "@"

  link: ($scope, element, attr, ctrl) ->
    ctx = element[0].getContext('2d')
    $scope.references =
      parent:
        obj: $(element[0]).parent()[0],
        width: $(element[0]).parent()[0].clientWidth,
        height: $(element[0]).parent()[0].clientHeight
      self:
        width: $scope.width,
        height: $scope.height

    #black magic :)
    if $scope.width == "100%"
      $scope.width = $scope.references.parent.width
      $scope.references.self.width = $scope.width
      $scope.$watch "references.parent.obj.clientWidth", (newValue, old) ->
        if newValue != old
          $scope.width = (newValue * $scope.references.self.width)/$scope.references.parent.width;


    $scope.generate = () ->
      $scope.instance = eval('new Chart(ctx).' + attr.isType + '($scope.data, $scope.options)')


    $scope.$watch 'width', (newValue, oldValue) ->
      element[0].width = newValue;
      $scope.generate()

    $scope.$watch 'height', (newValue, oldValue) ->
      element[0].height = newValue;
      $scope.generate()

    $scope.$watch 'data', (newValue,oldValue) ->
      $scope.generate()
    , true


