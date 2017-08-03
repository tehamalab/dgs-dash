'use strict'

describe 'Filter: shortnumber', ->

  # load the filter's module
  beforeEach module 'dgsDash'

  # initialize a new instance of the filter before each test
  shortnumber = {}
  beforeEach inject ($filter) ->
    shortnumber = $filter 'shortnumber'

  it 'should return the input prefixed with "shortnumber filter:"', ->
    text = 'angularjs'
    expect(shortnumber text).toBe ('shortnumber filter: ' + text)
