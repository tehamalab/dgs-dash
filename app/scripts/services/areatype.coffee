'use strict'

###*
 # @ngdoc service
 # @name dgsDash.areatype
 # @description
 # # areatype
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'areatype', ($resource, settings) ->
        $resource settings.API_ROOT_URL + "/areatypes/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
