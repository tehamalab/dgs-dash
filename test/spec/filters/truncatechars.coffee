'use strict'

describe 'Filter: truncatechars', ->

  # load the filter's module
  beforeEach module 'dgsDash'

  # initialize a new instance of the filter before each test
  truncatechars = {}
  beforeEach inject ($filter) ->
    truncatechars = $filter 'truncatechars'

  it 'should return the input prefixed with "truncatechars filter:"', ->
    text = 'angularjs'
    expect(truncatechars text).toBe ('truncatechars filter: ' + text)
