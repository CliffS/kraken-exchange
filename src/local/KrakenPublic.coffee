KrakenAPI = require './KrakenAPI'

class KrakenPublic extends KrakenAPI

  constructor: (method, params) ->
    path = "public/#{method}"
    super path, undefined, params

module.exports = KrakenPublic
