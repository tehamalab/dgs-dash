'use strict'

describe 'Controller: ThemeCtrl', ->

  # load the controller's module
  beforeEach module 'dgsDash'

  ThemeCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ThemeCtrl = $controller 'ThemeCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(ThemeCtrl.awesomeThings.length).toBe 3
