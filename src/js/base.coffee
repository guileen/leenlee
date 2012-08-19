# base.coffee

L = this.L =
  on: (event, listener)->
    listeners = L.listeners[event] or= []
    listeners.push listener

  emit: (event, args...) ->
    listeners = L.listeners[event]
    listener args... for listener in listeners if listeners

  listeners: {}

  pages: {}

L.loadDlg = (url, callback) ->
  L.$dialog.load url, ->
    L.fixBrowser L.$dialog
    L.$dialog.modal backdrop: true
    callback L.$dialog

L.openWindow = (url) ->
    width = 1000
    height = 600
    left = Math.floor((screen.availWidth - width) / 2)
    top = Math.floor((screen.availHeight - height) / 2)
    feature = "location=yes, titlebar=yes, width=" + width + ", height=" + height + ", top=" + top + ", left=" + left
    window.open(url, "_blank", feature)

L.fixBrowser = ($el)->
  $el = $el || $('body')

  $el.find('a[target=_top]').click (e)->
    e.preventDefault()
    L.openWindow $(this).attr 'href'

  if navigator.userAgent.toLowerCase().indexOf('mac') < 0
   #  $(document.body).append '
   #  <link rel="stylesheet" href="/css/nanoscroller.css">
   #  <script src="/js/jquery.nanoscroller.min.js"></script>
   #  '
    $el.find('.nano').nanoScroller preventPageScrolling: true
  else
    $el.find('.nano, .nano .content').css "overflow-y": 'auto', 'position': 'relative'

  $el.find('a.pjax').pjax('#pjax-content')

  $el.find('.ajax-dlg').click (e)->
    e.preventDefault()
    L.loadDlg $(this).attr 'href'

  $el.find('form._validate').validate()
  return $el

$.fn.render.defaults.engine = jst.render

$.fn.renderX = (data, options) ->
  $el = this.render(data, options)
  L.fixBrowser $el

$ ->
  L.$dialog = $ '#dialog'
