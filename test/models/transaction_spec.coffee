require 'should'

Transaction = require '../../models/transaction'
 
describe 'Transaction', ->
  describe 'empty model', ->

    describe 'create', ->

      transaction = null

      it 'should error if there is no amount', ->
        (->
          new Transaction {}
        ).should.throwError 'Transaction requires an amount'
