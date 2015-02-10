@app.controller 'UsersCreateCtrl', ['$scope', '$auth', '$rootScope', ($scope, $auth, $rootScope) ->
  $scope.handleRegBtnClick = ->
    $auth.submitRegistration($scope.registrationForm)

  $rootScope.$on "auth:registration-email-error", (ev, reason) ->
    $scope.errorAlert = true
    $scope.errors = reason["errors"]

  $rootScope.$on "auth:registration-email-success", (ev, message) ->
    $rootScope.flash = {success: message.email}
    window.location.href = '/sign_in'

  $scope.registrationForm =
    name: ''
    email: ''
    password: ''
    password_confirmation: ''

  original = angular.copy($scope.registrationForm)

  $scope.canSubmit = ->
    return $scope.form_signup.$valid && !angular.equals($scope.registrationForm, original)
]