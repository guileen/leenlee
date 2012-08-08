module.exports = (app) ->
  User = (require '../models/user') app.get 'db'

  app.get '/user/signup', (req, res) ->
    #user = new User(app.get 'db')
    #User.find 'shaun', () ->
    #  console.log arguments
    res.render 'user/signup'

  app.post '/user/signup', (req, res) ->
    console.log req.body
    res.json {ok: true}

  app.get '/user/signin', (req, res) ->
    res.render 'user/signin'

  app.get '/user/signout', (req, res) ->
    res.redirect '/'
