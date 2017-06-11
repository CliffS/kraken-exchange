#!/usr/local/bin/coffee
#

Kraken = require './src/kraken'

API_KEY = 'Cv4CTzYOrs92QwThlKzjw8yzEwqY5dTeRojViKkVsGLbnXSpYchB68Ib'
PRIV_KEY = 'D9y6Azn5M5pCpW5eF0Qj26nhMC4aLRlQooBlKH+iYolWAvC/GusVAHNlqPdRl/Zx7rVVk3+Py5ywkapNJgUxwQ=='

k = new Kraken API_KEY, PRIV_KEY

k.time()
k.tradeBalance()
