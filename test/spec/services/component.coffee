'use strict'

describe 'Service: component', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  component = {}
  beforeEach inject (_component_) ->
    component = _component_

  it 'should do something', ->
    expect(!!component).toBe true
