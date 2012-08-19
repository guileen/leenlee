exports.user = require './user'
exports.topic = require './topic'
exports.oauth = require './oauth'

exports.index = (req, res) ->
  res.render 'index'
