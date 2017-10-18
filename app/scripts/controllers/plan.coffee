'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:PlanCtrl
 # @description
 # # PlanCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'PlanCtrl', ($scope, $rootScope, $routeParams, $q, page, lookup, plan, goal, theme) ->
        lookup.refresh()
        $scope.loading = true
        $scope.plan_code = 'sdgs'
        page.current.plan_id = $routeParams.id

        planq = plan.query id: $routeParams.id, (data) ->
            $scope.plan = data
            $rootScope.title = "#{$scope.plan.name} • #{$rootScope.settings.SITE_NAME}"

        goalsq = goal.query {plan: $routeParams.id}, (data) ->
            $scope.goals = data

        themesq = theme.query {plan: $routeParams.id}, (data) ->
            $scope.themes = data

        $q.all([
            planq.$promise
            goalsq.$promise
            themesq.$promise
        ]).then ->
            $scope.loading = false
            return

        return
