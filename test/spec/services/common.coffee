'use strict'

describe 'Service: common', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  common = {}
  beforeEach inject (_common_) ->
    common = _common_

  it 'should do something', ->
    expect(!!common).toBe true
