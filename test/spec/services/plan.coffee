'use strict'

describe 'Service: plan', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  plan = {}
  beforeEach inject (_plan_) ->
    plan = _plan_

  it 'should do something', ->
    expect(!!plan).toBe true
