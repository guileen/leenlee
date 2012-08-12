# main.coffee
# L = this.L

$ ->
  L.bindEvents()
  L.fixBrowser()
  pageHandler = L.pages[$('body').data('page')]
  pageHandler() if pageHandler
  L.models.user.get '', (err, user) ->
    $('#tpl-signin').renderX({user: user}).show()

L.on 'login', (data)->
  $('#tpl-signin').renderX({user: data, flush:true}).show()
  L.bindEvents()

