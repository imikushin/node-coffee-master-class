if process.env.MONGOLAB_URI isnt undefined
    dbSettings = {}
    parseString = process.env.MONGOLAB_URI.split(/^mongodb\:\/\/|\:|\/|\@/g)
    dbSettings.user = parseString[1]
    dbSettings.pass = parseString[2]
    dbSettings.host = parseString[3]
    dbSettings.port = parseString[4]
    dbSettings.name = parseString[5]

else
    dbSettings =
        host: 'localhost'
        port: 27017
        name: 'master-class'

exports.config =
  db: dbSettings
