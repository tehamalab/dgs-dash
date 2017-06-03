'use strict'

describe 'Service: settings', ->

  # load the service's module
  beforeEach module 'sdgsDash'

  # instantiate service
  settings = {}
  beforeEach inject (_settings_) ->
    settings = _settings_

  it 'should do something', ->
    expect(!!settings).toBe true
