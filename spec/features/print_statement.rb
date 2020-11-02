# frozen_string_literal: true

require './lib/account'

super_saver = Account.new
super_saver.deposit('10/01/2012', 1000)
super_saver.deposit('13/01/2012', 2000)
super_saver.withdraw('14/01/2012', 500)
super_saver.print_statement
