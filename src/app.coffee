express    = require 'express'
connect    = require 'connect'
urls       = require './server/urls'
app        = express.createServer()


app.use express.cookieParser()
oneYear = 31557600000
app.use express.session 
    secret: 'development_key', cookie:
        path: '/', httpOnly: true, maxAge: oneYear
app.use connect.bodyParser()

app.configure "development", ->
    app.use '/static', express.static __dirname + '/static'
    app.use express.errorHandler
        dumpExceptions: true
        showStack: true
    app.use express.logger format: ':method :url'

app.configure "production", ->
    app.use('/static', express.static(__dirname + '/static'), maxAge: oneYear)
    app.use express.logger format: ':method :url'
    app.use express.errorHandler()

urls.bind(app)

PORT = process.env.PORT or 5001
app.listen PORT, ->
    console.log "Listening #{PORT} port..."