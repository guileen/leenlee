module.exports = (app) ->
  User = (require '../models/user') app.get 'db'

  app.post '/user/valid/username', (req, res) ->
    User.existsUsername req.body.User.username, (exists) ->
      res.json !exists

  app.post '/user/valid/email', (req, res) ->
    User.existsEmail req.body.User.email, (exists) ->
      res.json !exists

  app.get '/user/signup', (req, res) ->
    res.render 'user/signup'

  app.post '/user/signup', (req, res) ->
    User.create req.body.User, (user) ->
      res.json user

  app.get '/user/signin', (req, res) ->
    res.render 'user/signin'

  app.post '/user/signin', (req, res) ->
    console.log req.body
    res.json false

  app.get '/user/signout', (req, res) ->
    res.redirect '/'
