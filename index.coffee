# index.coffee
# It is a normal AMD/node module loader.
((define) ->
  define (require) ->
    Server = require './lib/server'
    Models = require './lib/models'

    # Helpler function, if connected, will be the default connection used by models.
    connect_to = (options)->
      @server = new Server options
      @server.connect()

    {
      Server : Server
      Models : Models

      connect: connect_to
    }

)(if typeof define == 'function' and define.amd then define else (factory) -> module.exports = factory(require);return )
