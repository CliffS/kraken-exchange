Property = require './Property'

class KrakenResponse extends Property

  constructor: (response) ->
    super()
    result =  JSON.parse response
    if result.error.length
      console.log 'LENGTH', result.error.length
      console.log 'TYPE', typeof result.error[0]
      console.log result.error
      process.exit()
    throw new Error result.error[0] if result.error.length
    @_result = result.result

  float: ->
    @result[key] = parseFloat val for key, val of @result
    @

  @property 'result',
    get: ->
      @fixup @_result

  fixup: (item) ->
    return item unless item is Object item
    return item if Array.isArray item
    # console.log 'FIXUP', item
    obj = {}
    for key, val of item
      key = key.replace(/^[XZ]([A-Z]{3})/, '$1').replace /[XZ]([A-Z]{3})$/, '$1'
      obj[key] = switch key
        when 'asset', 'base', 'quote'
          val.replace /^[XZ]([A-Z]{3})$/, '$1'
        when 'pair'
          val.replace(/^[XZ]([A-Z]{3})/, '$1').replace /[XZ]([A-Z]{3})$/, '$1'
        else
          @fixup val
    # console.log 'FIXED', obj
    obj

module.exports = KrakenResponse
