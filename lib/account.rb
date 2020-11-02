class Account

  attr_reader :statement

  def initialize
    @statement = []
  end

  def deposit(date, amount)
    @statement << [date, amount, nil]
  end

end
