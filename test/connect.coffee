util = require 'util'
assert = require 'assert'

M = require '../'

describe 'then-mongodb', ()->
  describe 'connect function', ()->
    it 'should return a server obj after connect', (done)->
      assert.equal 'function', typeof M.connect

      promise = M.connect()

      assert.equal 'function', typeof  promise.then

      promise.done (s)->
        assert s instanceof M.Server
        assert.equal s, M.server
        assert M.server.server.isConnected()
        done()

      , (err)->
        assert M.server instanceof M.server
        assert !M.server.server.isConnected()
        done(err)

    it 'should close server connection after destroy', (done)->
      M.connect().then (server)->
        assert server.server.isConnected()
        M.destroy().then ()->
          assert !server.server.isConnected()
          done()
      .catch done
