# all-src.less

$ ->
  $dialog = $('#dialog')

  $('.btn-signup').click (e) ->
    e.preventDefault()
    $dialog.load $(this).attr('href'), ->
      $dialog.modal()

  $('.btn-signin').click (e) ->
    e.preventDefault()
    $dialog.load $(this).attr('href'), ->
      $dialog.modal()

  if navigator.userAgent.toLowerCase().indexOf('mac') < 0
   #  $(document.body).append '
   #  <link rel="stylesheet" href="/css/nanoscroller.css">
   #  <script src="/js/jquery.nanoscroller.min.js"></script>
   #  '
    $('.nano').nanoScroller preventPageScrolling: true
  else
    $('.nano, .nano .content').css "overflow-y": 'auto', 'position': 'relative'
