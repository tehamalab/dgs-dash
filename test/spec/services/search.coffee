'use strict'

describe 'Service: search', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  search = {}
  beforeEach inject (_search_) ->
    search = _search_

  it 'should do something', ->
    expect(!!search).toBe true
