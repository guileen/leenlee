# exports all function from util
exports = module.exports = require 'util'

exports.merge = (dest, src) ->
  if dest and src
    for key of src
      dest[key] = src[key]
  dest

exports.md5 = (str, encoding) ->
  crypto.createHash("md5").update(str).digest encoding or "hex
