# init.coffee

L.bindEvents = ()->

  $('.btn-signup').click (e) ->
    e.preventDefault()
    L.loadDlg $(this).attr('href'), ->
      $form = $ '#signup-form', $dialog
      $form.validate rules:
        'User[username]':
          remote:
            url: '/user/valid/username'
            type: 'post'
        'User[email]':
          remote:
            url: '/user/valid/email'
            type: 'post'
      , messages:
        'User[username]':
          remote: $.format '用户名 {0} 已经存在.'
        'User[email]':
          remote: $.format 'Email {0} 已经存在.'
      $form.submit (e) ->
        e.preventDefault()
        $.post $form.attr('action'), $form.serialize(), (user) ->
          console.log user

  $('.btn-signin').click (e) ->
    e.preventDefault()
    L.loadDlg $(this).attr('href'), ->
      console.log $dlg

$dialog = null
L.loadDlg = (url, callback) ->
  $dialog.load url, ->
    L.fixBrowser $dialog
    $dialog.modal backdrop: true
    callback $dialog

L.openWindow = (url) ->
    width = 1000
    height = 600
    left = Math.floor((screen.availWidth - width) / 2)
    top = Math.floor((screen.availHeight - height) / 2)
    feature = "location=yes, titlebar=yes, width=" + width + ", height=" + height + ", top=" + top + ", left=" + left
    window.open(url, "_blank", feature)

L.fixBrowser = ($el)->
  $el = $el || $('body');

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

  $el.find('.ajax-dlg').click (e)->
    e.preventDefault()
    L.loadDlg $(this).attr 'href'

  $el.find('form._validate').validate()

$ ->
  $dialog = $ '#dialog'
