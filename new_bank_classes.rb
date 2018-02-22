class Customer

  attr_accessor :name, :password

  def initialize(name, password)
    @name = name
    @password = password
  end

end

class Account

  attr_reader :balance, :account_number
  attr_accessor :customer, :account_type

  def initialize(balance, account_type, account_number, customer)
    @balance = balance
    @account_type = account_type
    @account_number = account_number
    @customer = customer
  end

  def deposit
    puts "How much to deposit?"
    print "$"
    amount = gets.chomp.to_f.round(2)
    @balance += amount
    puts "The new account balance is $#{@balance}"
  end

  def withdraw
    # Bonus: overdraft protection
    puts "How much to withdraw?"
    print "$"
    amount = gets.chomp.to_f.round(2)
    @balance -= amount
    puts "The new account balance is $#{@balance}"
  end

end