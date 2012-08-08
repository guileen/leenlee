exports.user = require './user'
exports.oauth = require './oauth'

exports.index = (req, res) ->
  res.render 'index'
