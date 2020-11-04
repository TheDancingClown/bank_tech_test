# frozen_string_literal: true

require 'statement'

RSpec.describe Statement do

  # describe '.view' do
  #   it 'calculates the balance' do
  #     history = [['10/01/2012', '1000.00', nil]]
  #     expect(Statement.view(history)).to eq '10/01/2012 || 1000.00 || || 1000.00'
  #   end
  # end

  describe '.sort_chronologically' do
    it 'sorts the transaction history by date' do
      history = [['2018-10-05', '200.15', nil], ['2017-04-15', '435.78', nil]]
      expect(Statement.sort_chronologically(history).first).to eq ['2017-04-15', '435.78', nil]
    end
  end
end

