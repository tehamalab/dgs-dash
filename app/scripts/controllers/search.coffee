'use strict'

###*
 # @ngdoc function
 # @name dgsDash.controller:SearchCtrl
 # @description
 # # SearchCtrl
 # Controller of the dgsDash
###

angular.module 'dgsDash'
    .controller 'SearchCtrl', ($scope, $routeParams, $location, $rootScope, page, search, lookup) ->

        init = ->
            page.current.plan_id = null
            $scope.lookup = lookup
            $scope.data = {}
            $scope.facets = {}
            $scope.loading = false
            $scope.loadingMore = false
            $rootScope.title = "#{$rootScope.settings.SITE_NAME} • Search"
            $scope.GOAL = 'goal'
            $scope.TARGET = 'target'
            $scope.INDICATOR = 'indicator'
            $scope.COMPONENT = 'component'
            $scope.objectUrls =
                plan: 'plans'
                theme: 'themes'
                goal: 'goals'
                sector: 'sectors'
                target: 'targets'
                indicator: 'indicators'
                component: 'components'
            $scope.objectTypeLabels =
                plan: 'Plans'
                theme: 'Themes'
                goal: 'Goals'
                sector: 'Sectors/Sub-sectors'
                target: 'Targets'
                indicator: 'Indicators'

            if _.isEmpty(lookup.search)
                lookup.search = $location.search()
            else
                $location.search(lookup.search)

        query = ->
            $scope.loading = true
            search.query lookup.search, (data) ->
                $scope.loading = false
                if isLoadingMore()
                    $scope.data.results.push.apply($scope.data.results, data.results)
                    $scope.data.next = data.next
                    $scope.data.previous = data.previous
                    $scope.loadingMore = false
                else
                    $scope.data = data
                    $scope.facets.object_type = _.object($scope.data.facets.fields.object_type)

        $scope.update = (params, append) ->
            if params?
                _.extendOwn lookup.search, params
            if not append
                delete lookup.search.page
                $location.search lookup.search
                $scope.loadingMore = false

        $scope.refresh = (params) ->
            lookup.search = {}
            $scope.update(params)

        $scope.loadMore = () ->
            if $scope.data? and $scope.data.next? and not $scope.loading
                if lookup.search.page?
                    lookup.search.page += 1
                else
                    lookup.search.page = 2
                $scope.loadingMore = true
                $scope.update({}, true)
                query()

        $scope.objectUrl = (_type, args) ->
            if _.has($scope.objectUrls, _type)
                return "/#{$scope.objectUrls[_type]}/#{args.join('/')}"
            else
                return ''

        $scope.goto_object = (_type, args) ->
            path = $scope.objectUrl(_type, args)
            if path 
                $location.url path

        isLoadingMore = () ->
            return $scope.data? and $scope.data.results? and lookup.search.page? and lookup.search.page > 1

        $scope.$watch 'lookup.search.q', (newValue, oldValue) ->
            if (newValue and newValue.length >= 3) or newValue is ''
                delete lookup.search.page
                $location.search(lookup.search)
                console.log search
                query()
        , true

        $scope.$on '$locationChangeStart', (event) ->
            lookup.refreshSearch()

        init()
        query()
        return
