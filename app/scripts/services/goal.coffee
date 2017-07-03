'use strict'

###*
 # @ngdoc service
 # @name dgsDash.goal
 # @description
 # # goal
 # Factory in the dgsDash.
###

angular.module 'dgsDash'
    .factory 'goal', ($resource, settings) ->
        $resource settings.API_ROOT_URL + "/goals/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
