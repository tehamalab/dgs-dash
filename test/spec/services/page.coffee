'use strict'

describe 'Service: page', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  page = {}
  beforeEach inject (_page_) ->
    page = _page_

  it 'should do something', ->
    expect(!!page).toBe true
