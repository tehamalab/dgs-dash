'use strict'

###*
 # @ngdoc service
 # @name dgsDash.progress
 # @description
 # # progress
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'progress', ($resource, settings, lookup) ->

        $resource settings.API_ROOT_URL + "/progress/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
