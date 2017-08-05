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
  k.assetPairs([ 'XBTEUR', 'ETHEUR'])
  #k.ticker 'ETHXBT', 'XBTEUR'
  #k.bidAsk 'ETHXBT', 'XBTEUR'
  #k.ohlc 'ETHXBT'
  #k.depth('XBTEUR')
  #k.trades('XBTEUR')
  #k.spread('XBTEUR')
  #k.balance()
  #k.tradeBalance('EUR')
  #k.openOrders()
  #k.closedOrders()
  #k.queryOrders('OECJU4-OTPPP-WX6MED')
  #k.tradesHistory 'no position'
  #k.queryTrades 'TZAVYC-W5T5U-IPDVZO'
  k.openPositions()
  k.profitLoss()
  #k.ledgers()
  #k.queryLedgers 'LEQFDR-QMVZ6-DJMUKM', 'LQ3OO6-PLZ74-DTPYN7'
  #k.tradeVolume 'XBTEUR', 'ETHXBT'
  #k.depositMethods 'ETH'
  #k.depositAddresses 'BTC', 'Bitcoin'
  #k.depositAddresses 'ETH', 'Ether'
  #k.depositStatus 'BTC', 'Bitcoin'
]
.then (results) =>
  console.log '---------------------------------------------'
  console.log Util.inspect results, depth: null
.catch (err) =>
  console.log 'Error:', err
