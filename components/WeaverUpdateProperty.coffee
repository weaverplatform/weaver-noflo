'use strict'

noflo = require 'noflo'

class WeaverUpdateProperty extends noflo.AsyncComponent
  @propertyName = null
  @propertyValue = null

  description: "Asynchronous updater for weaver objects"
  constructor: ->
    console.log "constructor called"
    @inPorts = 
      updateobject: new noflo.Port 'object'
      propertyname: new noflo.Port 'string'
      propertyvalue: new noflo.Port 'string'

    @outPorts = 
      out: new noflo.Port 'boolean'

    @inPorts['propertyname'].on 'data', (data) =>
      @propertyName = data

    @inPorts['propertyvalue'].on 'data', (data) =>
      @propertyValue = data

    console.log "Going to call super"
    super 'updateobject'
    console.log "Constructor finished"

  doAsync: (updateobject, callback) ->
    updateobject.$push(@propertyName, @propertyValue)
    @outPorts.out.connect
    @outPorts.out.beginGroup updateobject
    @outPorts.out.send true
    @outPorts.out.endGroup

    callback null

exports.getComponent = -> new WeaverUpdateProperty
