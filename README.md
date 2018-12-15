# kraken-exchange

[api]: https://www.kraken.com/help/api
[kraken]: https://www.kraken.com/
[coffee2]: https://coffeescript.org/v2/
[apikey]: https://www.kraken.com/u/settings/api

## Access all elements of the Kraken API

This module fully implements the [Kraken][kraken] API.  The
full documentation for the API is available on the [API help page][api].

It is written in [Coffescript V2][coffee2] using native Promises and
its only dependencies are [request](https://www.npmjs.com/package/request)
and its wrapper,
[request-promise-native](https://www.npmjs.com/package/request-promise-native).
You do not need Coffeescript to use the library; it is pre-compiled to
Javascript ES6.

Kraken uses currency symbols preceded by an `X` or a `Z` to bring all
symbols to four characters.  For example `XXBT`, `ZUSD`, `XETH` but
`DASH` with no preceding `X`.  This library uses the three-letter forms
thoughout, other than where the base symbol is four letters, e.g. `DASH`.
Thus Euros are always referred to as `EUR` and Bitcoin as `XBT`.

There are a few extra methods that are not provided by the Kraken API.
These are utility methods which generally give a simplified view of
another method.  Examples are `kraken.profitLoss()` and `kraken.bidAsk()`.

## Install

```
npm install kraken-exchange
```

Get your API key and private key from [here][apikey].

## Example

```javascript
Kraken = require('kraken-exchange');

const API_KEY = 'MlWItZtB4hqE2c2I9lg3DfnlYFvLQ9CR19Nmd373UEsJtpdAHQlk4NC3';
const PRIV_KEY = 'NZxR7Qyy7vf59fiomB0j1VFVL4J4BAVpKrHmf4hUUQefVFzhlw6as9CScA24cNNsmjb14nl65ZRyy13zlkWxzA';

const kraken = new Kraken(API_KEY, PRIV_KEY);

kraken.time()
.then(response => console.log(response));
.catch(err => console.error(err));

```
## Constructor

```javascript
const kraken = new Kraken(API_KEY, PRIV_KEY);
```


## Methods

For each method (other than the derived methods), please see
the [API documentation][api].  Below I have simply documented the call; the
response will generally be as documented by [Kraken][api].
Currency codes will have been converted and floating responses
may be returned as floats rather than strings.

All methods return Promises and pass a single result object
to the `.then()`. Optional parameters are shown within square
brackets: `[` and `]`.  It may be necessary to pass a `null` for
some parameters in order to pass later ones.

No errors are caught or reported within the library.  All calls should
have a `.catch(err)` to pick up the error.

**N.B.** The order of parameters in methods is as below which may differ
from the Kraken documentation in order to put less-used parameters
twards the end of the list.

### Derived methods

#### Average price between bid and ask

```javascript
kraken.bidAsk(...pairs)
```

The parameters can be a list of pairs or a single array can
be passed.

So `kraken.bidAsk('XBTEUR', 'ETHEUR');` or
`kraken.bidAsk(['XBTEUR', 'ETHEUR']);`, whichever is easier for the
application.

#### Profit and loss on open positions

```javascript
kraken.profitLoss(byPair = false)
```

This will return an object with the current net profit or loss for
each currency in open positions.

If `byPair` is passed as `true`, it will return the current net
profit or loss for each currency pair rather than each currency.

### Public market data

#### Get server time

```javascript
kraken.time()
```

#### Get asset info

```javascript
kraken.assets(...assets)

```
The parameters can be a list of assets or a single array can
be passed.

So `kraken.assets('XBT', 'ETH');` or
`kraken.assets(['XBT', 'ETH']);`, whichever is easier for the
application.

#### Get tradable asset pairs

```javascript
kraken.assetPairs(...pairs)
```

The parameters can be a list of pairs or a single array can
be passed.

So `kraken.assetPairs('XBTEUR', 'ETHEUR');` or
`kraken.assetPairs(['XBTEUR', 'ETHEUR']);`, whichever is easier for the
application.

#### Get ticker information

```javascript
kraken.ticker(...pairs)
```

The parameters can be a list of pairs or a single array can
be passed.

#### Get OHLC data

```javascript
kraken.ohlc(pair[, interval[, last]])
```

#### Get order book

```javascript
kraken.depth(pair[, count])
```

#### Get recent trades

```javascript
kraken.trades(pair[, since])
```

#### Get recent spread data

```javascript
kraken.spread(pair[, since])
```

### Private user data

#### Get account balance

```javascript
kraken.balance()
```

#### Get trade balance

```javascript
kraken.tradeBalance([currency])
```

#### Get open orders

```javascript
kraken.openOrders([trades[, userref]])
```

#### Get closed orders

```javascript
kraken.closedOrders([trades[, userref[, start[, end[, ofs[, closetime]]]]]])
```

#### Query orders info

```javascript
kraken.queryOrders(txids[, trades[, userref]])
```

Note that `txids` can be a single transaction id, an array of
transaction ids or a comma-separated list of transaction ids.

#### Get trades history

```javascript
kraken.tradesHistory([type[, trades[, start[, end[, ofs]]]]])
```

#### Query trades info

```javascript
kraken.queryTrades(txids[, trades])
```

Note that `txids` can be a single transaction id, an array of
transaction ids or a comma-separated list of transaction ids.

#### Get open positions

```javascript
kraken.openPositions([docalcs[, txids]]);
```

Note that `txids` can be a single transaction id, an array of
transaction ids or a comma-separated list of transaction ids.

#### Get ledgers info

```javascript
kraken.ledgers([assets[, type[, start[, end[, ofs]]]]])
```

Note that `assets` can be a single asset, an array of
assets, a comma-separated list of assets or `undefined`.

#### Query ledgers

```javascript
kraken.queryLedgers(...ids)
```

The parameters can be a list of ledger ids or a single array can
be passed.

#### Get trade volume

```javascript
kraken.tradeVolume(..pairs)
```

The parameters can be a list of currency pairs or a single array can
be passed.

### Private user trading

#### Add standard order

```javascript
kraken.addOrder(pair, type, ordertype, volume[, price[, price2[, leverage[, closetype[, closeprice[, closeprice2]]]]]])
```
or
```javascript
kraken.addOrder(params)
```
where `params` is an object with the required keys and values from
the list above.

#### Cancel open order

```javascript
kraken.cancelOrder(txid)
```

### Private user funding

#### Get deposit methods

```javascript
kraken.depositMethods(asset)
```

#### Get deposit addresses

```javascript
kraken.depositAddresses(asset, method[, newAddress])
```

#### Get status of recent deposits

```javascript
kraken.depositStatus(asset, method)
```

#### Get withdrawal information

```javascript
kraken.withdrawInfo(asset, key, amount)
```

#### Withdraw funds

```javascript
kraken.withdraw(asset, key, amount)
```

#### Get status of recent withdrawals

```javascript
kraken.withdrawStatus(asset[, method])
```

#### Request withdrawal cancelation

```javascript
kraken.withdrawCancel(asset, refid)
```

## Issues

Please report any bugs or make any suggestions at the
[Github Issue page](https://github.com/CliffS/kraken-exchange/issues).
