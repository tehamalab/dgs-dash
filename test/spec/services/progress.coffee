'use strict'

describe 'Service: progress', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  progress = {}
  beforeEach inject (_progress_) ->
    progress = _progress_

  it 'should do something', ->
    expect(!!progress).toBe true
