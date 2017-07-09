'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:TargetCtrl
 # @description
 # # TargetCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'TargetCtrl', ($scope, $routeParams, $rootScope, lookup, target, goal, indicator) ->
        lookup.refresh()
        target.query id: $routeParams.id, (data) ->
            $scope.target = data
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • #{$scope.target.name}"
            goal.query id: $scope.target.goal, (goal) ->
                $scope.goal = goal

        indicator.query target: $routeParams.id, (data) ->
            $scope.indicators = data

        return
