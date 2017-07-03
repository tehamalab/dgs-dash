'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:NavCtrl
 # @description
 # # NavCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'NavCtrl', ($scope, goal) ->

        $scope.plan_code = 'sdgs'

        goal.query {plan_code: $scope.plan_code}, (data) ->
            $scope.goals = data

        return
