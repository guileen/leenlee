var sendmail = require('sendmail')();

sendmail({
    from: 'guileen@gmail.com',
    to: 'topic-1@localhost',
    subject: 'Re: Topic 1 title',
    content: '中文中文 blabla blabla'
})
