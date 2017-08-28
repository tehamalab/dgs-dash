'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:SectorCtrl
 # @description
 # # SectorCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'SectorCtrl', ($routeParams, $rootScope, $scope, $q, lookup, sector, indicator) ->
        lookup.refresh()
        $scope.loading = true

        sectorq = sector.query id: $routeParams.id, (_sector) ->
            $scope.sector = _sector
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • #{$scope.sector.name}"
            sector.query themes: $scope.sector.themes, (_sectors) ->
                $scope.sectors = _sectors

        indicatorsq = indicator.query sectors_ids: $routeParams.id, (data) ->
            $scope.indicators = data

        $q.all([
            sectorq.$promise
            indicatorsq.$promise
        ]).then ->
            $scope.loading = false
            return

        return
