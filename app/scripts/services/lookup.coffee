'use strict'

###*
 # @ngdoc service
 # @name dgsDash.lookup
 # @description
 # # lookup
 # Factory in the dgsDash.
###

angular.module 'dgsDash'
    .factory 'lookup', ->

        @defaults =
            search: {}

        @search = angular.copy @defaults.search

        @refreshSearch = () ->
            @search = angular.copy @defaults.search

        @refresh = () ->
            @refreshSearch()

        return this
