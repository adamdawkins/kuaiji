
class Transaction
  constructor: (attributes) ->
    if attributes['amount'] is undefined
      throw new Error "Transaction requires an amount"
    else
      @[key] =  value for key, value of attributes

module.exports = Transaction

