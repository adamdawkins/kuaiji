require 'should' 
Transaction = require '../../models/transaction'
 
describe 'Transaction', ->
  transaction = null

  describe 'create', ->

    describe 'invalid', ->

      it 'should error if there is no amount', ->
        (->
          new Transaction {}
        ).should.throwError 'Transaction requires an amount'

      it "should error if amount isn't a number", ->
        (->
          new Transaction {amount: 'hello'}
        ).should.throwError 'amount must be a number'

    describe 'valid', ->
      transaction = null

      before ->
       transaction = new Transaction {amount: 10.00} 

      it "should have an amount property", ->
        transaction.should.have.property 'amount'

      it "should set amount to passed value", ->
        transaction.amount.should.equal 10.00
      
      it "should have a date property", ->
        transaction.should.have.property 'date'

      it "should set date to now without passed attribute", ->
        now = new Date()
        transaction.date.getFullYear().should.equal now.getFullYear()
        transaction.date.getMonth().should.equal now.getMonth() 
        transaction.date.getDate().should.equal now.getDate()

      it "should set date to passed value", ->
        transaction = new Transaction {amount: 10.00, date: 'Dec 25, 2010'} 

        transaction.date.getFullYear().should.equal 2010
        transaction.date.getMonth().should.equal 11 # months are an array in JavaScript
        transaction.date.getDate().should.equal 25
      
