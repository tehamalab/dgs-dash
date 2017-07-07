'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:IndicatorCtrl
 # @description
 # # IndicatorCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'IndicatorCtrl', ($scope, $routeParams, $location, lookup, indicator, target, goal, component, progress) ->

        $scope.activeTab = 'charts'
        lookup.refresh()

        indicator.query id: $routeParams.id, (indicator) ->
            $scope.indicator = indicator
            target.query id: $scope.indicator.target, (target) ->
                $scope.target = target
            goal.query id: $scope.indicator.goal_id, (goal) ->
                $scope.goal = goal
                $scope.barChart.chart.color.unshift $scope.goal.extras.color_primary

        component.query indicators: $routeParams.id, (data) ->
            $scope.components = data
            progress.query indicator: $routeParams.id, (progress) ->
                $scope.progress = progress
                for component in $scope.components.results
                    component.progress = _.where $scope.progress.results, component: component.id
                    if component.progress.length
                        component.chart = [
                            {
                                key: component.name
                                type: 'line'
                                values: component.progress
                                yAxis: 1
                             }]
                        if component.target_value
                            targetChart =
                                key: 'Target'
                                type: 'line'
                                values: $scope.mapTarget component.target_value, component.progress
                                yAxis: 1
                            component.chart.push targetChart

        $scope.barChart =
            chart:
                type: 'multiChart'
                height: 450
                margin:
                    top: 20
                    right: 20
                    bottom: 65
                    left: 50
                x: (d) -> d.year
                y: (d) -> d.value
                showValues: true
                showControls: false
                focusEnable: false
                showLegend: true
                xAxis:
                    axisLabel: 'Year'
                    rotateLabels: 30
                yAxis1:
                    axisLabel: "Value"
                    axisLabelDistance: -10
                    tickFormat: (d) -> d
                tooltip:
                    valueFormatter: (d) -> "#{d} %"
                color: [
                  '#1f77b4'
                  '#229A00'
                  '#FF9300'
                  '#ff7f0e'
                  '#2ca02c'
                  '#d62728'
                  '#9467bd'
                  '#8c564b'
                  '#e377c2'
                  '#7f7f7f'
                  '#bcbd22'
                  '#17becf'
                ]

        $scope.mapTarget = (target, values) ->
            vals = angular.copy(values)
            _.map vals, (item) ->
               item.value = target
               item
