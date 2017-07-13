'use strict'

describe 'Controller: ComponentCtrl', ->

  # load the controller's module
  beforeEach module 'dgsDash'

  ComponentCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ComponentCtrl = $controller 'ComponentCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(ComponentCtrl.awesomeThings.length).toBe 3
