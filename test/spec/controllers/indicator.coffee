'use strict'

describe 'Controller: IndicatorCtrl', ->

  # load the controller's module
  beforeEach module 'sdgsDash'

  IndicatorCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    IndicatorCtrl = $controller 'IndicatorCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(IndicatorCtrl.awesomeThings.length).toBe 3
