# Bank Tech Test
Makers Academy - Week 10  
A tech test practicing OO design and TDD skills  

# Specification
## Requirements
You should be able to interact with your code via a REPL like IRB or the JavaScript console. (You don't need to implement a command line interface that takes input from STDIN.)  
Deposits, withdrawal.  
Account statement (date, amount, balance) printing.  
Data can be kept in memory (it doesn't need to be stored to a database or anything).  
## Acceptance criteria
Given a client makes a deposit of 1000 on 10-01-2012  
And a deposit of 2000 on 13-01-2012  
And a withdrawal of 500 on 14-01-2012  
When she prints her bank statement  
Then she would see  
```
date || credit || debit || balance  
14/01/2012 || || 500.00 || 2500.00  
13/01/2012 || 2000.00 || || 3000.00  
10/01/2012 || 1000.00 || || 1000.00
```
# Approach with user stories
```
As a user,  
So I can save for a rainy day,  
I want to pay in my salary
```
```
As a user,  
So I can have wifi to use my banking app,  
I want to be able to withdraw funds to pay bills
```
* Initialised git for source control
* Initialised Rspec for TDD
* Setup Travis for CI (tests didn't pass until JRuby removed from travis.yml)
* Setup Rubocop for linting
* TDD to create Account class, and methods for fund withdrawals and deposits
```
As a bank,  
So that accounts are easily managed,  
I don't want to store invalid transactions
```
* Additional tests for zero and negative amounts
```
As a user,  
So that I can plan my next holiday,  
I want to be able to see my balance
```
```
As a user,  
So that I can use my partner's extravagant spending as a bargaining tool,  
I want to be able to see the transaction history
```
* TDD for print_statement method
* Refactor print_statement into private method
* Refactor previous methods to store decimal places and amend tests for decimals
* Refactor print output test to be easier to read
* Submission for first review
```
As a user,  
I may want to add in a transaction that was missing,  
By passing it with a date in the past
```
* Refactored deposit and withdraw methods to use todays date if no date entered
* Changed the format dates are entered by the user for easier sorting
* Extracted formatting logic into a Statement class
* Added method to sort by date before calculating balance
* Added method to format date to requirements
# Requirements check
```
git clone https://github.com/TheDancingClown/bank_tech_test
cd bank_tech_test
bundle install
```
run the program in IRB
```
irb
require './lib/account'
super_saver = Account.new
super_saver.deposit(1000,'2012-01-10')
super_saver.deposit(2000, '2012-01-13')
super_saver.withdraw(500, '2012-01-14')
super_saver.print_statement
```
expected output
```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```
## Run Tests
```
rake
```
## Assumptions
* Accounts can be overdrawn - no limit in place
* New accounts always have a nil balance
* Amounts will always be an integer or a float with a maximum of 2 decimals
* Dates are passed in as a string in the format YYYY-MM-DD
* When printing the statement, the whole transaction history will be printed
* No description for transactions is needed
* ~~There is no time delay on transactions and therefore no need for date sorting~~
* No error messages are needed for failed transactions
* ~~If more features are needed, consideration would be given to a Transaction class~~
