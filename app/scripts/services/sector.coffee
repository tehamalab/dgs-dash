'use strict'

###*
 # @ngdoc service
 # @name dgsDash.sector
 # @description
 # # sector
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'sector', ($resource, settings, lookup) ->

        $resource settings.API_ROOT_URL + "/sectors/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
