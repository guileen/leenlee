express = require 'express'
http = require 'http'
path = require 'path'
redis = require 'redis'
routes = require './routes'

app = module.exports = express()

db = redis.createClient()
db.select 1

app.configure ->
  app.set 'port', process.env.PORT or 3000
  app.set 'views', path.join __dirname, 'views'
  app.set 'view engine', 'jade'
  app.set 'db', db
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router

app.configure 'development', ->
  app.set 'view options', pretty: true
  app.use express.static path.join __dirname, 'public'
  app.use express.errorHandler()

app.get '/', routes.index
routes.user app
routes.oauth app

app.locals
  title: 'leenlee'
  DEBUG: 'production' isnt app.get 'env'

http.createServer(app).listen app.get('port'), ->
  console.log 'Server listening %s', app.get 'port'
