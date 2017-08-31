'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'MainCtrl', ($scope, $rootScope, $location, $q, lookup, plan, theme, goal) ->
        
        lookup.refresh()
        $rootScope.title = "#{$rootScope.settings.SITE_NAME}"
        $scope.loading = true

        plansq = plan.query {}, (data) ->
            $scope.plans = data

        themesq = theme.query {}, (data) ->
            $scope.themes = data

        goalsq = goal.query {}, (data) ->
            $scope.goals = data

        $q.all([
            plansq.$promise
            themesq.$promise
            goalsq.$promise
        ]).then ->
            $scope.loading = false
            for _plan in $scope.plans.results
                _plan.themes = _.where $scope.themes.results, plan_id: _plan.id
                _plan.goals = _.where $scope.goals.results, plan_id: _plan.id

        $scope.goto = (path) ->
            $location.path path

        return
