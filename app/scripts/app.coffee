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
    'ngTouch',
    'nvd3'
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
      .when '/goals/:id/:slug',
        templateUrl: 'views/goal.html'
        controller: 'GoalCtrl'
        controllerAs: 'goal'
      .when '/indicators/:id',
        templateUrl: 'views/indicator.html'
        controller: 'IndicatorCtrl'
        controllerAs: 'indicator'
      .otherwise
        redirectTo: '/'

