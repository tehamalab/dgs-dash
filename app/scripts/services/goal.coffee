'use strict'

###*
 # @ngdoc service
 # @name sdgsDash.goal
 # @description
 # # goal
 # Factory in the sdgsDash.
###

angular.module 'sdgsDash'
    .factory 'goal', ($resource, settings) ->
        $resource settings.API_ROOT_URL + "/goals/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
