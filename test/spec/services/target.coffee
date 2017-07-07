'use strict'

describe 'Service: target', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  target = {}
  beforeEach inject (_target_) ->
    target = _target_

  it 'should do something', ->
    expect(!!target).toBe true
