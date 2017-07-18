'use strict'

describe 'Service: areatype', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  areatype = {}
  beforeEach inject (_areatype_) ->
    areatype = _areatype_

  it 'should do something', ->
    expect(!!areatype).toBe true
