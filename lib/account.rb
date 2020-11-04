# frozen_string_literal: true

# account handles storage of transactions
class Account
  attr_reader :transaction_history

  def initialize
    @transaction_history = []
  end

  def deposit(amount, date = (Time.now.strftime "%Y-%m-%d"))
    @transaction_history << [date, '%.2f' % amount, nil] unless amount <= 0
  end

  def withdraw(amount, date = (Time.now.strftime "%Y-%m-%d"))
    @transaction_history << [date, nil, '%.2f' % amount] unless amount <= 0
  end
end
