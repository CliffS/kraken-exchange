KrakenAPI = require './KrakenAPI'
Querystring = require 'querystring'
Crypto = require 'crypto'

# Use the same nonce for all invocations
NONCE = new Date().valueOf() * 1000

sign = (path, secret, params) ->
  console.log "PARAMS", params
  message = Querystring.stringify params
  secret = Buffer.from secret, 'base64'
  hash = Crypto.createHash 'sha256'
  hmac = Crypto.createHmac 'sha512', secret
  hash_digest = hash.update(params.nonce + message).digest 'latin1'
  hmac_digest = hmac.update(path + hash_digest, 'latin1').digest 'base64'

class KrakenPrivate extends KrakenAPI

  constructor: (method, key, secret, params = {}) ->
    headers =
      'API-KEY': key
    path = "private/#{method}"
    super path, headers, params
    @key = key
    @secret = secret

  api: ->
    @form.nonce = NONCE++
    path = @url.pathname
    console.log 'PATH', path
    sig = sign path, @secret, @form
    @headers['API-Sign'] = sig
    super()




module.exports = KrakenPrivate
