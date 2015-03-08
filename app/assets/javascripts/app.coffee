appName = "angularApp"
app = angular.module(appName, ["ngRoute", "ngResource"])

app.config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/",
    redirectTo:  "/items"

  $routeProvider.when "/cart",
    templateUrl: "/templates/cart.html",
    controller: "cartCtrl"

  $routeProvider.when "/items",
    templateUrl: "/templates/items.html",
    controller: "itemCtrl"

  $locationProvider.html5Mode(true)

app.config ($httpProvider) ->
  authToken = angular.element('meta[name="csrf-token"]').attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
  $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"

app.factory "itemFactory", ["$resource", ($resource) ->
  return $resource "/api/items/:id.json",
    { id: '@id' },
    {}
]

app.value "cart", []

app.controller "itemCtrl", ($scope, $http, itemFactory, cart) ->
  $scope.items = itemFactory.query()
  $scope.new_item = new itemFactory()
  $scope.cart = cart

  $scope.createItem = ->
    $scope.new_item.$save(
      (res)->
        alert("商品の登録に成功しました。")
      ,(res)->
        alert("商品の登録に失敗しました。")
    )
    $scope.items = itemFactory.query()

  $scope.insertCart = (item) ->
    if item.quantity > 0
      $scope.cart.push(item)
    else
      alert("数量を入力してください。")

app.controller "cartCtrl", ($scope, $http, cart) ->
  $scope.cart = cart

  $scope.removeCart = (id) ->
    for item, index in $scope.cart
      $scope.cart.splice(index, 1) if item.id == id

  $scope.getAmount = ->
    amount = 0
    for item, index in $scope.cart
      amount += item.price * item.quantity
    return amount

  $scope.purchaseProceeding = ->
    # TODO: 購入処理
    alert("実装途中です")
