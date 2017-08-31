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
                                  lookup, indicator, target, plan, goal, theme, sector, component, progress) ->

        lookup.refresh()
        $scope.loading = true
        $scope.color = primary: ''

        $scope.SUB_SECTOR = 'sub-sector'

        indicatorq = indicator.query id: $routeParams.id, (_indicator) ->
            $scope.indicator = _indicator
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • #{$scope.indicator.name}"
            if $scope.indicator.target
                target.query id: $scope.indicator.target, (target) ->
                    $scope.target = target
            if $scope.indicator.goal_id
                goal.query id: $scope.indicator.goal_id, (goal) ->
                    $scope.goal = goal
                    if goal.extras
                        component._chart.chart.color[0] = $scope.goal.extras.color_primary
                        component._map.color.primary = $scope.goal.extras.color_primary
                        $scope.color.primary = $scope.goal.extras.color_primary
            if $scope.indicator.theme
                theme.query id: $scope.indicator.theme, (_theme) ->
                    $scope.theme = _theme
                    if not $scope.color.primary and $scope.theme.extras.color_primary
                        $scope.color.primary = $scope.theme.extras.color_primary
                        component._chart.chart.color[0] = $scope.theme.extras.color_primary
                        component._map.color.primary = $scope.theme.extras.color_primary
            if $scope.indicator.sector
                sector.query id: $scope.indicator.sector, (_sector) ->
                    $scope.sector = _sector
            if $scope.indicator.sector_type_code == $scope.SUB_SECTOR and $scope.indicator.root_sector_id
                sector.query id: $scope.indicator.root_sector_id, (_rootSector) ->
                    $scope.rootSector = _rootSector
            if $scope.indicator.plan_id
                plan.query id: $scope.indicator.plan_id, (_plan) ->
                    $scope.plan = _plan
            # get related indicators
            if $scope.indicator.goal_id
                indicator.query goal: $scope.indicator.goal_id, (indicators) ->
                    $scope.indicators = indicators
            else if $scope.indicator.sector
                indicator.query sectors_ids: $scope.indicator.sector, (indicators) ->
                    $scope.indicators = indicators
            else if $scope.indicator.theme
                indicator.query theme: $scope.indicator.theme, (indicators) ->
                    $scope.indicators = indicators
            else if $scope.indicator.target
                indicator.query target: $scope.indicator.target, (indicators) ->
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

