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
                prepareComponent($scope.component)

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
                        if _areas.length is 1
                            chart.title = "#{component.name} in #{_areas[0]}"
                        chart.options.chart.x = (d) -> d.area_name
                        chart.options.chart.xAxis =
                            axisLabel: 'Region'
                            rotateLabels: 30
                        if _years.length is 1
                            chart.title = "#{chart.title} year #{_years[0]}"
                            cdata.type = 'bar'
                            chart.data.push cdata
                        else
                            for year in _years
                                ydata = angular.copy(cdata)
                                ydata.key = year
                                ydata.type = 'bar'
                                ydata.values = _.where p, year: year
                                chart.data.push ydata
                    else if _years.length is 1 and _areas.length > 1
                        chart.title = "#{component.name} by #{a} year #{_years[0]}"
                        cdata.type = 'bar' 
                        chart.options.chart.x = (d) -> d.area_name
                        chart.options.chart.xAxis =
                            axisLabel: a
                            rotateLabels: 30
                        chart.data.push cdata
                    else if _years.length is 1
                        chart.title = "#{component.name} year #{_years[0]}"
                        cdata.type = 'bar'
                        chart.options.chart.xAxis =
                            axisLabel: ''
                            rotateLabels: 0
                            tickFormat: (d) -> ''
                        chart.data.push cdata
                    else if a.toLowerCase() is 'sub-country'
                        chart.title = "#{ _areas.join(', ')} - #{component.name}"
                        chart.data.push cdata
                    else
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

        return
