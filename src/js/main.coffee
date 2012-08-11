# main.coffee
# L = this.L

$ ->
  L.bindEvents()
  L.fixBrowser()
  pageHandler = L.pages[$('body').data('page')]
  pageHandler() if pageHandler
