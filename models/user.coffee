USERNAME_ = 'user:username:'
EMAIL_ = 'user:email:'
UID_ = 'user:'
NEXT_UID = '_:user:nextid'
USERS = '_:users'

module.exports = (db) ->
  utils = require '../lib/utils'

  User =
    existsUsername: (username, fn) ->
      db.get USERNAME_ + username, fn

    existsEmail: (email, fn) ->
      db.get EMAIL_ + email, fn

    create: (attributes, fn) ->
      db.incr NEXT_UID, (err, uid) ->
        return fn err if err
        schema =
          id: uid
          username: ''
          password: ''
          email: ''
          created_at: +new Date,
          logged_at: +new Date,
          has_avatar: false
        user = utils.merge schema, attributes
        user.password = utils.secrets.crypt user.password
        db.multi()
          .set(USERNAME_ + user.username, uid)
          .set(EMAIL_ + user.email, uid)
          .zadd(USERS, uid, uid)
          .hmset(UID_ + uid, user)
          .exec (err, res) ->
            return fn err if err
            delete user.password
            fn err, user

    get: (uid, fn) ->
      db.hgetall UID_ + uid, fn

    getByUsername: (username, fn) ->
      db.get USERNAME_ + username, (err, uid) ->
        return fn err if err
        User.get uid, fn

    getByEmail: (email, fn) ->
      db.get EMAIL_ + username, (err, uid) ->
        return fn err if err
        User.get uid, fn

    # get by email or username
    getBy: (str, fn) ->
      if str.indexOf '@' > 0
        User.getByEmail str, fn
      else
        User.getByUsername str, fn

    verify: (username, password, fn) ->
      getByUsername username, (err, user) ->
        return fn err if err
        if utils.secrets.equals password, user.password
          fn user
        else
          fn()
