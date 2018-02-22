# we need the code from bank_classes.rb,
# so we call it into this file using
# "require_relative" - which will look
# in the current folder/directory

require_relative 'bank_classes'

# we're going to create Arrays to
# collect both types of Objects:
@customers = []
@accounts = []

# Let's create a method that will act
# as a sort of "home screen" for the
# program - it welcomes and asks for direction
def welcome_screen
  @current_customer = ""
  # What is this about? We're creating a way
  # to save the currently "signed in" customer
  # and allows us access to that variable without
  # having to pass it through every proceding
  # method that is called after its set.

  puts "Welcome to Tech Talent Bank"
  puts "Please choose from the following:"
  puts "-----------------------"
  puts "1. Customer Sign-In"
  puts "2. New Customer Registration"

  choice = gets.chomp.to_i

  case choice
    when 1
      sign_in
    when 2
      sign_up("","")
      # sign_up will take two arguments
      # because it's possible we'll get
      # the info before calling that method
      # (you'll see an instance of this in sign_in).
  end

end

# this is for a user who has
# already gone through registration (sign_up)
def sign_in
  print "What's your name? "
  name = gets.chomp
  print "What's your location? "
  location = gets.chomp

  # Are there even any customers at all?
  if @customers.empty?
    # There are no customers, let's just sign up customer no. 1
    puts "No customer found with that information."
    sign_up(name, location)
    # See, that's why it takes arguments!
  end

  # Okay, there are customers...
  # but is this user's info correct?
  customer_exists = false
  @customers.each do |customer|
    if name == customer.name && location == customer.location
      @current_customer = customer
      customer_exists = true
    end
  end

  # Notice that we saved the current customer to
  # @current_customer - that way we can access that
  # variable thoroughout the proceding methods.
  # Once the user chooses to return to the welcome screen,
  # that variable will be reset to an empty String,
  # effectively, signing them out.

  if customer_exists
    # They gave us matching info to our records,
    # let's go ahead...
    account_menu
  else
    # Not finding a record of that:
    # try it again or you don't really have an
    # account so Sign Up?
    puts "No customer found with that information."
    puts "1. Try again?"
    puts "2. Sign Up"
    choice = gets.chomp.to_i

    case choice
      when 1
        sign_in
      when 2
        sign_up(name, location)
        # There! Happened again!
    end
  end
end

def sign_up(name,location)
  if name == "" && location == ""
    # If you came from welcome screen, we need to fill in the blanks
    print "What's your name? "
    name = gets.chomp
    print "What's your location? "
    location = gets.chomp
  end

  # At this point, no matter which method you came from,
  # everyone has name and location.
  # Time to create a new instance of a Customer!
  # We're also going to save them in an instance variable,
  # so we don't have to keep passing an argument down
  # the line of methods.
  @current_customer = Customer.new(name, location)

  # And save them in our customer collector!

  @customers.push(@current_customer)

  puts "Registration successful!"

  # And now we can move on to dealing with Accounts...
  account_menu
end

# Creating/Looking Up Account - what will it be?
def account_menu
  puts "Account Menu"
  puts "---------------"
  puts "1. Create an Account"
  puts "2. Review an Account"
  puts "3. Sign Out"

  choice = gets.chomp.to_i

  case choice
    when 1
      create_account
    when 2
      review_account
    when 3
      puts "Thanks for banking with us."
      # Sign Out if the user is all done...
      welcome_screen
    else
      puts "Invalid selection."
      account_menu
  end
end

# Let's create a new instance of an Account...
def create_account
  print "How much will your initial deposit be? $"
  amount = gets.chomp.to_f

  print "What type of account will you be opening? "
  acct_type = gets.chomp

  # The account number will be based on how many accounts
  # we have. So we'll check the length of the array before
  # we put this new Account into it, and add by one.
  new_acct = Account.new(@current_customer, amount, (@accounts.length+1), acct_type)
  @accounts.push(new_acct)
  puts "Account successfully created!"

  # Now we'll go back a step, so they can stay signed-in,
  # and either create another Account or review the one(s)
  # already created.
  account_menu
end

# We can look up the account using who they are signed-in as
# and what type of Account they want to review...
def review_account
  @current_account = ""
  print "Which account (type) do you want to review? "
  type = gets.chomp.downcase

  account_exists = false
  @accounts.each do |account|
    if @current_customer == account.customer && type == account.acct_type.downcase
      @current_account = account
      account_exists = true
    end
  end

  if account_exists
    current_account_actions
  else
    puts "Try again."
    review_account
  end
end

# Alright... we have an Account.
# Now what are we going to do with it?
def current_account_actions
  puts "Choose From the Following:"
  puts "----------------------"
  puts "1. Balance Check"
  puts "2. Make a Deposit"
  puts "3. Make a Withdrawal"
  puts "4. Return to Account Menu"
  puts "5. Sign Out"

  choice = gets.chomp.to_i

  case choice
    when 1
      puts "Current balance is $#{'%0.2f'%(@current_account.balance)}"
      current_account_actions
    when 2
      # This method is built into the class:
      @current_account.deposit
      current_account_actions
    when 3
      # This method is built into the class:
      @current_account.withdrawal
      current_account_actions
    when 4
      # Go back a step:
      review_account
    when 5
      # Sign Out:
      welcome_screen
    else
      puts "Invalid selection."
      current_account_actions
  end
end

# Let's get it started...
welcome_screen
