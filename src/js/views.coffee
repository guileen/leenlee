
L.views = 
  renderUser: (user) ->
    user = L.user = user or L.user
    $el = $('#tpl-signin').renderX({user: user, flush:true}).show()
    $el.find('.btn-signup').click (e) ->
      e.preventDefault()
      L.loadDlg $(this).attr('href'), ($dlg)->
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
            L.views.renderUser user
            $dlg.modal('hide')

    $el.find('.btn-signin').click (e) ->
      e.preventDefault()
      L.loadDlg $(this).attr('href'), ($dlg)->
        $form = $ '#signin-form'
        $form.validate()
        $form.submit (e) ->
          e.preventDefault()
          $.post $form.attr('action'), $form.serialize(), (user) ->
            if user
              L.views.renderUser user
              $dlg.modal 'hide'
            else
              $dlg.find('.message').html('用户名或密码错误')
