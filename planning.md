# Planning

## Account 
Has a statement of transactions
```
@statement = []
```
## Statement
Ordered list of transactions [[date, debit amount, credit amount], [date, debit amount, credit amount]]  
Not necessary to store balance - this can be calculated when needed.

## Deposit
Takes in two arguments (date and amount)  
Pushes a credit transaction into the statement  
```
statement << [date, amount, nil]
```

## Withdraw
Takes in two arguments (date and amount)  
Pushes a debit transaction into the statement  
```
statement << [date, nil, amount]
```

## Show Statement
Prints date, credit amount, debit amount, and balance  
For tech test specifications, balance will always start at 0  
``` 
print "date || credit || debit || balance"
balance = 0
statement.reverse.map do |transaction| {
  date = transaction[0]
  credit = transaction[1]
  debit = transaction[2]
  
  debit == nil ? balance += credit : balance -= debit

  print "#{date} || #{debit} || #{credit} || #{balance}"  
}
```

consider a Transaction class?

# Review Points To Consider

## Dates

Add a default date using todays date

## Separation of data and interface

Move the formatting into a new class

## Testing

Consider whether other output matchers for testing STDout are more appropriate
Add in coverage tester
Add more tests to avoid hard coding - multiple deposits and withdrawals

## Dates

Add a default date using todays date

## Method naming

chronological_statement does not currently sort by date