# Let's start off by defining classes.
# We will have two: Customer & Account.
# A Customer will be tied to an Account
# through a "customer" attribute of Account

# pretty standard stuff for the Customer class:
class Customer

  attr_accessor :name, :location

  def initialize(name, location)
    @name = name
    @location = location
  end

  # We could add more about a customer,
  # but in the interest of time,
  # we'll leave it at this.
end

class Account

  # Two things we want to be read
  # and not freely edited: Acct Num & Balance
  # For balanace we'll create methods
  # to all for more code to be within
  # the class definition, rather than out
  # in the free-standing methods.
  attr_reader :acct_number, :balance
  attr_accessor :customer, :acct_type

  def initialize(customer, balance, acct_number, acct_type)
    @customer = customer
    @balance = balance
    @acct_number = acct_number
    @acct_type = acct_type
  end

  # As mentioned above, if we can move some
  # code into the class definition, that's best.
  # So we'll have "deposit" and "withdrawal" methods
  # that do a little bit more than just
  # change the balance.

  def deposit
    puts "How much would you like to deposit?"
    print "$"
    amount = gets.chomp.to_f
    @balance += amount
    puts "Your new balance is $#{'%0.2f'%(@balance)}"
  end

  def withdrawal
    puts "How much would you like to withdraw today?"
    print "$"
    amount = gets.chomp.to_f
    # Check if there are sufficient funds!
    # (We can program in overdraft protection later...)
    if @balance < amount
      #if not, charge overdraft fee of $25
      @balance -= (amount + 25)
    else
      @balance -= amount
    end
    puts "Your new balance is $#{'%0.2f'%(@balance)}"
  end

end