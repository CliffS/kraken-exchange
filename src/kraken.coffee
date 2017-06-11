KrakenPublic = require './local/KrakenPublic'
KrakenPrivate = require './local/KrakenPrivate'

class Kraken

  constructor: (@api_key, @private_key) ->

  time: ->
    krak = new KrakenPublic 'Time'
    krak.api()
    .then (result) ->
      console.log "Result:", result
    .catch (err) ->
      console.log "Caught:",  err

  tradeBalance: ->
    krak = new KrakenPrivate 'TradeBalance', @api_key, @private_key
    krak.api()
    .then (result) ->
      console.log "Result:", result
    .catch (err) ->
      console.log "Caught:",  err


module.exports = Kraken
