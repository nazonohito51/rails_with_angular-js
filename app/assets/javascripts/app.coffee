appName = "angularApp"
app = angular.module(appName, ["ngRoute", "ngResource"])

app.config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/",
    redirectTo:  "/items"

  $routeProvider.when "/dashboard",
    templateUrl: "/templates/dashboard.html",
    controller: "DashboardCtrl"

  $routeProvider.when "/items",
    templateUrl: "/templates/items.html",
    controller: "firstCtrl"

  $locationProvider.html5Mode(true)

#app.config ($httpProvider) ->
#  authToken = angular.element('meta[name="csrf-token"]').attr("content")
#  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
#  $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"

app.controller "firstCtrl", ($scope, $http) ->
  $scope.test_value = "this is test value"

app.controller "DashboardCtrl", ($scope, $http) ->
  $scope.test_value = "this is dashboard ctrl"

alert(3+7)
