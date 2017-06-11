#!/usr/local/bin/coffee
#

Util = require 'util'

Kraken = require './kraken'

API_KEY = 'Cv4CTzYOrs92QwThlKzjw8yzEwqY5dTeRojViKkVsGLbnXSpYchB68Ib'
PRIV_KEY = 'D9y6Azn5M5pCpW5eF0Qj26nhMC4aLRlQooBlKH+iYolWAvC/GusVAHNlqPdRl/Zx7rVVk3+Py5ywkapNJgUxwQ=='

k = new Kraken API_KEY, PRIV_KEY

Promise.all [
  k.time()
  #  k.assets('XBT', 'ETH')
  #k.assetPairs([ 'XBTEUR', 'ETHEUR'])
  #k.ticker('ETHXBT', 'XBTEUR')
  #k.ohlc 'ETHXBT'
  #k.depth('XBTEUR')
  #k.trades('XBTEUR')
  #k.spread('XBTEUR')
  k.balance()
  k.tradeBalance('EUR')
  k.openOrders()
  k.closedOrders()
]
.then (results) =>
  console.log Util.inspect results, depth: null
.catch (err) =>
  console.error 'Error:', err
