# models.coffee
# Define a standalone object for manage data models loaded.
# With normal connect
((define) ->
  define (require) ->
    When = require 'when'

    #define functions here.
    class then_models
      constructor: (options...)->
        # parse options

        # try to do something.
        When.promise (resolve, reject, notify)->


)(if typeof define == 'function' and define.amd then define else (factory) -> module.exports = factory(require);return )
