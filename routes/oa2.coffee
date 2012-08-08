OAuth2 = require("oauth").OAuth2
config = require("../config")

module.exports = (app) ->

  getAppInfo = (type) ->
    appinfo = config.oauth2[type]
    appinfo.redirect_uri = config.oauth2.base_redirect_uri + type  if appinfo and not appinfo.redirect_uri
    appinfo

  getOA2 = (appinfo) ->
    new OAuth2(appinfo.client_id, appinfo.secret, appinfo.base, appinfo.authorize_path, appinfo.access_token_path)

  app.get "/signin/:type", (req, res, next) ->
    type = req.params.type
    appinfo = getAppInfo(type)
    return next("OAuth2 info of " + type + " is not defined")  unless appinfo
    oa2 = getOA2(appinfo)
    ###
    github params
    scope : comma seperate scope, default is read only. e.g. ['user', 'public_repo', 'repo', 'delete_repo', 'gist']
    state : random string to prevent CSRF
    ###
    res.redirect oa2.getAuthorizeUrl(
      redirect_uri: appinfo.redirect_uri
      response_type: "code"
    )

  app.get "/signin/oauth2/:type", (req, res, next) ->
    type = req.params.type
    appinfo = config.oauth2[type]
    oa2 = getOA2(appinfo)
    query = req.query
    code = query.code
    console.log code
    oa2.getOAuthAccessToken code,
      redirect_uri: appinfo.redirect_uri
    , (err, access_token, refresh_token, results) ->
      return next(err)  if err
      console.log "access_token %s", access_token
      console.log "refresh_token %s", refresh_token
      # TODO get user info, map to github:username to user_id, write to session
      # TODO redirect to where it came from
      res.redirect "/"
