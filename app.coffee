express = require 'express'
http = require 'http'
path = require 'path'
redis = require 'redis'
routes = require './routes'

app = module.exports = express()

db = redis.createClient()
db.select 1

app.configure 'development', ->
  app.use express.favicon()
  app.use express.logger 'dev'

app.configure ->
  app.set 'port', process.env.PORT or 3000
  app.set 'views', path.join __dirname, 'views'
  app.set 'view engine', 'jade'
  app.set 'db', db
  app.use express.cookieParser 'sexy girl'
  app.use express.bodyParser()
  app.use express.session()
  app.use express.methodOverride()
  app.use app.router

app.configure 'development', ->
  compiler = require 'connect-compiler'
  app.locals pretty: true
  # app.use require('less-middleware')  src: __dirname + '/public'
  app.use compiler roots: {'src': 'dest'}, enabled: ['coffee', 'less'], log_level: 'WARN'
  app.use express.static path.join __dirname, 'public'
  app.use express.static path.join __dirname, 'dest'
  app.use express.errorHandler()

app.get '/', routes.index
routes.user app
routes.oauth app

app.locals
  title: 'leenlee'
  DEBUG: 'production' isnt app.get 'env'

http.createServer(app).listen app.get('port'), ->
  console.log 'Server listening %s', app.get 'port'
