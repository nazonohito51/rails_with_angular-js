# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#appName = "angularApp"
#app = angular.module(appName, ["ngRoute", "ngResource"])
#
#app.config ($routeProvider, $locationProvider) ->
#  $routeProvider.when "/",
#    redirectTo:  "/dashboard"
#
#  $routeProvider.when "/dashboard", ->
#    templateUrl: "/templates/dashboard.html",
#    controller: "DashboardCtrl"
#
#  $routeProvider.when "/items", ->
#    templateUrl: "/templates/dashboard.html",
#    controller: "firstCtrl"
#
#  $locationProvider.html5Mode(true)
#
#app.config ($httpProvider) ->
#  authToken = angular.element('meta[name="csrf-token"]').attr("content")
#  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
#  $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"
#
#app.controller "firstCtrl", ($scope, $http) ->
#  $scope.test_value = "this is test value"
#
#app.controller "DashboardCtrl", ($scope, $http) ->
#  $scope.test_value = "this is dashboard ctrl"
#
#alert(3+7)

#angularApp.config( ($routeProvider, $locationProvider) ->
#  $routeProvider.when("/Book/:bookId", ->
#    templateUrl: "book.html",
#    controller: "BookCntl",
#    resolve: ->
#      # I will cause a 1 second delay
#      delay: ($q, $timeout) ->
#        delay = $q.defer()
#        $timeout(delay.resolve, 1000)
#        return delay.promise
#  )
#  $routeProvider.when('/Book/:bookId/ch/:chapterId', ->
#    templateUrl: 'chapter.html',
#    controller: ChapterCntl
#  )
#  # configure html5 to get links working on jsfiddle
#  $locationProvider.html5Mode(true)
#)

#
#app.controller("mainCtrl", ["$scope", function($scope){
#  $scope.myVar = "Hello Angular";
#  }]);
#MainCntl($scope, $route, $routeParams, $location) ->
#  $scope.$route = $route
#  $scope.$location = $location
#  $scope.$routeParams = $routeParams
#
#BookCntl($scope, $routeParams) ->
#  $scope.name = "BookCntl"
#  $scope.params = $routeParams
#
#ChapterCntl($scope, $routeParams) ->
#  $scope.name = "ChapterCntl"
#  $scope.params = $routeParams

#lateo.config( ($httpProvider) ->
#  authToken = angular.element('meta[name="csrf-token"]').attr("content");
#  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
#  $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";
#)
#
#lateo.directive("a", ->
#  restrict: "E"
#  link: (scope, elem, attrs) ->
#    if attrs.ngClick || attrs.href == "" || attrs.href == "#"
#      elem.on "click", (e) ->
#        e.preventDefault()
#        return
#)
#
#lateo.directive("ltSearchableSelect", ->
#  return {
#  replace:  true,
#  link: ($scope, $element) ->
#    $element.select2({
#      allowClear:       true,
#      formatNoMatches: "見つかりません",
#      width:           "320px"
#    })
#  }
#)
#
#lateo.directive("ltSearchableImageSelect", ->
#  return {
#  replace:  true,
#  link: ($scope, $element) ->
#    $element.select2
#      allowClear:      true,
#      placeholder:     "未選択",
#      formatNoMatches: "見つかりません",
#      width:           "100%",
#      initSelection: (element, callback) ->
#        data = { id: element.val(), text: element.data("default") }
#        callback(data)
#      ,formatSelection: (object, container) ->
#      $previewer = angular.element('.js-preview-select-image-screen')
#      if $previewer.length > 0
#        $previewer.find("a").attr
#          "href": object.original_url,
#          "data-lightbox": object.original_url
#        $previewer.find("img").attr("src", object.thumb_url)
#        $previewer.show()
#      return object.text
#      ,formatResult:    (object, container, query) ->
#      if !object.id
#        return object.text
#      return "<img src='" + object.thumb_url + "'/> " + object.text
#      ,ajax:
#      url: "/admin/item_images.json",
#      dataType: "json",
#      quietMillis: 500,
#      data: (term, page) ->
#        "q[picture_file_name_cont]": term,
#        page: page
#      ,results: (data, page, query) ->
#      for x in data.item_images
#        x.text = x.file_name
#      more: !!(data && data.links && data.links.next_page_url),
#      results: data.item_images
#  }
#)
#
## a要素をAjaxにし、結果をModalで表示するリクエストにする
#lateo.directive "ltAjaxModalRequest", ->
#  restrict: "A" # 属性
#  link: (scope, elem, attrs) ->
#    elem.on "click", (event) ->
#      html = ajaxGetHtml($(this).attr("href"))
#      dialog = new Dialog()
#      dialog.init(html)
#      dialog.show({backdrop: "static"})
#      event.preventDefault()
#      return
#
## 空(null)の場合だけデフォルト値をセットするフィルタ
## TODO もっと良い名前がある気がしている。
#lateo.filter "placeholdEmpty", ->
#  (input, placeholder) ->
#    if input == null
#      placeholder
#    else
#      input
#
#ajaxGetHtml = (url) ->
#  html = null
#  $.ajax url,
#    type: "GET",
#    async: false,
#    error: (jqXHR, textStatus, errorThrown) ->
#      alert("エラーが発生しました。")
#    success: (data, textStatus, jqXHR) ->
#      html = data.html
#  return html
#
#window.notifyErrors = (errors) ->
#  errorMsgs = []
#  $.each(errors, (key, value) ->
#    for val, i in value
#      errorMsgs.push(val)
#    return
#  )
#  alert(errorMsgs.join("\n"))
#  return
#
## TODO: 適当に拾ってきたコードなので、掲載商品以外でも使われる様になればちゃんとしたい。
##       x[hoge]=value を {x: {hoge: "value"}} にはパースできない実装。
#window.parseQueryString = ->
#  params = {}
#  parts = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&')
#
#  for part in parts
#    x = part.split("=")
#    params[x[0]] = x[1]
#
#  params
#
#jQuery ->
#  angular.bootstrap(document.body, ["lateo"])
#
