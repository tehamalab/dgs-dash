'use strict'

###*
 # @ngdoc service
 # @name sdgsDash.indicator
 # @description
 # # indicator
 # Factory in the sdgsDash.
###
angular.module 'sdgsDash'
    .factory 'indicator', ($resource, settings) ->
        $resource settings.API_ROOT_URL + "/indicators/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true

