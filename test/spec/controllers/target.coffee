'use strict'

describe 'Controller: TargetCtrl', ->

  # load the controller's module
  beforeEach module 'dgsDash'

  TargetCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    TargetCtrl = $controller 'TargetCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(TargetCtrl.awesomeThings.length).toBe 3
