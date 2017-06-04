'use strict'

###*
 # @ngdoc overview
 # @name sdgsDash
 # @description
 # # sdgsDash
 #
 # Main module of the application.
###
angular
  .module 'sdgsDash', [
    'ngAnimate',
    'ngAria',
    'ngCookies',
    'ngMessages',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'
      .when '/goal/:id/:slug',
        templateUrl: 'views/goal.html'
        controller: 'GoalCtrl'
        controllerAs: 'goal'
      .otherwise
        redirectTo: '/'

