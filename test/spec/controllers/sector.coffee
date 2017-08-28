'use strict'

describe 'Controller: SectorCtrl', ->

  # load the controller's module
  beforeEach module 'dgsDash'

  SectorCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    SectorCtrl = $controller 'SectorCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(SectorCtrl.awesomeThings.length).toBe 3
