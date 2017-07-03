'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'MainCtrl', ($scope, goal) ->
        
        $scope.plan_code = 'sdgs'

        goal.query {plan_code: $scope.plan_code}, (data) ->
            $scope.goals = data

        return
