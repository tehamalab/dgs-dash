'use strict'

describe 'Controller: DataCtrl', ->

  # load the controller's module
  beforeEach module 'dgsDash'

  DataCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DataCtrl = $controller 'DataCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(DataCtrl.awesomeThings.length).toBe 3
