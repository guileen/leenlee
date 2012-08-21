# main.coffee
# L = this.L

$ ->
  L.bindEvents()
  L.fixBrowser()
  pageHandler = L.pages[$('body').data('page')]
  pageHandler() if pageHandler
  L.views.renderUser()
  L.models.post.getList (err, posts) ->
    L.views.renderPostList posts

L.on 'login', (data)->
  L.setUser data
  L.views.renderUser()
  L.bindEvents()
