# frozen_string_literal: true

# bank account
class Account
  attr_reader :statement

  def initialize
    @statement = []
  end

  def deposit(date, amount)
    @statement << [date, amount, nil] unless amount <= 0
  end

  def withdraw(date, amount)
    @statement << [date, nil, amount] unless amount <= 0
  end
end
