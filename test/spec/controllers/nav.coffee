'use strict'

describe 'Controller: NavCtrl', ->

  # load the controller's module
  beforeEach module 'sdgsDash'

  NavCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    NavCtrl = $controller 'NavCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(NavCtrl.awesomeThings.length).toBe 3
