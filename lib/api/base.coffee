OAuth2 = require('oauth').OAuth2
join = require('path').join
qs = require 'querystring'

class BaseAPI

  constructor: (@accessToken) ->
    @oauth = new OAuth2

  ###
  options:
    headers
    query
    body
  ###
  request: (method, api, options, callback)->
    url = @base_url + api
    url += qs.stringify options.query if options.query
    @oauth._request method, url, options.headers or {}, options.body or '', @accessToken, (err, result, res)->
      callback err, result and JSON.parse result, res

  get: (api, query, callback) ->
    unless callback
      callback = query
      query = null
    @request 'GET', api, query: query, callback

  post: (api, body, callback) ->
    unless callback
      callback = body
      body = ''
    @request 'POST', api, body: body, callback



module.exports = BaseAPI
