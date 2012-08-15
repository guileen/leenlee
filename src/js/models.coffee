# models.coffee

L.setUser = (user) ->
  L.user = user

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
