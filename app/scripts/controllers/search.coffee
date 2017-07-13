'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:SearchCtrl
 # @description
 # # SearchCtrl
 # Controller of the dgsDash
###

angular.module 'dgsDash'
    .controller 'SearchCtrl', ($scope, $routeParams, $location, $rootScope, search, lookup) ->

        init = ->
            $scope.lookup = lookup
            $scope.data = {}
            $scope.facets = {}
            $scope.loading = false
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • Search"
            $scope.object_urls =
                goal: 'goals'
                indicator: 'indicators'

            if _.isEmpty(lookup.search)
                lookup.search = $location.search()
            else
                $location.search(lookup.search)

        query = ->
            $scope.loading = true
            search.query lookup.search, (data) ->
                $scope.loading = false
                $scope.data = data
                $scope.facets.object_type = _.object($scope.data.facets.fields.object_type)

        $scope.update = (params) ->
            if params?
                _.extendOwn lookup.search, params
            query()
            $location.search(lookup.search)

        $scope.refresh = (params) ->
            lookup.search = {}
            $scope.update(params)

        $scope.object_url = (_type, args) ->
            if _.has($scope.object_urls, _type) 
                return "/#{$scope.object_urls[_type]}/#{args.join('/')}"
            else
                return ''


        $scope.goto_object = (_type, args) ->
            path = $scope.object_url(_type, args)
            if path 
                $location.url path

        $scope.$watch 'lookup.search.q', (newValue, oldValue) ->
            if newValue.length > 3 or newValue.length is 0
                query()
                $location.search(lookup.search)
        , true

        init()
        query()
        return
