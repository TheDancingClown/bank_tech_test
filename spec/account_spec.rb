# frozen_string_literal: true

require 'account'

RSpec.describe Account do
  before(:each) do
    @super_saver = Account.new
  end

  it 'initialises with an empty statement' do
    expect(@super_saver.statement).to be_empty
  end

  describe '#deposit' do
    it 'adds a credit transaction to the statement' do
      @super_saver.deposit('10/01/2012', 1000)
      expect(@super_saver.statement.first).to eq ['10/01/2012', '1000.00', nil]
    end

    it 'does not add a transaction with a zero amount' do
      @super_saver.deposit('10/01/2012', 0)
      expect(@super_saver.statement).to be_empty
    end

    it 'does not add a transaction with a negative amount' do
      @super_saver.deposit('10/01/2012', -1000)
      expect(@super_saver.statement).to be_empty
    end
  end

  describe '#withdraw' do
    it 'adds a debit transaction to the statement' do
      @super_saver.withdraw('14/01/2012', 500)
      expect(@super_saver.statement.first).to eq ['14/01/2012', nil, '500.00']
    end

    it 'does not add a transaction with a zero amount' do
      @super_saver.withdraw('14/01/2012', 0)
      expect(@super_saver.statement).to be_empty
    end

    it 'does not add a transaction with a negative amount' do
      @super_saver.withdraw('14/01/2012', -500)
      expect(@super_saver.statement).to be_empty
    end
  end

  describe '#print_statement' do
    it 'prints the column headings' do
      expect { @super_saver.print_statement }.to output("date || credit || debit || balance\n").to_stdout
    end

    it 'shows transactions in descending chronological order' do
      @super_saver.deposit('10/01/2012', 1000)
      @super_saver.deposit('12/01/2012', 2000)
      @super_saver.withdraw('14/01/2012', 500)
      $stdout = StringIO.new
      @super_saver.print_statement
      output = $stdout.string.split("\n")
      expect(output.last).to eq "10/01/2012 || 1000.00 || || 1000.00"
    end
  end
end
