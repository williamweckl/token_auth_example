# This line is related to our Angular app, not to our
# HomeCtrl specifically. This is basically how we tell
# Angular about the existence of our application.
@app = angular.module('token_auth_example', ['ngRoute', 'ng-token-auth', 'ipCookie'])

# This routing directive tells Angular about the default
# route for our application. The term "otherwise" here
# might seem somewhat awkward, but it will make more
# sense as we add more routes to our application.
@app.config(['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider
  .when('/dashboard', {
      templateUrl: '../views/dashboard.html',
      controller: 'DashboardCtrl',
      resolve: {
        auth: ['$auth', ($auth) ->
          resolver($auth)
        ]
      }
    })
  .when('/sign_in', {
      templateUrl: 'views/sessions/new.html',
      controller: 'SessionsCreateCtrl'
    })
  .when('/sign_up', {
      templateUrl: 'views/users/new.html',
      controller: 'UsersCreateCtrl'
    })

  $routeProvider.
  otherwise({
      redirectTo: '/dashboard'
    })

  $locationProvider.html5Mode(true)

  resolver = ($auth) ->
    userAuth = $auth.validateUser()
    if userAuth.$$state.value
      window.location.href = '/sign_in' if userAuth.$$state.value.errors || userAuth.$$state.value.reason
    userAuth

])

@app.config ($authProvider) ->
  $authProvider.configure({
    apiUrl: '',
    authProviderPaths: {
      facebook:  '/auth/facebook',
    }
  });

@app.run(['$rootScope', '$auth', '$location', ($rootScope, $auth, $location) ->
  $rootScope.config = {
    name: "Token Auth Example"
  }

  $rootScope.$on "auth:login-success", (ev, message) ->
    $location.path('/')

  $rootScope.$on "auth:validation-error", (ev, message) ->
    $location.path('/login')

])