'use strict'

###*
 # @ngdoc function
 # @name sdgsDash.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the sdgsDash
###
angular.module 'sdgsDash'
    .controller 'MainCtrl', ($scope, goal) ->
        
        $scope.plan_code = 'sdgs'

        goal.query {plan_code: $scope.plan_code}, (data) ->
            $scope.goals = data

        return
