'use strict'

###*
 # @ngdoc service
 # @name dgsDash.target
 # @description
 # # target
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'target', ($resource, settings, lookup) ->

        $resource settings.API_ROOT_URL + "/targets/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
