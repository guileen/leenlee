module.exports = (db) ->
  utils = require '../lib/utils'

  User =
    existsUsername: (username, fn) ->
      db.get 'user:username:' + username, (err, res) ->
        fn(res)

    existsEmail: (email, fn) ->
      db.get 'user:email:' + email, (err, res) ->
        fn(res)

    create: (attributes, fn) ->
      db.incr '_:user:nextid', (err, uid) ->
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
          .set('user:username:' + user.username, uid)
          .set('user:email:' + user.email, uid)
          .zadd('_:users', uid, uid)
          .hmset('user:' + uid, user)
          .exec (err, res) ->
            fn(user)

