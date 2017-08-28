'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:ThemeCtrl
 # @description
 # # ThemeCtrl
 # Controller of the dgsDash
###
angular.module 'dgsDash'
    .controller 'ThemeCtrl', ($scope, $routeParams, $location, $rootScope, $q, lookup, theme, sector, indicator) ->
        lookup.refresh()
        $scope.loading = true

        themeq = theme.query id: $routeParams.id, (data) ->
            $scope.theme = data
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • #{$scope.theme.name}"

        sectorsq = sector.query themes: $routeParams.id, (data) ->
            $scope.sectors = data

        indicatorsq = indicator.query theme: $routeParams.id, (data) ->
            $scope.indicators = data

        $q.all([
            themeq.$promise
            sectorsq.$promise
            indicatorsq.$promise
        ]).then ->
            # load additional indicator pages if they exist
            if $scope.indicators.next?
                _pages = Math.floor($scope.indicators.count / $scope.indicators.results.length)
                if $scope.indicators.count % $scope.indicators.results.length
                    _pages += 1
                    pages = []
                    angular.forEach [1..pages], (i) ->
                        if i > 0
                            pages.push(indicator.query({theme: $routeParams.id, page: i+1}).$promise)
                    $q.all(pages).then (data) ->
                        $scope.loading = false
                        $scope.indicators.next = null
                        $scope.indicators.pages = _pages
                        for page in data
                            $scope.indicators.results.push page.results...
            else
                $scope.loading = false
            return

        $scope.goto = (path) ->
            $location.path path

        return
