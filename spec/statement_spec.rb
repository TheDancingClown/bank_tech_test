# frozen_string_literal: true

require 'statement'

RSpec.describe Statement do
  before(:each) do
    @transactions = [['2014-01-14', nil, '500.25'], ['2012-01-10', '1000.00', nil], ['2012-01-12', '2000.55', nil]]
    @credits = [['2018-10-05', '200.15', nil], ['2017-04-15', '435.78', nil]]
    @debits = [['2018-10-05', nil, '0.02'], ['2017-04-15', nil, '20.05']]

  end

  describe '.sort_chronologically' do
    it 'sorts the transaction history by date' do
      expect(Statement.sort_chronologically(@transactions).first).to eq ['2012-01-10', '1000.00', nil, '1000.00']
    end

    it 'calculates the running balance for multiple credit transactions' do
      sorted_statement = Statement.sort_chronologically(@credits)
      opening_balance = sorted_statement.first.last
      closing_balance = sorted_statement[(sorted_statement.count)-1].last
      expect(opening_balance).to eq '435.78'
      expect(closing_balance).to eq '635.93'
    end

    it 'calculates the running balance for multiple debit transactions' do
      sorted_statement = Statement.sort_chronologically(@debits)
      opening_balance = sorted_statement.first.last
      closing_balance = sorted_statement[(sorted_statement.count)-1].last
      expect(opening_balance).to eq '-20.05'
      expect(closing_balance).to eq '-20.07'
    end

    it 'calculates the running balance for multiple mixed transactions' do
      sorted_statement = Statement.sort_chronologically(@transactions)
      opening_balance = sorted_statement.first.last
      closing_balance = sorted_statement[(sorted_statement.count)-1].last
      expect(opening_balance).to eq '1000.00'
      expect(closing_balance).to eq '2500.30'
    end
  end

  describe '.format_date' do
    it 'formats the date to DD/MM/YYYY' do
      formatted_date = Statement.format_date(@transactions).first.first
      expect(formatted_date).to eq '10/01/2012'
    end
  end

  describe '.view' do
    it 'prints the column headings headings' do
      expect { Statement.view([]) }.to output(/date || credit || debit || balance/).to_stdout
    end

    # it 'prints a formatted statement' do
    #   $stdout = StringIO.new
    #   Statement.view(@transactions)
    #   output = $stdout.string.split("\n")
    #   expect(output.last).to eq '10/01/2012 || 1000.00 || || 1000.00'
    # end
  end
end