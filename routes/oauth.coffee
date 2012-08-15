OAuth2 = require("oauth").OAuth2
Github = require '../lib/api/github'
config = require("../config")

module.exports = (app) ->

  getAppInfo = (platform) ->
    appinfo = config.oauth2[platform]
    appinfo.redirect_uri = config.oauth2.base_redirect_uri + platform  if appinfo and not appinfo.redirect_uri
    appinfo

  getOA2 = (appinfo) ->
    new OAuth2(appinfo.client_id, appinfo.secret, appinfo.base, appinfo.authorize_path, appinfo.access_token_path)

  app.get "/user/signin/:platform", (req, res, next) ->
    platform = req.params.platform
    appinfo = getAppInfo(platform)
    return next("OAuth2 info of " + platform + " is not defined")  unless appinfo
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

  app.get "/user/signin/oauth2/:platform", (req, res, next) ->
    platform = req.params.platform
    appinfo = config.oauth2[platform]
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
      if platform == 'github'
        github = new Github access_token
        github.me (err, result) ->
          console.log err.stack if err
          console.log 'my information'
          console.log result
          # TODO get user info, map to github:username to user_id, write to session
          res.end loginScript result
      else
        res.end '<h1>platform ' + platform + ' not support yet'


loginScript = (data) ->
  # TODO redirect to where it came from if haven't opener, location= 'where came from'
  '<script>(function(e){var t=e.opener;t?(t.L.emit("login",' + JSON.stringify(data) + '),e.close()):location="/"})(window);</script>'
