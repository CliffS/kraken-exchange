Request = require 'request-promise-native'
Path = require 'path'
{ URL } = require 'url'

API = 'https://api.kraken.com'
APIVERSION = 0
TIMEOUT = 5000

class KrakenAPI

  constructor: (path, @headers = {}, @form) ->
    @url = new URL "#{APIVERSION}/#{path}", API

  api: ->
    @headers['User-Agent'] = 'Kraken Exchange Node Client'
    console.log 'HEADERS', @headers
    Request
      method: 'POST'
      url: @url
      headers: @headers
      form: @form
      timeout: TIMEOUT
    .then (response) ->
      response = JSON.parse response
      throw new Error response.error if response.error.length
      response.result

class KrakenPrivate extends KrakenAPI

  constructor: (key, secret, method, params) ->

module.exports = KrakenAPI
