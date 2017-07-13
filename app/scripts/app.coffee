'use strict'

###*
 # @ngdoc overview
 # @name dgsDash
 # @description
 # # dgsDash
 #
 # Main module of the application.
###
angular
  .module 'dgsDash', [
    'ngAnimate',
    'ngAria',
    'ngCookies',
    'ngMessages',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'gettext',
    'nvd3'
  ]
  .config ($routeProvider, $locationProvider, $resourceProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
      .when '/search',
        templateUrl: 'views/search.html'
        controller: 'SearchCtrl'
        controllerAs: 'search'
      .when '/goals/:id/:slug',
        templateUrl: 'views/goal.html'
        controller: 'GoalCtrl'
        controllerAs: 'goal'
      .when '/targets/:id/:slug',
        templateUrl: 'views/target.html'
        controller: 'TargetCtrl'
        controllerAs: 'target'
      .when '/indicators/:id/:slug',
        templateUrl: 'views/indicator.html'
        controller: 'IndicatorCtrl'
        controllerAs: 'indicator'
      .when '/components/:id/:slug',
        templateUrl: 'views/component.html'
        controller: 'ComponentCtrl'
        controllerAs: 'component'
      .when '/data',
        templateUrl: 'views/data.html'
        controller: 'DataCtrl'
        controllerAs: 'data'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'
      .otherwise
        redirectTo: '/'
    $locationProvider.html5Mode true
    $resourceProvider.defaults.stripTrailingSlashes = false
  .run ($rootScope, settings) ->
    $rootScope.settings = settings

