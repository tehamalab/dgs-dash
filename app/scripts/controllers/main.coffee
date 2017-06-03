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

        goal.query {}, (data) ->
            $scope.goals = data

        return
