exports.requireLogin = (req, res, next) ->
  return next() if req.session.user
  if req.xhr
    res.json ret: -1, msg: 'require login', 403
  else
    res.statusCode = 403
    res.render '/403'
