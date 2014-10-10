mongoose = require 'mongoose'

addToControlFlow = (webdriver, func) ->
  webdriver.waitForAngular()
  webdriver.controlFlow().execute func

mongoose.Query::schedule = (webdriver) ->
  addToControlFlow webdriver, @exec.bind @

mongoose.Model::scheduleCreate = (webdriver) ->
  addToControlFlow => @create.bind @
