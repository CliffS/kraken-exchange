util = require 'util'
Property = require './Property'

class KrakenResponse extends Property

  constructor: (response) ->
    super()
    result =  JSON.parse response
    throw new Error result.error[0] if result.error.length
    @_result = result.result

  float: ->
    @_result[key] = parseFloat val for key, val of @_result
    @

  @property 'result',
    get: ->
      @fixpairs @_result

  fixpairs: (pairs) ->
    obj = {}
    for key, pair of pairs
      alt = pair.altname
      if alt and pair.wsname
        [ base, quote ] = pair.wsname.split '/'
        pair.oldkey = key
        pair.base = base
        pair.quote = quote
        pair.fee_volume_currency = pair.fee_volume_currency.replace /^[XZ]([A-Z]{3,})/, '$1'
        obj[alt] = pair
      else
        obj[key] = val for key, val of @fixup [key]: pair
    obj

  fixup: (item) ->
    return item unless item is Object item
    return item if Array.isArray item
    obj = {}
      key = key.replace /^[XZ]?([A-Z]{3})(?:[XZ]?([A-Z]{3}))?(?:\.d)?$/, '$1$2'
      obj[key] = switch key
        when 'asset', 'base', 'quote'
          val.replace /^[XZ]([A-Z]{3})$/, '$1'
        when 'pair'
          val.replace(/^[XZ]?([A-Z]{3})[XZ]?([A-Z]{3})(?:\.d)?$/, '$1$2')
        else
          @fixup val
    obj

module.exports = KrakenResponse
