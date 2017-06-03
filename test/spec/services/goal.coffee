'use strict'

describe 'Service: goal', ->

  # load the service's module
  beforeEach module 'sdgsDash'

  # instantiate service
  goal = {}
  beforeEach inject (_goal_) ->
    goal = _goal_

  it 'should do something', ->
    expect(!!goal).toBe true
