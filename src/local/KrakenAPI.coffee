Request = require 'request-promise-native'
Path = require 'path'
{ URL } = require 'url'

KrakenResponse = require './KrakenResponse'

API = 'https://api.kraken.com'
APIVERSION = 0
TIMEOUT = 20000

class KrakenAPI

  constructor: (path, @headers = {}, @form) ->
    @url = new URL "#{APIVERSION}/#{path}", API

  api: ->
    @headers['User-Agent'] = 'Kraken Exchange Node Client'
    Request
      method: 'POST'
      url: @url
      headers: @headers
      form: @form
      timeout: TIMEOUT
    .then (response) ->
      new KrakenResponse response
    .catch (err) ->
      throw new Error err

module.exports = KrakenAPI
