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
  $routeProvider.when "/purchase_history",
    templateUrl: "/templates/purchase_history.html",
    controller: "purchaseHistoryCtrl"
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

app.factory "purchaseHeaderFactory", ["$resource", ($resource) ->
  return $resource "/api/purchase_headers/:id.json",
    { id: '@id' },
    {
      purchase: { method: "POST" }
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
    if $scope.items[index].quantity > 0
      insert_item = {
        name: $scope.items[index].name,
        price: $scope.items[index].price,
        quantity: $scope.items[index].quantity
      }
      $scope.cart.push(insert_item)
      $scope.items[index].quantity = null
    else
      alert("数量を入力してください。")

app.controller "cartCtrl", ($scope, $http, cart, purchaseHeaderFactory) ->
  $scope.cart = cart

  $scope.removeCart = (index) ->
    $scope.cart.splice(index, 1)

  $scope.getAmount = ->
    amount = 0
    for item, index in $scope.cart
      amount += item.price * item.quantity
    return amount

  $scope.purchaseProceeding = ->
    purchase_header = new purchaseHeaderFactory()
    purchase_header.amount = $scope.getAmount()
#    purchase_header.$purchase(
#      #{ "items": $scope.cart }
#      $scope.cart
#      ,(res)->
#        alert("購入に成功しました。")
#      ,(res)->
#        alert("購入に失敗しました。")
#    )
    $.post(
      "/api/purchase_headers.json",
      { amount: purchase_header.amount, items: $scope.cart })
      .done (data) ->
        alert("購入に成功しました。")
      .fail () ->
        alert("購入に失敗しました。")
    $scope.cart = []

app.controller "purchaseHistoryCtrl", ($scope, $http, purchaseHeaderFactory) ->
  $scope.purchase_headers = purchaseHeaderFactory.query()
