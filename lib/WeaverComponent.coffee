Weaver = require 'weaver-sdk'

weaver = new Weaver
weaver.connect 'https://weaver-server.herokuapp.com'

exports.weaver = weaver
