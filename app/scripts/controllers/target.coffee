'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:TargetCtrl
 # @description
 # # TargetCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'TargetCtrl', ($scope, $routeParams, $rootScope, $q, page, lookup, target, goal, indicator) ->
        lookup.refresh()
        $scope.loading = true

        targetq = target.query id: $routeParams.id, (_target) ->
            $scope.target = _target
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • #{$scope.target.name}"
            goal.query id: $scope.target.goal, (_goal) ->
                $scope.goal = _goal
                page.current.plan_id = $scope.goal.plan_id
            target.query goal: $scope.target.goal, (_targets) ->
                $scope.targets = _targets

        indicatorsq =indicator.query target: $routeParams.id, (data) ->
            $scope.indicators = data

        $q.all([
            targetq.$promise
            indicatorsq.$promise
        ]).then ->
            $scope.loading = false
            return

        return
