Request = require 'request-promise-native'
Path = require 'path'
{ URL } = require 'url'

KrakenResponse = require './KrakenResponse'

API = 'https://api.kraken.com'
APIVERSION = 0
TIMEOUT = 30000

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
      console.log 'REQUEST ERROR', err unless err.statusCode is 504
      process.exit 1

module.exports = KrakenAPI
