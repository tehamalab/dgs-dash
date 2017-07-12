'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'MainCtrl', ($scope, $rootScope, lookup, goal) ->
        
        lookup.refresh()
        $scope.plan_code = 'sdgs'

        goal.query {plan_code: $scope.plan_code}, (data) ->
            $scope.goals = data
            $rootScope.title = "#{$rootScope.settings.SITE_NAME}"

        return
