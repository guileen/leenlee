# exports all function from util
crypto = require 'crypto'

exports = module.exports = require 'util'

exports.merge = (dest, src) ->
  if dest and src
    for key of src
      dest[key] = src[key]
  dest

md5 = exports.md5 = (str, encoding = 'hex') ->
  crypto.createHash('md5').update(str).digest encoding

secrets = exports.secrets =
  random: (length = 5) ->
    md5(crypto.randomBytes(256)).substr 0, length

  crypt: (src) ->
    salt = secrets.random()
    salt + ':' + crypto.createHmac('sha256', salt).update(src).digest 'base64'

  equals: (src, dest) ->
    [salt, encoded] = dest.split ':'
    encoded is crypto.createHmac('sha256', salt).update(src).digest 'base64'

