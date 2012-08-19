helper = require './helper'
requireLogin = helper.requireLogin

module.exports = (app) ->
  Topic = require('../models/topic') app.get 'db'
  Reply = require('../models/reply') app.get 'db'

  app.get '/topic/', requireLogin, (req, res) ->
    Topic.find start, end, (err, topics) ->
      if req.accepts 'json'
        res.json topics

  app.post '/topic/', requireLogin, (req, res) ->
    Topic.create req.body.Topic, (err, topic) ->
      res.redirect '/topic/' + topic.id

  app.get '/topic/list', (req, res) ->
    start = parseInt req.query.start || 0
    stop = parseInt req.query.stop || 100
    Topic.getList start, stop, (err, topics) ->
      res.json topics

  app.get '/topic/new', requireLogin, (req, res) ->
    res.render 'topic/new'

  app.post '/topic/reply/:id', (req, res) ->
    id = req.params.id
    Reply.create id, req.body.Reply, (err, reply) ->
      res.redirect '/topic/' + id + '#' + reply.id

  app.get '/topic/:id', (req, res) ->
    id = req.params.id
    Topic.get id, (err, topic) ->
      Reply.getList id, 0, -1, (err, replies) ->
        res.render 'topic/show', topic: topic, replies: replies

