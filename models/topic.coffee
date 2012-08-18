async = require 'async'
sendmail = require('sendmail')()

TOPIC_ = 'topic:'
TOPICS = '_:topics'
NEXT_UID = '_:nextid:topic'

module.exports = (db) ->
  utils = require '../lib/utils'

  Topic =
    create: (attributes, fn) ->
      db.incr NEXT_UID, (err, uid) ->
        return fn err if err
        schema =
          id: uid
          created_at: +new Date,
          logged_at: +new Date,
        topic = utils.merge schema, attributes
        # TODO topic email secret
        db.multi()
          .zadd(TOPICS, uid, uid)
          .hmset(TOPIC_ + uid, topic)
          .exec (err, res) ->
            return fn err if err
            fn err, topic
            sendmail
              id: 'bbsnowall-' + uid
              from: 'topic-' + uid + '@bbs.nowall.be'
              to: 'guileen@gmail.com'
              subject: topic.title
              content: topic.content

    get: (uid, fn) ->
      db.hgetall TOPIC_ + uid, fn

    getList: (start, stop, fn) ->
      db.zrevrange TOPICS, start, stop, (err, ids) ->
        console.log ids
        async.map ids, (id, _fn) ->
          db.hgetall TOPIC_ + id, _fn
        , fn
