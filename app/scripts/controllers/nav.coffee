'use strict'

###*
 # @ngdoc function
 # @name sdgsDash.controller:NavCtrl
 # @description
 # # NavCtrl
 # Controller of the sdgsDash
###
angular.module 'sdgsDash'
    .controller 'NavCtrl', ($scope, goal) ->

        $scope.plan_code = 'sdgs'

        goal.query {plan_code: $scope.plan_code}, (data) ->
            $scope.goals = data

        return
