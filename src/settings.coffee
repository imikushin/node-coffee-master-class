{Connection} = require "mongodb" 

exports.config =
  db:
    host: 'localhost'
    port: Connection.DEFAULT_PORT
