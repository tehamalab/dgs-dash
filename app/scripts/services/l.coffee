'use strict'

###*
 # @ngdoc service
 # @name dgsDash.L
 # @description
 # # L
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'L', ->

        L.TopoJSON = L.GeoJSON.extend(addData: (data) ->
            geojson = undefined
            key = undefined
            if data.type == 'Topology'
                for key of data.objects
                  `key = key`
                  if data.objects.hasOwnProperty(key)
                    geojson = topojson.feature(data, data.objects[key])
                    L.GeoJSON::addData.call this, geojson
                return this
            L.GeoJSON::addData.call this, data
            this
        )

        L.topoJSON = (data, options) ->
            new (L.TopoJSON)(data, options)

        return L

