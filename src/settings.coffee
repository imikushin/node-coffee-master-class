{Connection} = require "mongodb" 

exports.config =
  db:
    host: process.env.MONGO_HOST ? 'localhost'
    port: process.env.MONGO_PORT ? Connection.DEFAULT_PORT
    user: process.env.MONGO_USER ? undefined
    pass: process.env.MONGO_PASS ? undefined
    name: process.env.MONGO_DBNAME ? 'master-class'
    port: Connection.DEFAULT_PORT
