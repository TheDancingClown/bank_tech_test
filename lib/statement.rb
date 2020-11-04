# frozen_string_literal: true

# statement handles the formatting of statements
class Statement
  class << self

    # def view(transaction_history)
    #   balance = 0
    #   transaction_history.map do |transaction|
    #     credit, debit = [transaction[1].to_f, transaction[2].to_f]
    #     balance += (credit - debit)
    #     transaction << '%.2f' % balance
    #   end
    # end

    def sort_chronologically(transaction_history)
      transaction_history.sort
    end
  end
end