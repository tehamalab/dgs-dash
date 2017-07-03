'use strict'

describe 'Controller: GoalCtrl', ->

  # load the controller's module
  beforeEach module 'dgsDash'

  GoalCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    GoalCtrl = $controller 'GoalCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(GoalCtrl.awesomeThings.length).toBe 3
