# frozen_string_literal: true

require 'account'

RSpec.describe Account do
  it 'initialises with an empty statement' do
    expect(subject.statement).to be_empty
  end
end
