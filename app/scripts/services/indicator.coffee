'use strict'

###*
 # @ngdoc service
 # @name dgsDash.indicator
 # @description
 # # indicator
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'indicator', ($resource, settings) ->
        $resource settings.API_ROOT_URL + "/indicators/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true

