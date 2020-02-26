Bent = require 'bent'
Path = require 'path'
{ URL } = require 'url'
Encoded = require('form-urlencoded').default

KrakenResponse = require './KrakenResponse'
Version = require('../../package.json').version

API = 'https://api.kraken.com'
APIVERSION = 0
TIMEOUT = 30000

class KrakenAPI

  constructor: (path, headers = {}, @form) ->
    @bent = Bent API, 'POST', 'json', headers
    @path = "/#{APIVERSION}/#{path}"
    @url = new URL "#{APIVERSION}/#{path}", API

  api: (headers = {}) ->
    headers['User-Agent'] = "Kraken Exchange Node Client v#{Version}"
    headers['Content-Type'] = 'application/x-www-form-urlencoded'
    body = Encoded @form
    @bent @path, body, headers
    .then (json) =>
      if json.error.length
        throw new Error "KrakenAPI: #{json.error.join "\n  "}"
      new KrakenResponse json
    # let any error propogate up to the caller


module.exports = KrakenAPI
