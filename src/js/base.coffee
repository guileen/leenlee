# base.coffee

L = this.L =
  signinDlg: ()->

  closeSignDlg: ()->

  signupDlg: ()->

  closeSignupDlg: ()->

  setUserinfo: (userinfo)->

  on: (event, listener)->
    listeners = L.listeners[event] or= []
    listeners.push listener

  emit: (event, args...) ->
    listeners = L.listeners[event]
    listener args... for listener in listeners if listeners

  pages: {}

  listeners: {}

L.on 'login', (data)->
  console.log 'you have login'
  console.log data