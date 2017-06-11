

class KrakenResponse

  constructor: (response) ->
    result =  JSON.parse response
    if result.error.length
      console.log 'LENGTH', result.error.length
      console.log 'TYPE', typeof result.error[0]
      console.log result.error
      process.exit()
    throw new Error result.error[0] if result.error.length
    @result = result.result

  float: ->
    @result[key] = parseFloat val for key, val of @result
    @

  currency: ->
    obj = {}
    for key, val of @result
      key = key.replace /^[XZ]([A-Z]{3})$/, '$1'
      obj[key] = val
    @result = obj
    @

  pair: ->
    obj = {}
    for key, val of @result
      key = key.replace /^[XZ]([A-Z]{3})/, '$1'
      key = key.replace /[XZ]([A-Z]{3})$/, '$1'
      obj[key] = val
    @result = obj
    @

module.exports = KrakenResponse
