'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:GoalCtrl
 # @description
 # # GoalCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'GoalCtrl', ($scope, $routeParams, $location, lookup, goal, indicator) ->
        lookup.refresh()
        goal.query id: $routeParams.id, (data) ->
            $scope.goal = data

        indicator.query goal: $routeParams.id, (data) ->
            $scope.indicators = data

        $scope.goto = (path) ->
            $location.path path

        return
