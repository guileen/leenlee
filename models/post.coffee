async = require 'async'
sendmail = require('sendmail')()
config = require '../config'

POST_ = 'post:'
POSTS = '_:posts'
NEXT_UID = '_:nextid:post'

module.exports = (db) ->
  utils = require '../lib/utils'

  Post =
    create: (attributes, fn) ->
      db.incr NEXT_UID, (err, uid) ->
        return fn err if err
        schema =
          id: uid
          created_at: +new Date,
          logged_at: +new Date,
        post = utils.merge schema, attributes
        # TODO post email secret
        db.multi()
          .zadd(POSTS, uid, uid)
          .hmset(POST_ + uid, post)
          .exec (err, res) ->
            return fn err if err
            fn err, post
            sendmail
              id: 'bbsnowall-' + uid
              from: 'post-' + uid + '@' + config.dev.mail_server
              to: config.dev.send_to
              subject: post.title
              content: post.content

    get: (uid, fn) ->
      db.hgetall POST_ + uid, fn

    getList: (start, stop, fn) ->
      db.zrevrange POSTS, start, stop, (err, ids) ->
        console.log ids
        async.map ids, (id, _fn) ->
          db.hgetall POST_ + id, _fn
        , fn
