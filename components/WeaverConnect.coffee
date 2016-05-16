'use strict'

noflo = require 'noflo'
Weaver = require 'weaver-sdk'

exports.getComponent = ->
  component = new noflo.Component
  component.description = "Connects to a weaver server"

  component.inPorts.add 'address', datatype: 'string', (event, payload) ->
    return unless event is 'data'
    weaver = new Weaver
    weaver.connect payload
    component.outPorts.out.send weaver
  
  component.outPorts.add 'out', datatype: 'object'

  component

