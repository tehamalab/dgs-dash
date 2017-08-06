'use strict'

###*
 # @ngdoc service
 # @name dgsDash.common
 # @description
 # # common
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'common', ($http, areatype) ->
        self = this
        @areatypes = {}
        @geojson = {}

        @areatypesq = areatype.query {}, (data) ->
            self.areatypes = data
            if _.isEmpty(self.geojson)
                self.regionsq = $http.get(_.findWhere(self.areatypes.results, {code: 'region'}).topojson, {cache: true}).then (response) ->
                    self.geojson.region = topojson.feature(response.data, response.data.objects.region)
        this

