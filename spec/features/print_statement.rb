# frozen_string_literal: true

require './lib/account'

super_saver = Account.new
super_saver.deposit(1000, '2012-01-10')
super_saver.deposit(2000, '2012-01-12')
super_saver.withdraw(500, '2012-01-14')
super_saver.print_statement
