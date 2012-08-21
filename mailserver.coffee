smtpd = require 'smtpd'
redis = require 'redis'
cclog = require 'cclog'
config = require './config'

db = redis.createClient(config.redis.port, config.redis.host)
db.select config.redis.database

Post = require('./models/post') db
Reply = require('./models/reply') db

cclog.debug = cclog.log
box = smtpd logger: cclog

box.on 'msg', (from, to, msg) ->
  cclog.log 'mail from:' + from + ' to:' + to
  cclog.log msg
  # msg.headers['message-id']
  id = to.split('@')[0]
  match = id.match /post-(.*)/
  if match
    id = match[1]
    cclog.log 'id', id
    Reply.create id, content: msg.text, isMail: 1, (err, reply) ->
      cclog.info 'done'

box.listen(25)
