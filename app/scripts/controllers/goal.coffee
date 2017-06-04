'use strict'

###*
 # @ngdoc function
 # @name sdgsDash.controller:GoalCtrl
 # @description
 # # GoalCtrl
 # Controller of the sdgsDash
###
angular.module 'sdgsDash'
    .controller 'GoalCtrl', ($scope, $routeParams, $location, goal, indicator) ->
        goal.query id: $routeParams.id, (data) ->
            $scope.goal = data

        indicator.query goal: $routeParams.id, (data) ->
            $scope.indicators = data

        $scope.goto = (path) ->
            $location.path path

        return
