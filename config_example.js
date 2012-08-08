exports = module.exports = {
  redis: {
    host: 'localhost',
    port: 6379
  },
  oauth2: {
    base_redirect_uri: 'http://localhost:3000/signin/oauth2/',
    sina: {
      client_id: '880460163',
      secret: 'b93e10718f07462e8fda30c8015143d4',
      base: 'https://api.weibo.com',
      authorize_path: '/oauth2/authorize',
      access_token_path: '/oauth2/access_token'
    },
    github: {
      // for test, login url is http://localhost:3000/signin/github
      client_id: '892b3b191b291a5c6e70',
      secret: '6b63d69d43d85779a85cd01a1402d7fe5c51c400',
      base: 'https://github.com',
      authorize_path: '/login/oauth/authorize',
      access_token_path: '/login/oauth/access_token',
      // redirect_uri: 'http://localhost:3000/signin/oauth2/github'
    }
  }
}
