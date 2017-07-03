'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:IndicatorCtrl
 # @description
 # # IndicatorCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'IndicatorCtrl', ($scope, $routeParams, $location, indicator, goal, component) ->

        $scope.activeTab = 'charts'

        indicator.query id: $routeParams.id, (data) ->
            $scope.indicator = data
            if $scope.indicator
                goal.query id: $scope.indicator.goal, (data) ->
                    $scope.goal = data

        component.query indicator: $routeParams.id, (data) ->
            $scope.components = data

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
