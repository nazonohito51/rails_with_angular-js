appName = "angularApp"
app = angular.module(appName, ["ngRoute", "ngResource"])

app.config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/",
    redirectTo:  "/items"
  $routeProvider.when "/items",
    templateUrl: "templates/items.html",
    controller: "itemsCtrl"
  $routeProvider.when "/on_sales",
    templateUrl: "/templates/on_sales.html",
    controller: "onSaleCtrl"
  $routeProvider.when "/cart",
    templateUrl: "/templates/cart.html",
    controller: "cartCtrl"
  $locationProvider.html5Mode(true)

app.config ($httpProvider) ->
  authToken = angular.element('meta[name="csrf-token"]').attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
  $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"

app.factory "itemFactory", ["$resource", ($resource) ->
  return $resource "/api/items/:id.json",
    { id: '@id' },
    {
      update: { method: 'PATCH' },
      query_on_sale: { method: "GET", isArray: true, params: { on_sale: true } }
    }
]

app.value "cart", []

app.controller "itemsCtrl", ($scope, $http, itemFactory) ->
  $scope.items = itemFactory.query()
  $scope.new_item = new itemFactory()

  $scope.createItem = ->
    $scope.new_item.$save(
      (res)->
        alert("商品の登録に成功しました。")
      ,(res)->
        alert("商品の登録に失敗しました。")
    )
    $scope.items = itemFactory.query()
    $scope.new_item = new itemFactory()

  $scope.deleteItem = (index) ->
    $scope.items[index].$delete(
      (res)->
        alert("商品の削除に成功しました。")
      ,(res)->
        alert("商品の削除に失敗しました。")
    )
    $scope.items = itemFactory.query()

  $scope.changeOnSale = (index) ->
    $scope.items[index].$update(
      (res)->
        alert("商品の更新に成功しました。")
      ,(res)->
        alert("商品の更新に失敗しました。")
    )

app.controller "onSaleCtrl", ($scope, $http, itemFactory, cart) ->
  $scope.items = itemFactory.query_on_sale()
  $scope.new_item = new itemFactory()
  $scope.cart = cart

  $scope.insertCart = (index) ->
    console.log($scope.items[index])
    if $scope.items[index].quantity > 0
      $scope.cart.push($scope.items[index])
    else
      alert("数量を入力してください。")

app.controller "cartCtrl", ($scope, $http, cart) ->
  $scope.cart = cart

  $scope.removeCart = (index) ->
    console.log($scope.cart[index])
    $scope.cart.splice(index, 1)

  $scope.getAmount = ->
    amount = 0
    for item, index in $scope.cart
      amount += item.price * item.quantity
    return amount

  $scope.purchaseProceeding = ->
    # TODO: 購入処理
    alert("実装途中です")
