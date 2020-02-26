KrakenAPI = require './KrakenAPI'
Querystring = require 'querystring'
Crypto = require 'crypto'

# Use the same nonce for all invocations
NONCE = new Date().valueOf() * 1000
# NONCE = 1582978752940002

sign = (path, secret, params) ->
  # console.log arguments
  message = Querystring.stringify params
  secret = Buffer.from secret, 'base64'
  hash = Crypto.createHash 'sha256'
  hmac = Crypto.createHmac 'sha512', secret
  hash_digest = hash.update(params.nonce + message).digest 'latin1'
  hmac_digest = hmac.update(path + hash_digest, 'latin1').digest 'base64'

class KrakenPrivate extends KrakenAPI

  constructor: (method, key, @secret, params = {}) ->
    super "private/#{method}", 'API-KEY': key, params

  api: ->
    @form.nonce = NONCE++
    # console.log "PATH:", @path
    sig = sign @path, @secret, @form
    #console.log sig
    #process.exit 1
    super
      'API-Sign': sig
      # 'accept-encoding': 'identity'




module.exports = KrakenPrivate
