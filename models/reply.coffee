async = require 'async'
sendmail = require('sendmail')()
config = require '../config'

REPLY_ = 'reply:'
REPLIES_ = '_:replies:'
NEXT_UID = '_:nextid:reply'

module.exports = (db) ->
  utils = require '../lib/utils'

  Post = require('./post')(db)

  Reply =
    # pid - parent id
    create: (pid, attributes, fn) ->
      db.incr NEXT_UID, (err, uid) ->
        return fn err if err
        schema =
          id: uid
          created_at: +new Date,
          logged_at: +new Date,
        reply = utils.merge schema, attributes
        if not reply.content
          fn new Error('reply content is missing')
        # TODO reply email secret
        db.multi()
          .zadd(REPLIES_ + pid, uid, uid)
          .hmset(REPLY_ + uid, reply)
          .exec (err, res) ->
            return fn err if err
            fn err, reply

            if not reply.isMail
              # ... TODO
              Post.get pid, (err, post) ->
                sendmail
                  id: 'bbsnowall-' + pid
                  from: 'post-' + pid + '@' + config.dev.mail_server
                  to: config.dev.send_to
                  subject: 'Re:' + post.title
                  content: reply.content

    get: (uid, fn) ->
      db.hgetall REPLY_ + uid, fn

    getList: (pid, start, stop, fn) ->
      db.zrange REPLIES_ + pid, start, stop, (err, ids) ->
        console.log ids
        async.map ids, (id, _fn) ->
          db.hgetall REPLY_ + id, _fn
        , fn
