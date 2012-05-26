if process.env.MONGOLAB_URI isnt undefined
    parseString = process.env.MONGOLAB_URI.split(/^mongodb\:\/\/|\:|\/|\@/g)
    dbSettings = 
        user: parseString[1]
        pass: parseString[2]
        host: parseString[3]
        port: parseString[4]
        name: parseString[5]
    console.log "dbSettings: {user: #{dbSettings.user}, pass: <not logged>, host: #{dbSettings.host}, port: #{dbSettings.port}, name: #{dbSettings.name}}"

else
    dbSettings =
        host: 'localhost'
        port: 27017
        name: 'master-class'

exports.config =
  db: dbSettings
