# models.coffee
((define) ->
  define (require) ->
    fs = require 'fs'
    path = require 'path'
    debug = require('debug')('mongo::model')

    When = require 'when'
    Server = require './server'

    #define functions here.
    class then_model
      constructor: (options = {})->
        # parse options

        # defaults
        @ns = options.name ? ""
        @server = options.server ? Server.server
        # try to do something.

      insert: (ops) ->
        When.promise (resolve, reject, notify)=>

      # Define a models loader.
      @model_cache : []
      @model_loader : (model_path, options = {})->
        #parse options
        force_reload = options.force_reload ? false
        cache_model = options.cache_model ? true

        # Just use the cache
        if cache_model and !force_reload and @model_cache[model_path]?
          When @model_cache[model_path]
          return

        When.promise (resolve, reject, notify)=>
          models = {}
          #selfname = path.basename __filename

          fs
            .readdirSync(model_path)
            .filter (file)->
              (file.indexOf('.') != 0) #&& (file != selfname)
            .forEach (file)->
              try
                model = require path.join model_path, file
                rpath = (model.modelName ? file.split('.')[0])
                models[rpath] = model
                notify "#{rpath} loaded"
              catch e
                notify "load #{file} failed"

          if cache_model
            @model_cache[model_path] = models

          resolve models

)(if typeof define == 'function' and define.amd then define else (factory) -> module.exports = factory(require);return )
