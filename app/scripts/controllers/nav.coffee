'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:NavCtrl
 # @description
 # # NavCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'NavCtrl', ($scope, $location, goal, lookup) ->
        lookup.search = {}
        $scope.lookup = lookup
        $scope.plan_code = 'sdgs'

        goal.query {plan_code: $scope.plan_code}, (data) ->
            $scope.goals = data

        $scope.search = ->
            $location.url('/search')

        $scope.$watch 'lookup.search.q', (newValue, oldValue) ->
            if newValue
                if !$location.path().startsWith('/search') and newValue.length > 3
                    $scope.search()

        return
