'use strict'

###*
 # @ngdoc service
 # @name dgsDash.theme
 # @description
 # # theme
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'theme', ($resource, settings) ->

        $resource settings.API_ROOT_URL + "/themes/:id/", {},
            query:
                method: "GET"
                isArray: false
                cache: true
