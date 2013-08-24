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
    before ->
      transaction = new Transaction {amount: 10.00, description: 'transaction'}
    it "rejects explainations that are of greater value than the amount", ->
      (->
        transaction.addExplaination {value: 15.00, description: 'explaination'}
      ).should.throwError "explaination of 15 was added, but only 10 is unexplained" 


