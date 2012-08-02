exports.signup = (req, res) ->
  res.render 'user/signup'

exports.signin = (req, res) ->
  res.render 'user/signin'

exports.signout = (req, res) ->
  res.redirect '/'
