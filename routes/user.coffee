module.exports = (app) ->

  app.post '/signup', (req, res) ->
    res.render 'user/signup'

  app.post '/signin', (req, res) ->
    res.render 'user/signin'

  app.get '/signout', (req, res) ->
    res.redirect '/'
