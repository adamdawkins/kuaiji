require 'should' 
Transaction = require '../../models/transaction'
 
describe 'Transaction', ->
  transaction = null

  describe 'new', ->

    describe 'invalid attributes', ->

      it "throws error if there is no amount", ->
        (->
          new Transaction {}
        ).should.throwError 'Transaction requires an amount'

      it "throws error if amount isn't a number", ->
        (->
          new Transaction {amount: 'hello'}
        ).should.throwError 'amount must be a number'

      it "throws error if there is no description", ->
        (->
          new Transaction {amount: 5.00}
        ).should.throwError 'Transaction requires a description'

    describe 'valid attributes', ->
      transaction = null

      before ->
       transaction = new Transaction {
         amount: 10.00
         description: 'My transaction'
       } 

      it "has an amount property", ->
        transaction.should.have.property 'amount'

      it "sets amount to passed value", ->
        transaction.amount.should.equal 10.00
      
      it "has a date property", ->
        transaction.should.have.property 'date'

      it "sets date to now without passed attribute", ->
        now = new Date()
        transaction.date.getFullYear().should.equal now.getFullYear()
        transaction.date.getMonth().should.equal now.getMonth()
        transaction.date.getDate().should.equal now.getDate()

      it "sets date to passed attribute", ->
        transaction_with_date = new Transaction {
          amount: 10.00
          description: 'My transaction'
          date: 'Dec 25, 2010'
        }

        transaction_with_date.date.getFullYear().should.equal 2010
        transaction_with_date.date.getMonth().should.equal 11
        transaction_with_date.date.getDate().should.equal 25

      it "has a description property", ->
        transaction.should.have.property 'description'
  
  describe "addExplaination()", ->
    describe "invalid", ->
      it "rejects explainations that are of greater value than the amount", ->
        transaction = new Transaction {amount: 10.00, description: 'transaction'}

        (->
          transaction.addExplaination {value: 15.00, description: 'explaination'}
        ).should.throwError "explaination of 15 was added, but only 10 is unexplained"
      it "rejects explainations that are of lesser amount if amount is negative", ->
        transaction = new Transaction {amount: -10.00, description: 'transaction'}
        (->
          transaction.addExplaination {value: -15.00, description: 'explaination'}
        ).should.throwError "explaination of 15 was added, but only 10 is unexplained"
    describe "valid", ->
      before ->
        transaction = new Transaction {amount: 10.00, description: 'transaction'}
        transaction.addExplaination {value: 5.00, description: 'explaination'}

      it "adds explaination to explainations property", ->
        transaction.explainations.length.should.equal 1
        transaction.explainations[0].value.should.equal 5.00

      it "reduces the unexplained amount by the value of the explaination", ->
        transaction.unexplained_amount.should.equal 5.00

      it "reduces the unexplained amount for negative transactions", ->
        negative_transaction = new Transaction {
          amount: -10.00
          description: 'transaction'
        }

        negative_transaction.addExplaination {
          value: -5.00
          description: 'explaination'
        }

        negative_transaction.unexplained_amount.should.equal 5.00

