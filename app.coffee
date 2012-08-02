express = require 'express'
http = require 'http'
path = require 'path'
routes = require './routes'

app = module.exports = express()

app.configure ->
  app.set 'views', path.join __dirname, 'views'
  app.set 'view engine', 'jade'
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router

app.configure 'development', ->
  app.use express.static path.join __dirname, 'public'
  app.use express.errorHandler()

app.get '/', routes.index
routes.user app

app.locals
  title: 'leenlee'
  DEBUG: 'production' isnt app.get 'env'

http.createServer(app).listen 3000, ->
  console.log 'Server listening ...'
