'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:IndicatorCtrl
 # @description
 # # IndicatorCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'IndicatorCtrl', ($scope, $routeParams, $location, $rootScope, lookup, indicator, target, goal, component, progress) ->

        $scope.activeTab = 'charts'
        lookup.refresh()

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

        indicator.query id: $routeParams.id, (indicator) ->
            $scope.indicator = indicator
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • #{$scope.indicator.name}"
            target.query id: $scope.indicator.target, (target) ->
                $scope.target = target
            goal.query id: $scope.indicator.goal_id, (goal) ->
                $scope.goal = goal
                _chart.chart.color = d3.scale.category20().range()
                _chart.chart.color.unshift $scope.goal.extras.color_primary

        component.query indicators: $routeParams.id, (data) ->
            $scope.components = data
            progress.query indicator: $routeParams.id, (progress) ->
                $scope.progress = progress
                for component in $scope.components.results
                    _progress = _.where $scope.progress.results, component: component.id
                    component.progress = _(_progress).groupBy (progress) -> return progress.area_type_name
                    prepareComponent(component)

        prepareComponent = (component) ->
            if _.isEmpty(component.progress)
                return         
            component.charts = []
            for a, p of component.progress
                _areas = _.chain(p).uniq('area_name').map('area_name').value()
                _years = _.chain(p).uniq('year').map('year').value()
                _groups = _.chain(p).uniq((i) -> i.groups.join()).map('groups').value()
                _max = _.max(p, 'value')
                _min = _.min(p, 'value')
                _cdata =
                    key: component.name
                    type: 'line'
                    values: p
                    yAxis: 1
                chart =
                    data: []
                    options: angular.copy(_chart)
                    title: component.name
                    hasOneValue: false
                if component.value_unit is 'percent' 
                    if _max.value <= 50
                        chart.options.chart.yDomain1 = [0, Math.ceil((_max.value + (0.4 * _max.value)) / 10) * 10]
                    else if _max.value <= 100
                        chart.options.chart.yDomain1 = [0, 100]
                    else
                        chart.options.chart.yDomain1 = [0, Math.ceil(_max.value / 10) * 10]
                else
                    chart.options.chart.yDomain1 = [0, d3.max p, (d) -> d.value]
                for group in _groups
                    cdata = angular.copy(_cdata)
                    cdata.values = _.filter p, (i) -> _.isEqual(_.sortBy(group), _.sortBy(i.groups))
                    if _groups.length > 1
                        cdata.key = group.join(', ')
                    if a.toLowerCase() is 'region'
                        chart.title = "#{component.name} by region"
                        if _years.length is 1
                            chart.title = "#{component.name} by region year #{_years[0]}"
                            cdata.type = 'bar' 
                            chart.options.chart.x = (d) -> d.area_name
                            chart.options.chart.xAxis =
                                axisLabel: 'Region'
                                rotateLabels: 30
                    else if _years.length is 1 and _areas.length > 1
                        chart.title = "#{component.name} by #{a} year #{_years[0]}"
                        cdata.type = 'bar' 
                        chart.options.chart.x = (d) -> d.area_name
                        chart.options.chart.xAxis =
                            axisLabel: a
                            rotateLabels: 30
                    else if _years.length is 1
                        chart.title = "#{component.name} year #{_years[0]}"
                        cdata.type = 'bar'
                        chart.options.chart.xAxis =
                            axisLabel: ''
                            rotateLabels: 0
                            tickFormat: (d) -> ''
                    else if a.toLowerCase() is 'sub-country'
                        chart.title = "#{ _areas.join(', ')} - #{component.name}"
                    chart.data.push cdata
                if chart.data.length is 1 and chart.data[0].values.length is 1
                    chart.hasOneValue = true 
                if component.target_value
                    targetChart =
                        key: 'Target'
                        type: 'line'
                        values: $scope.mapTarget component.target_value, component.progress
                        yAxis: 1
                    chart.data.push targetChart
                component.charts.push chart

        $scope.mapTarget = (target, values) ->
            vals = angular.copy(values)
            _.map vals, (item) ->
               item.value = target
               item
