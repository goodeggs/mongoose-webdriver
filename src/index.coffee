module.exports = (mongoose, globalWebdriver) ->

  addToControlFlow = (webdriver, func) ->
    webdriver.waitForAngular?()
    webdriver.controlFlow().execute func

  mongoose.Query::schedule = (webdriver = globalWebdriver) ->
    addToControlFlow webdriver, @exec.bind @

  mongoose.Model.scheduleCreate = (doc, webdriver = globalWebdriver) ->
    addToControlFlow webdriver, @create.bind @, doc

  mongoose.Model.prototype.scheduleSave = (webdriver = globalWebdriver) ->
    Promise = require('mongoose/node_modules/mpromise')

    savePromise = ->
      promise = new Promise
      @save (err, res) ->
        promise.resolve err, res
      promise

    addToControlFlow webdriver, savePromise.bind @
