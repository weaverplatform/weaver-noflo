'use strict'

noflo = require 'noflo'
Weaver = require 'weaver-sdk'

weaver = new Weaver
weaver.connect 'https://weaver-server.herokuapp.com'

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

exports.getComponent = -> new AsyncGet

