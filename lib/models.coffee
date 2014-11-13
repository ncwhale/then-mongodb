# models.coffee
# Define a models loader.
# With normal connect
((define) ->
  define (require) ->
    When = require 'when'
    fs = require 'fs'
    path = require 'path'
    debug = require('debug')('mongo::model')

    #define functions here.
    class then_model
      constructor: (options = {})->
        # parse options
        @
        # try to do something.
        #When.promise (resolve, reject, notify)->


    model_loader = (model_path)->
      models = {}
      selfname = path.basename __filename

      fs
        .readdirSync(model_path)
        .filter (file)->
          (file.indexOf('.') != 0) && (file != selfname)
        .forEach (file)->
          try
            model = require path.join model_path, file
            rpath = (model.modelName ? file.split('.')[0])
            models[rpath] = model
            debug "Loaded model: #{rpath}"
          catch e
            debug "Model load error: #{e}"

      #return
      models

    { #export module
      Model: then_model
      loader: model_loader
    }

)(if typeof define == 'function' and define.amd then define else (factory) -> module.exports = factory(require);return )
