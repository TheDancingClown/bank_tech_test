# frozen_string_literal: true

require 'account'

RSpec.describe Account do
  before(:each) do
    @super_saver = Account.new
  end

  it 'initialises with an empty history' do
    expect(@super_saver.transaction_history).to be_empty
  end

  describe '#deposit' do
    it 'adds a credit transaction to the history' do
      @super_saver.deposit(1000, '10/01/2012')
      expect(@super_saver.transaction_history.first).to eq ['10/01/2012', '1000.00', nil]
    end

    it 'does not add a transaction with a zero amount' do
      @super_saver.deposit(0, '10/01/2012')
      expect(@super_saver.transaction_history).to be_empty
    end

    it 'does not add a transaction with a negative amount' do
      @super_saver.deposit(-1000, '10/01/2012')
      expect(@super_saver.transaction_history).to be_empty
    end

    it 'uses todays date if not passed in an argument' do
      today = Time.new(2020, 11, 03)
      allow(Time).to receive(:now).and_return(today)
      @super_saver.deposit(875.50)
      expect(@super_saver.transaction_history.first).to eq ['03/11/2020', '875.50', nil]
    end

    it 'adds multiple credits to the transaction history' do
      @super_saver.deposit(200.15, '05/10/2018')
      @super_saver.deposit(435.78, '15/04/2017')
      expect(@super_saver.transaction_history.count).to eq 2
      expect(@super_saver.transaction_history).to eq [['05/10/2018', '200.15', nil], ['15/04/2017', '435.78', nil]]
    end 
  end

  describe '#withdraw' do
    it 'adds a debit transaction to the history' do
      @super_saver.withdraw('14/01/2012', 500)
      expect(@super_saver.transaction_history.first).to eq ['14/01/2012', nil, '500.00']
    end

    it 'does not add a transaction with a zero amount' do
      @super_saver.withdraw('14/01/2012', 0)
      expect(@super_saver.transaction_history).to be_empty
    end

    it 'does not add a transaction with a negative amount' do
      @super_saver.withdraw('14/01/2012', -500)
      expect(@super_saver.transaction_history).to be_empty
    end
  end

  describe '#print_statement' do
    it 'prints the column headings' do
      expect { @super_saver.print_statement }.to output("date || credit || debit || balance\n").to_stdout
    end

    it 'shows transactions in descending chronological order' do
      @super_saver.deposit(1000, '10/01/2012')
      @super_saver.deposit(2000, '12/01/2012')
      @super_saver.withdraw('14/01/2012', 500)
      $stdout = StringIO.new
      @super_saver.print_statement
      output = $stdout.string.split("\n")
      expect(output.last).to eq '10/01/2012 || 1000.00 || || 1000.00'
    end
  end
end
