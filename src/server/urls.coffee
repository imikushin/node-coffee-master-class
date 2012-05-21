handlers = require './handlers'
middl = require './middleware'

exports.bind = (app)->
    app.get '/', middl.all, handlers.Index

