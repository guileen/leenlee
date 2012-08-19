helper = require './helper'
requireLogin = helper.requireLogin

module.exports = (app) ->
  User = require('../models/user') app.get 'db'

  app.post '/user/valid/username', (req, res) ->
    User.existsUsername req.body.User.username, (err, exists) ->
      res.json !err && !exists

  app.post '/user/valid/email', (req, res) ->
    User.existsEmail req.body.User.email, (err, exists) ->
      res.json !err && !exists

  app.get '/user/signup', (req, res) ->
    res.render 'user/signup'

  app.post '/user/signup', (req, res, next) ->
    User.create req.body.User, (err, user) ->
      return next err if err
      delete user.password
      req.session.regenerate ->
        req.session.user = user
        res.json user

  app.get '/user/signin', (req, res) ->
    res.render 'user/signin'

  app.post '/user/signin', (req, res, next) ->
    User.verify req.body.User.username, req.body.User.password, (err, user) ->
      return next err if err
      if user
        delete user.password
        req.session.regenerate ->
          req.session.user = user
          res.json user
      else
        res.json user

  app.get '/user/signout', (req, res) ->
    req.session.regenerate ->
      res.redirect '/'

  app.get '/user/:username?', (req, res, next) ->
    username = req.params.username
    if username
      User.getByUsername username, (err, user) ->
        return next err if err
        res.json user
    else
      user = req.session.user
      res.json user

