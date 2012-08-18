helper = require './helper'
requireLogin = helper.requireLogin

module.exports = (app) ->
  Topic = require('../models/topic') app.get 'db'

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

  app.get '/topic/:id', (req, res) ->
    Topic.get req.params.id, (err, topic) ->
      if req.xhr and req.accepts 'json'
        res.json topic
      else
        res.render 'topic/show', topic: topic

