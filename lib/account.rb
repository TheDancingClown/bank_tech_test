# frozen_string_literal: true

# bank account
class Account
  attr_reader :statement

  def initialize
    @statement = []
  end

  def deposit(date, amount)
    @statement << [date, '%.2f' % amount, nil] unless amount <= 0
  end

  def withdraw(date, amount)
    @statement << [date, nil, '%.2f' % amount] unless amount <= 0
  end

  def print_statement
    puts 'date || credit || debit || balance'
    chronological_statement.reverse.map do |row|
      puts row.join(' || ').squeeze(' ')
    end
  end

  private

  def chronological_statement
    balance = 0
    @statement.map do |transaction|
      credit, debit = [transaction[1].to_f, transaction[2].to_f]
      balance += (credit - debit)
      transaction << '%.2f' % balance
    end
  end
end
