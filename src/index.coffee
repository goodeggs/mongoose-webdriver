module.exports = (mongoose, globalWebdriver) ->

  addToControlFlow = (webdriver, func) ->
    webdriver.waitForAngular?()
    webdriver.controlFlow().execute func

  mongoose.Query::schedule = (webdriver = globalWebdriver) ->
    addToControlFlow webdriver, @exec.bind @

  mongoose.Model::scheduleCreate = (webdriver = globalWebdriver) ->
    addToControlFlow webdriver, @create.bind @
