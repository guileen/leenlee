# base.coffee

L = this.L =
  on: (event, listener)->
    listeners = L.listeners[event] or= []
    listeners.push listener

  emit: (event, args...) ->
    listeners = L.listeners[event]
    listener args... for listener in listeners if listeners

  pages: {}

  listeners: {}

rest = L.rest = new RestClient()
# models
m = L.models = {}

_cache = {}
cache = L.cache =
  get: (key) ->
    return _cache[key]
  set: (key, val) ->
    _cache[key] = val

# TODO write a cacheRestclient
cacheRest = L.cacheRest = rest

m.user =
  get: (uid, fn) ->
    cacheRest.get '/user/' + uid, (err, user) ->
      cache.set uid, user
      fn err, user
