L.bindEvents = ()->

  $dialog = $ '#dialog'

  $('.btn-signup').click (e) ->
    e.preventDefault()
    $dialog.load $(this).attr('href'), ->
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
      $dialog.modal()

  $('.btn-signin').click (e) ->
    e.preventDefault()
    $dialog.load $(this).attr('href'), ->
      $dialog.modal()

L.fixBrowser = ()->

  if navigator.userAgent.toLowerCase().indexOf('mac') < 0
   #  $(document.body).append '
   #  <link rel="stylesheet" href="/css/nanoscroller.css">
   #  <script src="/js/jquery.nanoscroller.min.js"></script>
   #  '
    $('.nano').nanoScroller preventPageScrolling: true
  else
    $('.nano, .nano .content').css "overflow-y": 'auto', 'position': 'relative'
