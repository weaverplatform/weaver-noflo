noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  WeaverGet = require '../components/WeaverGet.coffee'
else
  WeaverGet = require 'noflo-weaver/components/WeaverGet.js'

describe 'WeaverGet component', ->
  c = null
  ins = null
  out = null
  beforeEach ->
    c = WeaverGet.getComponent()
    ins = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.weaverid.attach ins
    c.outPorts.weaverobject.attach out

  describe 'when instantiated', ->
    it 'should have an input port', ->
      chai.expect(c.inPorts.weaverid).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.weaverobject).to.be.an 'object'
