# index.coffee
# It is a normal AMD/node module loader.
((define) ->
  define (require) ->
    When = require 'when'
    Server = require './lib/server'
    Models = require './lib/models'


    # Helpler function, if connected, will be the default connection used by models.
    connect_to = (options)->
      @server?.destroy?() # I need a cup of coffee!
      @server = new Server options
      @server.connect()

    destroy_connect = ()->
      @server?.destroy?() ? When true # I need more coffee!

    {
      Server : Server
      Models : Models

      connect: connect_to
      destroy: destroy_connect
    }

)(if typeof define == 'function' and define.amd then define else (factory) -> module.exports = factory(require);return )
