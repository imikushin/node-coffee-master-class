{config} = require '../settings'
mongodb  = require 'mongodb'

exports.Index = (req,res)->
  res.json
    mgs:'Привет Мир!'
    error:null

class Manager

  db: new mongodb.Db("master-class", new mongodb.Server(config.db.host, config.db.port, {}), native_parser: false)

  constructor:->
    self = @
    @db.open (err,db)->
      self.db = db
      console.log "Manager connected to #{config.db.host}:#{config.db.port}"

  id:(hex)-> new mongodb.ObjectID(hex)

  findOne:(collection, _id, callback)->
    self = @
    @db.collection collection, (err,coll)->
      coll.findOne _id: self.id(_id), (err,doc)->
        callback (if not doc? then 'not found' else err),doc

  find:(collection, query, callback)->
    self = @
    @db.collection collection, (err,coll)->
      coll.find query, (err,cursor)->
        cursor.toArray callback

  insert:(collection, obj,callback)->
    self = @
    @db.collection collection, (err,coll)->
      coll.insert obj, callback

  update:(collection, _id, obj,callback)->
    self = @
    @db.collection collection, (err,coll)->
      coll.update _id: self.id(_id), obj, callback

  remove:(collection, _id, callback)->
    self = @
    @db.collection collection, (err,coll)->
      coll.remove _id: self.id(_id), callback

manager = new Manager

exports.Collection = (req,res)->
  switch req.method
    when 'GET'
      if req.params._id
        manager.findOne req.params.collection,req.params._id, (err,doc)->
          res.json 
            err: err
            msg:'done'
            resource: doc
      else
        manager.find req.params.collection,{}, (err,arr)->
          res.json 
            err: err
            msg:'done'
            resource: arr

    when 'POST'
      manager.insert req.params.collection, req.body, (err,resp)->
        res.json
          err: err
          msg: 'done'
          resource: resp

    when 'PUT'
      manager.update req.params.collection, req.params._id, req.body, (err)->
        res.json 
          err: err
          msg:'done'

    when 'DELETE'
      manager.remove req.params.collection, req.params._id, (err)->
        res.json 
          err: err
          msg:'done'
    else
      res.json
        err: "method #{req.method} not found"
        msg: "method #{req.method} not found"
        resource: null



                               