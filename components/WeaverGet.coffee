'use strict'

noflo = require 'noflo'

class WeaverGet extends noflo.AsyncComponent
  @weaver = null

  description: "Asynchronous getter from weaver"
  constructor: ->
    @inPorts =
      weaverid: new noflo.Port 'string'
      weaver: new noflo.Port 'object'
    @outPorts = weaverobject: new noflo.Port 'object'

    @inPorts['weaver'].on 'data', (data) =>
      @weaver = data

    super 'weaverid', 'weaverobject'

  doAsync: (weaverid, callback) ->
    port = @outPorts.weaverobject
    port.connect
    if @weaver?
      @weaver.get(weaverid, { eagerness: -1 }).then((p) ->
        port.beginGroup weaverid
        port.send p
        port.endGroup
        callback null
      )

exports.getComponent = -> new WeaverGet
