'use strict'

###*
 # @ngdoc service
 # @name dgsDash.component
 # @description
 # # component
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'component', ($resource, $q, leafletData, L, settings, common, areatype) ->

        self = this

        @_chart =
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
                showLabels: true
                showControls: false
                focusEnable: false
                showLegend: true
                reduceXTicks: false
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

        @_map =
            defaults:
                scrollWheelZoom: false
                tileLayer: 'http://{s}.tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png'
                maxZoom: 9
            center:
                lat: -6.3969
                lng: 34.6287
                zoom: 6
            color:
                primary: '#EEEEEE'

        angular.extend this, $resource settings.API_ROOT_URL + "/components/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true

        @prepare = (component) ->
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
                    options: angular.copy(@_chart)
                    title: component.name
                    hasOneValue: false
                chart.options.chart.yDomain1 = [0, _max.value]
                if _min.value < 0
                    chart.options.chart.yDomain1[0] = _min.value
                if component.value_unit is 'percent'
                    if _max.value <= 1
                        chart.options.chart.yDomain1[1] = _max.value + 0.1
                    else if _max.value <= 10
                        chart.options.chart.yDomain1[1] = 10
                    else if _max.value <= 50
                        chart.options.chart.yDomain1[1] = Math.ceil((_max.value + (0.4 * _max.value)) / 10) * 10
                    else if _max.value <= 100
                        chart.options.chart.yDomain1[1] = 100
                    else
                        chart.options.chart.yDomain1[1] = Math.ceil(_max.value / 10) * 10
                else
                    chart.options.chart.yDomain1[1] = d3.max p, (d) -> d.value
                for group in _groups
                    cdata = angular.copy(_cdata)
                    cdata.values = _.filter p, (i) -> _.isEqual(_.sortBy(group), _.sortBy(i.groups))
                    cdata.values = _.sortBy cdata.values, 'year'
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

                        cdata.values = _.sortBy cdata.values, 'area_name'
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
                                ydata.values = _.sortBy ydata.values, 'area_name'
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
                        values: @mapTarget component.target_value, component.progress
                        yAxis: 1
                    chart.data.push targetChart
                component.charts.push chart
            @prepareMaps(component)

        @prepareMaps = (component) ->
            if _.isEmpty(component.progress)
                return
            component.maps = []
            component.mapsReady = false
            for a, p of component.progress
                _areas = _.chain(p).uniq('area_name').map('area_name').value()
                _years = _.chain(p).uniq('year').map('year').value()
                _groups = _.chain(p).uniq((i) -> i.groups.join()).map('groups').value()
                _max = _.max p, 'value'
                _min = _.min p, 'value'
                _cdata =
                    key: component.name
                    values: p
                map =
                    data: []
                    options: angular.copy(@_map)
                    title: component.name
                    layers:
                        baselayers:
                            osm:
                                name: 'OpenStreetMap'
                                url: 'http://{s}.tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png'
                        overlays: {}
                        data: {}
                for group in _groups
                    cdata = angular.copy(_cdata)
                    cdata.values = _.filter p, (i) -> _.isEqual(_.sortBy(group), _.sortBy(i.groups))
                    cdata.domain = [_min.value, _max.value]
                    if _groups.length > 1
                        cdata.key = group.join(', ')
                    if a.toLowerCase() is 'region' and _areas.length > 2
                        map.title = "#{component.name} by region"
                        map.id = "map-regions-#{component.id}"
                        map.years = _years
                        year = _.max(cdata.values, 'year').year
                        cdata.year = year
                        cdata.values = _.where cdata.values, year: year
                        map.title = "#{component.name}  by region year #{cdata.year}"
                        map.data.push cdata
                    unless _.isEmpty(map.data)
                        component.maps.push(map)
            $q.all([common.areatypesq]).then (_d) ->
                $q.all([common.regionsq]).then (_d) ->
                    for cmap in component.maps
                        baseMaps = {}
                        baseMap  = L.tileLayer cmap.layers.baselayers.osm.url
                        baseMaps[cmap.layers.baselayers.osm.name] = baseMap
                        leafletData.getMap(cmap.id).then (leafletMap) ->
                            cmap._map = leafletMap
                            for layer in cmap.data
                                cmap.layers.data[layer.year] = JSON.parse(JSON.stringify(common.geojson.region))
                                cmap.layers.data[layer.year].features = _.map(
                                    cmap.layers.data[layer.year].features, (item) ->
                                        feature = _.extend item.properties, _.findWhere(layer.values, area: item.properties.id)
                                        feature._domain = layer.domain
                                        _.extendOwn item.properties, feature
                                        item
                                )
                                cmap.layers.overlays[layer.year] = L.geoJSON(
                                    cmap.layers.data[layer.year],
                                    {style: self._map.style, onEachFeature: self._map.onEachFeature}).addTo(cmap._map)

        @_map.style = (feature) ->
            colorScale = self.getColorScale(feature.properties._domain)
            style =
                opacity: 1
                weight: 1
                color: d3.rgb(colorScale(feature.properties.value)).darker(0.5).toString()
                fillColor: colorScale(feature.properties.value)
                fillOpacity: 1
            unless feature.properties.value?
                style.color = '#DDD'
                style.fillColor = '#777'
            style

        @_map.onEachFeature = (feature, layer) ->
            if feature.properties.area_name?
                layer.bindTooltip(
                    "#{feature.properties.area_name}<br>#{feature.properties.value}",
                    {permanent: true, direction: 'center', className: 'map-polygon-tooltip'})

        @getColorScale = (domain) ->
            _cbright = d3.rgb(@_map.color.primary).brighter(0.9)
            _cdark = d3.rgb(@_map.color.primary).darker(0.9)
            d3.scale.linear()
                .domain(domain)
                .range([_cbright, _cdark])

        @mapTarget = (target, values) ->
            vals = angular.copy(values)
            _.map vals, (item) ->
               item.value = target
               item
        this

