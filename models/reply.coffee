async = require 'async'
sendmail = require('sendmail')()

REPLY_ = 'reply:'
REPLIES_ = '_:replies:'
NEXT_UID = '_:nextid:reply'

module.exports = (db) ->
  utils = require '../lib/utils'

  Topic = require('./topic')(db)

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
        # TODO reply email secret
        db.multi()
          .zadd(REPLIES_ + pid, uid, uid)
          .hmset(REPLY_ + uid, reply)
          .exec (err, res) ->
            return fn err if err
            fn err, reply

            # ... TODO
            Topic.get pid, (err, topic) ->
              sendmail
                id: 'bbsnowall-' + pid
                from: 'topic-' + pid + '@bbs.nowall.be'
                to: 'guileen@gmail.com'
                subject: 'Re:' + topic.title
                content: reply.content

    get: (uid, fn) ->
      db.hgetall REPLY_ + uid, fn

    getList: (pid, start, stop, fn) ->
      db.zrange REPLIES_ + pid, start, stop, (err, ids) ->
        console.log ids
        async.map ids, (id, _fn) ->
          db.hgetall REPLY_ + id, _fn
        , fn
