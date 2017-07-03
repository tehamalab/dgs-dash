'use strict'

describe 'Service: indicator', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  indicator = {}
  beforeEach inject (_indicator_) ->
    indicator = _indicator_

  it 'should do something', ->
    expect(!!indicator).toBe true
