require 'account'

RSpec.describe Account do
  before (:each) do
    @super_saver = Account.new
  end

  it 'initialises with an empty statement' do
    expect(@super_saver.statement).to be_empty
  end

  describe '#deposit' do
    it 'adds a credit transaction to the statement' do
      @super_saver.deposit("14/01/2012", 1000)
      expect(@super_saver.statement.first).to eq ["14/01/2012", 1000, nil]
    end
  end
end
