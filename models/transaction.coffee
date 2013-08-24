
class Transaction

  constructor: (attributes) ->
    amount = attributes['amount']
    date = attributes['date']
    description = attributes['description']

    if amount is undefined
      throw new Error "Transaction requires an amount"
    else if typeof amount isnt "number"
      throw new Error "amount must be a number"
    else if description is undefined
      throw new Error "Transaction requires a description"
    else
      @amount = amount
      @description = description
      unless date is undefined
        @date = new Date(date)

    @setDefaults()

  setDefaults: ->
    unless @date
      @date = new Date()
    @explainations = []

  addExplaination: (explaination) ->
    if @amount > 0 and explaination.value > @amount
      throw new Error(
        "explaination of #{explaination.value} was added, but only #{@amount} is unexplained"
      )

    if @amount < 0 and explaination.value < @amount
      throw new Error(
        "explaination of #{explaination.value * -1} was added, but only #{@amount *-1} is unexplained"
      )

    @explainations.push explaination 
    


module.exports = Transaction
