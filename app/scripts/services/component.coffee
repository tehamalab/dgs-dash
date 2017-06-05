'use strict'

###*
 # @ngdoc service
 # @name sdgsDash.component
 # @description
 # # component
 # Factory in the sdgsDash.
###
angular.module 'sdgsDash'
    .factory 'component', ($resource, settings) ->
        $resource settings.API_ROOT_URL + "/components/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
