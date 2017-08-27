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
            # load additional indicator pages if they exist
            if $scope.indicators.next?
                _pages = Math.floor($scope.indicators.count / $scope.indicators.results.length)
                if $scope.indicators.count % $scope.indicators.results.length
                    _pages += 1
                    pages = []
                    angular.forEach [1..pages], (i) ->
                        pages.push(indicator.query({goal: $routeParams.id, page: i+1}).$promise)
                    $q.all(pages).then (data) ->
                        $scope.loading = false
                        $scope.indicators.next = null
                        $scope.indicators.pages = _pages
                        for page in data
                            $scope.indicators.results.push page.results...
            else
                $scope.loading = false
            return

        $scope.goto = (path) ->
            $location.path path

        return
