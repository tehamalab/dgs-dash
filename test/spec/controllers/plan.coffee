'use strict'

describe 'Controller: PlanCtrl', ->

  # load the controller's module
  beforeEach module 'dgsDash'

  PlanCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    PlanCtrl = $controller 'PlanCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(PlanCtrl.awesomeThings.length).toBe 3
