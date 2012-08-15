# main.coffee
# L = this.L

$ ->
  L.bindEvents()
  L.fixBrowser()
  pageHandler = L.pages[$('body').data('page')]
  pageHandler() if pageHandler
  L.views.renderUser()

L.on 'login', (data)->
  L.setUser data
  L.views.renderUser()
  L.bindEvents()
