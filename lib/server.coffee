# index.coffee
# It is a normal AMD/node module loader.
((define) ->
  define (require) ->
    Mongo = require 'mongodb-core'
    When = require 'when'

    #define functions here.
    class then_server 
      constructor: (options = {})->
        # if we got a real Server, we warp it.
        if options instanceof Mongo.Server
          @server = options
        else
          # parse options

          # default values
          options.host ?= 'localhost'
          options.port ?= 27017

          # this is the real server we use.
          @server = new Mongo.Server options

      connect : ()->
        # try to connect
        When.promise (resolve, reject)=>
          if @server.isConnected()
            #if already connected, just return this
            resolve @
          else
            # process functions for event callback.
            flush_event_binds = ()=>
              @server.removeEventListener 'connect', on_connect
              @server.removeEventListener 'error', on_error
              @server.removeEventListener 'parseError', on_error

            on_connect = () =>
              flush_event_binds()
              resolve @
              return

            on_error = (err)=>
              flush_event_binds()
              reject err
              return

            # for resolve/reject callback
            @server.once 'connect', on_connect
            @server.once 'error', on_error
            @server.once 'parseError', on_error

            # Ready for connect!
            @server.connect()

          #@server.on 'close', ()=> notify 'close'; return
          #@server.on 'reconnect', ()=> notify 'reconnect'; return
          #@server.on 'timeout', ()=> notify 'timeout'; return

)(if typeof define == 'function' and define.amd then define else (factory) -> module.exports = factory(require);return )
