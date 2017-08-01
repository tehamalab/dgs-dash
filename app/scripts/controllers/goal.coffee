'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:GoalCtrl
 # @description
 # # GoalCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'GoalCtrl', ($scope, $routeParams, $location, $rootScope, $q, lookup, goal, target, indicator) ->
        lookup.refresh()
        $scope.loading = true

        goalsq = goal.query id: $routeParams.id, (data) ->
            $scope.goal = data
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • #{$scope.goal.name}"

        indicatorsq = indicator.query goal: $routeParams.id, (data) ->
            $scope.indicators = data

        targetsq = target.query goal: $routeParams.id, (data) ->
            $scope.targets = data

        $q.all([
            goalsq.$promise
            indicatorsq.$promise
            targetsq.$promise
        ]).then ->
            $scope.loading = false
            return

        $scope.goto = (path) ->
            $location.path path

        return
