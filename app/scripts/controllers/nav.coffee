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

        goal.query {}, (data) ->
            $scope.goals = data

        return
