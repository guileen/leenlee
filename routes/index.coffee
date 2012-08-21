exports.user = require './user'
exports.post = require './post'
exports.oauth = require './oauth'

exports.index = (req, res) ->
  res.render 'index'
