exports.user = require './user'
exports.oa2 = require './oa2'

exports.index = (req, res) ->
  res.render 'index'
