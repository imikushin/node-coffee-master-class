if process.env.MONGOLAB_URI
    parseString = process.env.MONGOLAB_URI.split(/^mongodb\:\/\/|\:|\/|\@/g)
    dbSettings =
        user:  parseString[1]
        pass:  parseString[2]
        host:  parseString[3]
        port: +parseString[4]
        name:  parseString[5]

else
    dbSettings =
        host: 'localhost'
        port: 27017
        name: 'master-class'

exports.config =
  db: dbSettings
