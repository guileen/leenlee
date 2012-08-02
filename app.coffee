kick = require 'kick'
connect = require 'connect'
jade = require 'jade'
http = require 'http'
path = require 'path'
routes = require './routes'

app = module.exports = kick()

app.configure ->
  app.use connect.cookieParser()

app.configure 'development', ->
  app.use connect.static path.join __dirname, 'public'

app.render = (name, options, callback) ->
  options.cache = true unless options.cache?
  jade.renderFile path.join(__dirname, 'views', name + '.jade'), options, callback

app.get '/', routes.index

app.locals =
  title: 'leenlee'

http.createServer(app).listen 3000, ->
  console.log 'Server listening ...'
