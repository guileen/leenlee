
L.views = 
  renderUser: (user) ->
    $el = $('#tpl-signin').renderX({user: user or L.user, flush:true}).show()
    $el.find('.btn-signup').click (e) ->
      e.preventDefault()
      L.loadDlg $(this).attr('href'), ->
        $form = $ '#signup-form'
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

    $el.find('.btn-signin').click (e) ->
      e.preventDefault()
      L.loadDlg $(this).attr('href'), ->
        console.log $dlg