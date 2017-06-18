Request = require 'request'
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
    new Promise (resolve, reject) =>
      Request
        method: 'POST'
        url: @url
        headers: @headers
        form: @form
        timeout: TIMEOUT
      , (err, response, body) =>
        return reject err if err
        resolve new KrakenResponse body

module.exports = KrakenAPI
