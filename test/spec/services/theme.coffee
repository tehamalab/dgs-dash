'use strict'

describe 'Service: theme', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  theme = {}
  beforeEach inject (_theme_) ->
    theme = _theme_

  it 'should do something', ->
    expect(!!theme).toBe true
