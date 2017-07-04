'use strict'

###*
 # @ngdoc service
 # @name dgsDash.search
 # @description
 # # search
 # Factory in the dgsDash.
###

angular.module 'dgsDash'
    .factory 'search', ($resource, settings) ->
        $resource settings.API_ROOT_URL + "/search/", {},
            query:
                method: "GET"
                isArray: false
                cache: true

