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
      @fixup @_result

  fixup: (item) ->
    return item unless item is Object item
    return item if Array.isArray item
    obj = {}
    for key, val of item
      key = key.replace(/^[XZ]([A-Z]{6,})/, '$1').replace /^([A-Z]{3})[XZ]([A-Z]{3})$/, '$1$2'
      obj[key] = switch key
        when 'asset', 'base', 'quote'
          val.replace /^[XZ]([A-Z]{3})$/, '$1'
        when 'pair'
          val.replace(/^[XZ]([A-Z]{3})/, '$1').replace /^([A-Z]{3})[XZ]([A-Z]{3})$/, '$1$2'
        else
          @fixup val
    obj

module.exports = KrakenResponse
