# frozen_string_literal: true

require 'statement'

RSpec.describe Statement do

  it 'prints the column headings headings' do
    history = []
    expect { Statement.view(history) }.to output(/date || credit || debit || balance/).to_stdout
  end

  describe '.view' do
    
  end

  describe '.sort_chronologically' do
    it 'sorts the transaction history by date' do
      history = [['2018-10-05', '200.15', nil], ['2017-04-15', '435.78', nil]]
      expect(Statement.sort_chronologically(history).first).to eq ['2017-04-15', '435.78', nil, '435.78']
    end

    it 'calculates the running balance for multiple credit transactions' do
      history = [['2018-10-05', '200.15', nil], ['2017-04-15', '435.78', nil]]
      sorted_statement = Statement.sort_chronologically(history)
      opening_balance = sorted_statement.first.last
      closing_balance = sorted_statement[(sorted_statement.count)-1].last
      expect(opening_balance).to eq '435.78'
      expect(closing_balance).to eq '635.93'
    end

    it 'calculates the running balance for multiple debit transactions' do
      history = [['2018-10-05', nil, '0.02'], ['2017-04-15', nil, '20.05']]
      sorted_statement = Statement.sort_chronologically(history)
      opening_balance = sorted_statement.first.last
      closing_balance = sorted_statement[(sorted_statement.count)-1].last
      expect(opening_balance).to eq '-20.05'
      expect(closing_balance).to eq '-20.07'
    end

    it 'calculates the running balance for multiple mixed transactions' do
      history = [['2018-10-05', nil, '0.02'], ['2017-04-15', '435.78', nil]]
      sorted_statement = Statement.sort_chronologically(history)
      opening_balance = sorted_statement.first.last
      closing_balance = sorted_statement[(sorted_statement.count)-1].last
      expect(opening_balance).to eq '435.78'
      expect(closing_balance).to eq '435.76'
    end
  end
end

