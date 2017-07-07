'use strict'

###*
 # @ngdoc filter
 # @name dgsDash.filter:truncatechars
 # @function
 # @description
 # # truncatechars
 # Filter in the dgsDash.
###
angular.module 'dgsDash'
    .filter 'truncatechars', ($filter) ->
        (input, limit, truncator) ->
            if limit? and input.length > limit
                truncator = '...' unless truncator?
                return $filter('limitTo')(input, limit) + truncator
            return $filter('limitTo')(input, limit)
