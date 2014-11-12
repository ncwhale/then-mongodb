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

      # try to connect
      connect : ()->
        if @server.isConnected()
          #if already connected, just return this
          return When @

        When.promise (resolve, reject)=>
          # process functions for event callback.
          flush_event_binds = ()=>
            @server.removeListener 'connect', on_connect
            @server.removeListener 'error', on_error
            @server.removeListener 'parseError', on_error

          on_connect = ()=>
            flush_event_binds()
            resolve @
            return

          on_error = (err)=>
            flush_event_binds()
            reject err
            return

          # bind resolve/reject callback
          @server.once 'connect', on_connect
          @server.once 'error', on_error
          @server.once 'parseError', on_error

          # Ready for connect!
          @server.connect()

          return

      ###
       * Execute a command
       * @method
       * @param {string} ns The MongoDB fully qualified namespace (ex: db1.collection1)
       * @param {object} cmd The command hash
       * @param {ReadPreference} [options.readPreference] Specify read preference if command supports it
       * @param {Connection} [options.connection] Specify connection object to execute command against
       * @then {opResult}
      ###
      command : (ns, cmd, options)->
        When.promise (resolve, reject)=>
          callback = (err, result)=>
            if !err
              resolve result
            else
              reject err

          @server.command ns, cmd, options, callback

      ###
       * Insert one or more documents
       * @method
       * @param {string} ns The MongoDB fully qualified namespace (ex: db1.collection1)
       * @param {array} ops An array of documents to insert
       * @param {boolean} [options.ordered=true] Execute in order or out of order
       * @param {object} [options.writeConcern={}] Write concern for the operation
       * @then {opResult}
      ###
      insert : (ns, ops, options)->
        When.promise (resolve, reject)=>
          callback = (err, result)=>
            if !err
              resolve result
            else
              reject err

          @server.insert ns, ops, options, callback

      ###
       * Perform one or more update operations
       * @method
       * @param {string} ns The MongoDB fully qualified namespace (ex: db1.collection1)
       * @param {array} ops An array of updates
       * @param {boolean} [options.ordered=true] Execute in order or out of order
       * @param {object} [options.writeConcern={}] Write concern for the operation
       * @then {opResult}
      ###
      update : (ns, cmd, options)->
        When.promise (resolve, reject)=>
          callback = (err, result)=>
            if !err
              resolve result
            else
              reject err

          @server.update ns, cmd, options, callback

      ###
       * Perform one or more remove operations
       * @method
       * @param {string} ns The MongoDB fully qualified namespace (ex: db1.collection1)
       * @param {array} ops An array of removes
       * @param {boolean} [options.ordered=true] Execute in order or out of order
       * @param {object} [options.writeConcern={}] Write concern for the operation
       * @then {opResult}
      ###
      remove : (ns, cmd, options)->
        When.promise (resolve, reject)=>
          callback = (err, result)=>
            if !err
              resolve result
            else
              reject err

          @server.remove ns, cmd, options, callback

      ###
       * Perform one or more remove operations
       * @method
       * @param {string} ns The MongoDB fully qualified namespace (ex: db1.collection1)
       * @param {{object}|{Long}} cmd Can be either a command returning a cursor or a cursorId
       * @param {object} [options.batchSize=0] Batchsize for the operation
       * @param {array} [options.documents=[]] Initial documents list for cursor
       * @param {ReadPreference} [options.readPreference] Specify read preference if command supports it
       * @then {opResult}
      ###
      cursor : (ns, cmd, options)->
        When.promise (resolve, reject)=>
          callback = (err, result)=>
            if !err
              resolve result
            else
              reject err

          @server.cursor ns, cmd, options, callback

      ###
       * Destroy connect
      ###
      destroy : ()->
        # just at short cut.
        if @server.isConnected()
          # This is a sync call, so call it now.
          @server.destroy()

        When @

        ### Because it was a sync call, so no need to listen for events anymore.
        When.promise (resolve, reject)=>

          # process functions for event callback.
          flush_event_binds = ()=>
            @server.removeListener 'close', on_destroy
            @server.removeListener 'error', on_error
            @server.removeListener 'parseError', on_error

          on_destroy = ()=>
            flush_event_binds()
            resolve @
            return

          on_error = (err)=>
            flush_event_binds()
            reject err
            return


          #@server.once 'close', on_destroy
          @server.once 'error', on_error
          @server.once 'parseError', on_error

          # Ready for destroy!
          # TODO: Wait for mongo-core fix ISSUSE 03: https://github.com/christkv/mongodb-core/issues/3
          #@server.getConnection().destroy()

          # This is a sync call, so call it now and resolve after it.
          @server.destroy()
          resolve @
        ###

      # Just for indent.
      noop: ()->

)(if typeof define == 'function' and define.amd then define else (factory) -> module.exports = factory(require);return )
