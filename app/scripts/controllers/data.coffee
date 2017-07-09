'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:DataCtrl
 # @description
 # # DataCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'DataCtrl', ($rootScope) ->
        $rootScope.title = "#{$rootScope.settings.SITE_NAME} • Data"

