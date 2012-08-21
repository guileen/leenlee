helper = require './helper'
requireLogin = helper.requireLogin

module.exports = (app) ->
  Post = require('../models/post') app.get 'db'
  Reply = require('../models/reply') app.get 'db'

  app.get '/post/', requireLogin, (req, res) ->
    Post.find start, end, (err, posts) ->
      if req.accepts 'json'
        res.json posts

  app.post '/post/', requireLogin, (req, res) ->
    Post.create req.body.Post, (err, post) ->
      res.redirect '/post/' + post.id

  app.get '/post/list', (req, res) ->
    start = parseInt req.query.start || 0
    stop = parseInt req.query.stop || 100
    Post.getList start, stop, (err, posts) ->
      res.json posts

  app.get '/post/new', requireLogin, (req, res) ->
    res.render 'post/new'

  app.post '/post/reply/:id', (req, res) ->
    id = req.params.id
    Reply.create id, req.body.Reply, (err, reply) ->
      res.redirect '/post/' + id + '#' + reply.id

  app.get '/post/:id', (req, res) ->
    id = req.params.id
    Post.get id, (err, post) ->
      Reply.getList id, 0, -1, (err, replies) ->
        res.render 'post/show', post: post, replies: replies

