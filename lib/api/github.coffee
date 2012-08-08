BaseAPI = require './base'

class Github extends BaseAPI

  base_url : 'https://api.github.com'

  me: (callback) ->
    @get '/user', callback

module.exports = Github
