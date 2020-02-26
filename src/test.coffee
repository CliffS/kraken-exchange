#!/usr/local/bin/coffee
#

Util = require 'util'

Kraken = require './kraken'

API_KEY = 'gwAidkByRFtjArFt+CkvRSsTZBA0cl034nfKUtx18ij397sE8/2m1C3P'
PRIV_KEY = 'JG5EWehOp1lo6xu8twrBRpTdLa6f0g1oR6Tiq63yD2eKmRytsYo/t8QdB0BSE5BgsxFoYHYJkFbDhnAW4OVAIQ=='

# coffeelint: disable=no_debugger

k = new Kraken API_KEY, PRIV_KEY

Promise.all [
  k.time()
  #  k.assets('XBT', 'ETH')
  #k.assetPairs([ 'XBTEUR', 'ETHEUR'])
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
  #k.profitLoss()
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
  console.log err
