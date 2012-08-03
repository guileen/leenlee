# all-src.less

$ ->
  dialog = $('#dialog')

  $('.btn-signup').click (e) ->
    e.preventDefault()
    dialog.load $(this).attr('href'), ->
      dialog.modal()

  $('.btn-signin').click (e) ->
    e.preventDefault()
    dialog.load $(this).attr('href'), ->
      dialog.modal()
