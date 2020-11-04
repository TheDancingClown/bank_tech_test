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
      today = Time.new
      allow(Time).to receive(:now).and_return(today)
      @super_saver.deposit(875.50)
      expect(@super_saver.transaction_history.first).to eq [today, '875.50', nil]
    end

    it 'adds multiple credits to the transaction history' do
      @super_saver.deposit(200.15, '05/10/2018')
      @super_saver.deposit(54.20, '14/04/2017')
      @super_saver.deposit(435.78, '15/04/2017')
      expect(@super_saver.transaction_history.first).to eq ['05/10/2018', '200.15', nil]
      expect(@super_saver.transaction_history.last).to eq ['15/04/2017', '435.78', nil]
    end 
  end

  describe '#withdraw' do
    it 'adds a debit transaction to the history' do
      @super_saver.withdraw(500, '14/01/2012')
      expect(@super_saver.transaction_history.first).to eq ['14/01/2012', nil, '500.00']
    end

    it 'does not add a transaction with a zero amount' do
      @super_saver.withdraw(0, '14/01/2012')
      expect(@super_saver.transaction_history).to be_empty
    end

    it 'does not add a transaction with a negative amount' do
      @super_saver.withdraw(-500, '14/01/2012')
      expect(@super_saver.transaction_history).to be_empty
    end

    it 'uses todays date if not passed in an argument' do
      today = Time.new
      allow(Time).to receive(:now).and_return(today)
      @super_saver.withdraw(123.45)
      expect(@super_saver.transaction_history.first).to eq [today, nil, '123.45']
    end

    it 'adds multiple debits to the transaction history' do
      @super_saver.withdraw(534.13, '25/05/2016')
      @super_saver.withdraw(200, '18/08/2018')
      @super_saver.withdraw(0.01, '18/08/2014')
      expect(@super_saver.transaction_history.first).to eq ['25/05/2016', nil, '534.13']
      expect(@super_saver.transaction_history.last).to eq ['18/08/2014', nil, '0.01']
    end 
  end

  describe '#print_statement' do
    context 'printing an empty statement' do
      specify { expect { @super_saver.print_statement }.to output("date || credit || debit || balance\n").to_stdout }
    end

    it 'shows transactions in descending chronological order' do
      @super_saver.deposit(1000, '10/01/2012')
      @super_saver.deposit(2000, '12/01/2012')
      @super_saver.withdraw(500, '14/01/2012')
      $stdout = StringIO.new
      @super_saver.print_statement
      output = $stdout.string.split("\n")
      expect(output.last).to eq '10/01/2012 || 1000.00 || || 1000.00'
    end
  end
end
