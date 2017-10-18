'use strict'

###*
 # @ngdoc service
 # @name dgsDash.page
 # @description
 # # page
 # Factory in the dgsDash.
###
angular.module 'dgsDash'
    .factory 'page', ->
        @current = {}
        return this
