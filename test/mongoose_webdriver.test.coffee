bootstrap = require '..'
{expect} = require 'chai'

mongoose = require 'mongoose'
wd = require 'selenium-webdriver'
Hapi = require 'hapi'

PORT = process.env.PORT or 12498

{Incrementer} = {}

# set up model
before (done) ->
  mongoose.connect 'mongodb://localhost/test', done
  Incrementer = mongoose.model 'Incrementer', mongoose.Schema
    slug: String
    counter: Number

# set up server
before (done) ->
  server = new Hapi.Server PORT
  server.route
    method: 'POST'
    path: '/incrementers/{slug}/bump'
    handler: (request, reply) ->
      Incrementer.findOneAndUpdate({slug: request.params.slug}, {$inc: counter: 1}).exec().then ->
        reply('done!')

  server.route
    method: 'GET'
    path: '/incrementers/{slug}'
    handler: (request, reply) ->
      reply """
        <html>
          <form action='/incrementers/#{request.params.slug}/bump' method="POST">
            <input type='submit' value="Bump" class='increment'>
          </form>
        </html>
      """
  server.start done

# start webdriver and hook up mongoose-webdriver
before ->
  @driver = (new wd.Builder())
    .withCapabilities(wd.Capabilities.chrome())
    .build()

  bootstrap(mongoose, @driver)

# close webdriver session
after ->
  @driver.quit()

describe 'mongoose-webdriver', ->
  it 'works', ->
    @timeout 30000

    @driver.get "http://localhost:#{PORT}/incrementers/example-route"

    Incrementer.remove().schedule()
    Incrementer.scheduleCreate slug: 'example-route', counter: 1

    @driver.findElement(wd.By.css('input.increment')).click()
    @driver.wait => @driver.getCurrentUrl().then((url) -> url is "http://localhost:#{PORT}/incrementers/example-route/bump")
    Incrementer.findOne({slug: 'example-route'}).schedule().then (incrementer) ->
      expect(incrementer).to.have.property 'counter', 2
