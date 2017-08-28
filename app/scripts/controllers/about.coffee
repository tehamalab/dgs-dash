'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'AboutCtrl', ($rootScope, $scope, plan, lookup) ->
        lookup.refresh()
        $scope.loading = true
        $rootScope.title = "#{$rootScope.settings.SITE_NAME} • About"

        plan.query {}, (data) ->
            $scope.loading = false
            $scope.plans = data
