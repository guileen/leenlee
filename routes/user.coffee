module.exports = (app) ->

  app.get '/user/signup', (req, res) ->
    res.render 'user/signup'

  app.get '/user/signin', (req, res) ->
    res.render 'user/signin'

  app.get '/user/signout', (req, res) ->
    res.redirect '/'
