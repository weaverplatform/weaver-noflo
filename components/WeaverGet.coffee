'use strict'

noflo = require 'noflo'
weaver = require('../lib/WeaverComponent.coffee').weaver

class WeaverGet extends noflo.AsyncComponent
  description: "Asynchronous getter from weaver"
  constructor: ->
    @inPorts = weaverid: new noflo.Port 'string'
    @outPorts = weaverobject: new noflo.Port 'object'
    super 'weaverid', 'weaverobject'

  doAsync: (weaverid, callback) ->
    port = @outPorts.weaverobject
    port.connect
    weaver.get(weaverid, { eagerness: -1 }).then((p) -> 
      port.beginGroup weaverid
      port.send p
      port.endGroup
      callback null
    )

exports.getComponent = -> new WeaverGet
