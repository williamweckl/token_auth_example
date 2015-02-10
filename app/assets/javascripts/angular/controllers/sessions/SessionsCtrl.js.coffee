@app.controller 'SessionsCreateCtrl', ['$scope', '$auth', '$rootScope', ($scope, $auth, $rootScope) ->
  $scope.handleLoginBtnClick = ->
    $auth.submitLogin($scope.loginForm)

  $scope.handleSignOutBtnClick = ->
    $auth.signOut()

  $rootScope.$on "auth:login-error", (ev, reason) ->
    $scope.errorAlert = true
    $scope.errors = reason["errors"]
    return

  $scope.loginForm =
    email: ''
    password: ''

  original = angular.copy($scope.loginForm)

  $scope.canSubmit = ->
    return $scope.form_signin.$valid && !angular.equals($scope.loginForm, original)

]