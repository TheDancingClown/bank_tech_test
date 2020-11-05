# frozen_string_literal: true

require 'account'

RSpec.describe Account do

  before(:each) do
    @super_saver = Account.new
    @today = Time.new(2020, 11, 04)
  end

  it 'initialises with an empty history' do
    expect(@super_saver.transaction_history).to be_empty
  end

  describe '#deposit' do
    it 'adds a credit transaction to the history' do
      @super_saver.deposit(1000, '2012-01-10')
      expect(@super_saver.transaction_history.first).to eq ['2012-01-10', '1000.00', nil]
    end

    it 'does not add a transaction with a zero amount' do
      @super_saver.deposit(0, '2012-01-10')
      expect(@super_saver.transaction_history).to be_empty
    end

    it 'does not add a transaction with a negative amount' do
      @super_saver.deposit(-1000, '2012-01-10')
      expect(@super_saver.transaction_history).to be_empty
    end

    it 'uses todays date if not specified' do
      allow(Time).to receive(:now).and_return(@today)
      @super_saver.deposit(875.50)
      expect(@super_saver.transaction_history.first).to eq ['2020-11-04', '875.50', nil]
    end

    it 'adds multiple credits to the transaction history' do
      @super_saver.deposit(200.15, '2018-10-05')
      @super_saver.deposit(54.20, '2017-04-14')
      @super_saver.deposit(435.78, '2017-04-15')
      expect(@super_saver.transaction_history.count).to eq 3
      expect(@super_saver.transaction_history.last).to eq ['2017-04-15', '435.78', nil]
    end 
  end

  describe '#withdraw' do
    it 'adds a debit transaction to the history' do
      @super_saver.withdraw(500, '2012-01-14')
      expect(@super_saver.transaction_history.first).to eq ['2012-01-14', nil, '500.00']
    end

    it 'does not add a transaction with a zero amount' do
      @super_saver.withdraw(0, '2012-01-14')
      expect(@super_saver.transaction_history).to be_empty
    end

    it 'does not add a transaction with a negative amount' do
      @super_saver.withdraw(-500, '2012-01-14')
      expect(@super_saver.transaction_history).to be_empty
    end

    it 'uses todays date if not specified' do
      allow(Time).to receive(:now).and_return(@today)
      @super_saver.withdraw(123.45)
      expect(@super_saver.transaction_history.first).to eq ['2020-11-04', nil, '123.45']
    end

    it 'adds multiple debits to the transaction history' do
      @super_saver.withdraw(534.13, '2012-05-25')
      @super_saver.withdraw(200, '2018-08-18')
      @super_saver.withdraw(0.01, '2014-08-18')
      expect(@super_saver.transaction_history.count).to eq 3
      expect(@super_saver.transaction_history.last).to eq ['2014-08-18', nil, '0.01']
    end 
  end

  describe '#print_statement' do

    before(:each) do
      @statement = class_double("Statement").as_stubbed_const(:transfer_nested_constants => true)
    end

    it 'prints headings for an empty statement' do
      allow(@statement).to receive(:view).with([]).and_return ["date || credit || debit || balance"]
      expect { @super_saver.print_statement }.to output("date || credit || debit || balance\n").to_stdout
    end

    it 'prints a formatted statement' do
      @super_saver.deposit(1000, '2012-01-10')
      formatted_history = [["date || credit || debit || balance"], ["10/01/2012 || 1000.00 || || 1000.00"]]
      allow(@statement).to receive(:view).with(@super_saver.transaction_history).and_return formatted_history
      $stdout = StringIO.new
      @super_saver.print_statement
      output = $stdout.string.split("\n")
      expect(output.last).to eq '10/01/2012 || 1000.00 || || 1000.00'
    end
  end
end
