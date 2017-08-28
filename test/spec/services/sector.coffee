'use strict'

describe 'Service: sector', ->

  # load the service's module
  beforeEach module 'dgsDash'

  # instantiate service
  sector = {}
  beforeEach inject (_sector_) ->
    sector = _sector_

  it 'should do something', ->
    expect(!!sector).toBe true
