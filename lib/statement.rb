# frozen_string_literal: true

# statement handles the formatting of statements
class Statement
  class << self

    COLUMN_HEADINGS = 'date || credit || debit || balance'

    def view(transaction_history)
      puts COLUMN_HEADINGS
      sorted_history = self.sort_chronologically(transaction_history)
      sorted_history.reverse.map do |row|
        puts row.join(' || ').squeeze(' ')
      end
    end

    def sort_chronologically(transaction_history)
      balance = 0
      transaction_history.sort.map do |transaction|
        credit, debit = [transaction[1].to_f, transaction[2].to_f]
        balance += (credit - debit)
        transaction << '%.2f' % balance
      end
    end
  end
end