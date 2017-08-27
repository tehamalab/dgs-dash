'use strict'

###*
 # @ngdoc service
 # @name dgsDash.plan
 # @description
 # # plan
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'plan', ($resource, settings) ->

        $resource settings.API_ROOT_URL + "/plans/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
