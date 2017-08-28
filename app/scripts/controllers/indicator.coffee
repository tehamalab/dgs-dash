'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:IndicatorCtrl
 # @description
 # # IndicatorCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'IndicatorCtrl', ($scope, $routeParams, $location, $rootScope, $q
                                  lookup, indicator, target, goal, component, progress) ->

        lookup.refresh()
        $scope.loading = true

        indicatorq = indicator.query id: $routeParams.id, (_indicator) ->
            $scope.indicator = _indicator
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • #{$scope.indicator.name}"
            target.query id: $scope.indicator.target, (target) ->
                $scope.target = target
            goal.query id: $scope.indicator.goal_id, (goal) ->
                $scope.goal = goal
                component._chart.chart.color[0] = $scope.goal.extras.color_primary
                component._map.color.primary = $scope.goal.extras.color_primary
            indicator.query goal: $scope.indicator.goal_id, (indicators) ->
                $scope.indicators = indicators

        componentsq = component.query indicators: $routeParams.id, (data) ->
            $scope.components = data
            progress.query indicator: $routeParams.id, (data) ->
                $scope.progress = data
                $scope.loading = true
                if $scope.progress.next?
                    _pages = Math.floor($scope.progress.count / $scope.progress.results.length)
                    if $scope.progress.count % $scope.progress.results.length
                        _pages += 1
                    pages = []
                    angular.forEach [1..pages], (i) ->
                        if i > 0
                            pages.push(progress.query({indicator: $routeParams.id, page: i+1}).$promise)
                    $q.all(pages).then (data) ->
                        $scope.progress.next = null
                        $scope.progress.pages = _pages
                        for page in data
                            $scope.progress.results.push page.results...
                        for _component in $scope.components.results
                            _progress = _.where $scope.progress.results, component: _component.id
                            _component.progress = _(_progress).groupBy (progress) -> return progress.area_type_name
                            component.prepare(_component)
                else
                    for _component in $scope.components.results
                        _progress = _.where $scope.progress.results, component: _component.id
                        _component.progress = _(_progress).groupBy (progress) -> return progress.area_type_name
                        component.prepare(_component)
                $scope.loading = false

        $q.all([
            indicatorq.$promise
            componentsq.$promise
        ]).then ->
            $scope.loading = false
            return

        $scope.showMapLayer = (layer, map) ->
            console.log layer, map

