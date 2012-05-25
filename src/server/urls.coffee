handlers = require './handlers'
middl = require './middleware'

exports.bind = (app)->
  app.get '/', middl.all, handlers.Index
  
  app.get('/:collection/:_id?', handlers.Collection)
  app.post('/:collection', handlers.Collection)
  app.put('/:collection/:_id', handlers.Collection)
  app.delete('/:collection/:_id', handlers.Collection)

