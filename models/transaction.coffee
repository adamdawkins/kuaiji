
class Transaction
  constructor: (attributes) ->
    amount = attributes['amount']
    date = attributes['date']
    if amount is undefined
      throw new Error "Transaction requires an amount"
    else if typeof amount isnt "number"
      throw new Error "amount must be a number"

    @amount = amount
   
    unless date is undefined
      @date = new Date(date)

    @setDefaults()

  setDefaults: ->
    unless @date
      @date = new Date()



module.exports = Transaction

