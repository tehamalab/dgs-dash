'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:NavCtrl
 # @description
 # # NavCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'NavCtrl', ($scope, $location, $q, plan, theme, goal, page, lookup) ->
        lookup.search = {}
        $scope.lookup = lookup
        $scope.page = page
        $scope.goalHovered = null
        $scope.current = page.current

        plan.query {}, (data) ->
            $scope.plans = data

        themesq = theme.query {}, (data) ->
            $scope.themes = data

        goalsq = goal.query {}, (data) ->
            $scope.goals = data

        $q.all([
            themesq.$promise
            goalsq.$promise
        ]).then ->
            setCurrentPlan()

        $scope.search = ->
            $location.url('/search').search(lookup.search)

        setCurrentPlan = (plan_id=page.current.plan_id) ->
            $scope.current.plan_id = plan_id
            if plan_id
                goal.query {plan: plan_id}, (data) ->
                    $scope.current.goals = data
                theme.query {plan: plan_id}, (data) ->
                    $scope.current.themes = data
            else
                $scope.current.themes = angular.copy $scope.themes
                $scope.current.goals = angular.copy $scope.goals


        $scope.$watch 'lookup.search.q', (newValue, oldValue) ->
            if newValue
                if !$location.path().startsWith('/search') and newValue.length > 3
                    $scope.search()


        $scope.$watch 'page.current.plan_id', (newValue, oldValue) ->
            setCurrentPlan()

        return
