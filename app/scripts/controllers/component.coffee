'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:ComponentCtrl
 # @description
 # # ComponentCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'ComponentCtrl', ($scope, $routeParams, $rootScope, lookup, component, progress) ->
        lookup.refresh()
        $scope.component = {}
        $scope.loading = true

        _chart =
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
                color: d3.scale.category20().range()

        component.query id: $routeParams.id, (data) ->
            $scope.loading = false
            _.extendOwn($scope.component, data)
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • #{$scope.component.name}"
            progress.query component: $routeParams.id, (progress) ->
                $scope.progress = progress
                $scope.component.progress = _($scope.progress.results).groupBy (progress) -> return progress.area_type_name
                component.prepare($scope.component)

        return
