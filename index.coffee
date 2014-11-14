# index.coffee
# It is a normal AMD/node module loader.
((define) ->
  define (require) ->
    When = require 'when'
    Server = require './lib/server'
    Model = require './lib/model'


    # Helpler function, if connected, will be the default connection used by models.

    {
      Server : Server
      Model : Model.Model #WTF!

      connect: connect_to
      destroy: destroy_connect
      load_model: Model.loader
    }

)(if typeof define == 'function' and define.amd then define else (factory) -> module.exports = factory(require);return )
