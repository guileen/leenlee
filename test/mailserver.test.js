var sendmail = require('sendmail')();

sendmail({
    from: 'guileen@gmail.com',
    to: 'post-1@localhost',
    subject: 'Re: Post 1 title',
    content: '中文中文 blabla blabla'
})
