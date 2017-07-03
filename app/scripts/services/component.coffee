'use strict'

###*
 # @ngdoc service
 # @name dgsDash.component
 # @description
 # # component
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'component', ($resource, settings) ->
        $resource settings.API_ROOT_URL + "/components/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
