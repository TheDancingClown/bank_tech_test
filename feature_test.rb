# frozen_string_literal: true

require './lib/account'

super_saver = Account.new
super_saver.statement
super_saver.deposit("10/01/2012", 1000)
super_saver.statement