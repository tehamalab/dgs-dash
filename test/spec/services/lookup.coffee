'use strict'

describe 'Service: lookup', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  lookup = {}
  beforeEach inject (_lookup_) ->
    lookup = _lookup_

  it 'should do something', ->
    expect(!!lookup).toBe true
