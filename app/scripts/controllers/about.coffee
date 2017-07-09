'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'AboutCtrl', ($rootScope) ->
        $rootScope.title = "#{$rootScope.settings.SITE_NAME} • About"
