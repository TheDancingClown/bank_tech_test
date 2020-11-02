# frozen_string_literal: true

# A bank account
class Account
  attr_reader :statement

  def initialize
    @statement = []
  end
end
