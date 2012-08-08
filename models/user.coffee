module.exports = (db) ->

  class User
    isValidPassword: (password) ->
      false

  User.find = (args, fn) ->
    db.keys '*', fn
    #fn(null, new User)

  User
