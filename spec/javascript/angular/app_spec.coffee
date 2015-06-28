describe 'app module', ->
  it '存在すること', ->
    expect(app).not.toBeNull()

  it '依存モジュールの確認', ->
    expect(app.requires).toContain('ngResource', 'ngRoute')

describe 'itemsCtrl', ->
  #beforeEach module('app')

  $controller = null
  #controller = 1
  $scope = null

  beforeEach ->
    module('angularApp')
    inject (_$controller_) ->
      #$scope = $rootScope.$new()
      # The injector unwraps the underscores (_) from around the parameter names when matching
      #controller = $controller('itemsCtrl', { $scope: $scope } )
      $controller = _$controller_

  describe '$scope.grade', ->
    it 'sets the strength to "strong" if the password length is >8 chars', ->
      $scope = {}
      console.log $controller('itemsCtrl', { $scope: $scope })
#      controller = $controller('itemsCtrl', { $scope: $scope })
#      #console.log controller
#      $scope.password = 'longerthaneightchars'
#      $scope.grade()
#      expect($scope.strength).toEqual('strong')

#  describe '$scope.grade', ->
#    it 'sets the strength to "strong" if the password length is >8 chars', inject ($rootScope, $controller) ->
#      $scope = $rootScope.$new()
#      # The injector unwraps the underscores (_) from around the parameter names when matching
#      controller = $controller('itemsCtrl', { $scope: $scope })
#      console.log app
