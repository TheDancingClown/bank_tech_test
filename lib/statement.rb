# frozen_string_literal: true

# statement handles the formatting of statements
class Statement
  class << self

    COLUMN_HEADINGS = 'date || credit || debit || balance'

    def sort_chronologically(transaction_history)
      balance = 0
      transaction_history.sort.map do |transaction|
        credit, debit = [transaction[1].to_f, transaction[2].to_f]
        balance += (credit - debit)
        transaction << '%.2f' % balance
      end
    end

    def format_date(transaction_history)
      sorted_history = self.sort_chronologically(transaction_history)
      sorted_history.map do |transaction|
        transaction[0] = transaction[0].split('-').reverse.join('/')
        transaction
      end
    end

    def view(transaction_history)
      date_format = self.format_date(transaction_history)
      column_format = date_format.reverse.map do |row|
       row.join(' || ').squeeze(' ')
      end
      column_format.unshift(COLUMN_HEADINGS)
    end
  end
end
