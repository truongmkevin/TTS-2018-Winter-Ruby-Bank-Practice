require_relative 'new_bank_classes'

@customers_array = [Customer.new("Kevin", "ilovecoding"), Customer.new("Tracy", "ilovecoding"), Customer.new("Shelby", "ilovecoding")]
@accounts_array = []

def welcome_home_page
  puts "Welcome to the NOLA Bank"
  puts "Please choose from the following:"
  puts "-" * 30
  puts "1. Customer Sign In"
  puts "2. New Customer Registration"

  menu_input = gets.chomp

  case menu_input
  when "1"
    puts "Going to Sign In"
  when "2"
    puts "Going to New Registration"
    sign_up
  else
    puts "Try again"
  end
end # def welcome_home_page

def account_overview_menu
  puts "Account Overview Menu"
  puts "-" * 30
  puts "1. Create an Account"
  puts "2. Review an Account"
  puts "3. Sign Out"

  menu_input = gets.chomp

  case menu_input
  when "1"
    create_account
  when "2"
    account_details_menu
  when "3"
    # sign out
  else
    puts "Try again"
  end
end # def account_overview_menu

def account_details_menu
  puts "Choose From the Following:"
  puts "----------------------"
  puts "1. Balance Check"
  puts "2. Make a Deposit"
  puts "3. Make a Withdrawal"
  puts "4. Return to Account Menu"
  puts "5. Sign Out"

  choice = gets.chomp

  case choice
    when "1"
      puts "Current balance is $#{@current_account.balance.round(2)}"
      account_details_menu
    when "2"
      # This method is built into the class:
      @new_account.deposit
      account_details_menu
    when "3"
      # This method is built into the class:
      @new_account.withdrawal
      account_details_menu
    when "4"

    when "5"

    else
      puts "Invalid selection."
      account_details_menu
  end
end

def sign_up
  puts "Enter in the Customer Name"
  customer_name = gets.chomp
  puts "Enter in the password"
  customer_password = gets.chomp

  @customers_array.each do |custome
    if customer.name == customer_name
      puts "Customer already exists, logging in as #{customer.name}"
      @current_customer = customer
      account_overview_menu
    end
  end

  @current_customer = Customer.new(customer_name, customer_password)
  @customers_array << @current_customer
  # alternate way
  # @customers_array.push(@current_customer)

  puts "Registration Success!"

  account_overview_menu

end # def sign_up

def create_account
  puts "How much is your initial deposit?"
  amount = gets.chomp.to_f.round(2)

  puts "What type of account is this?"
  account_type = gets.chomp

  @new_account = Account.new(amount, account_type, @accounts_array.length + 1, @current_customer)
  @accounts_array << @new_account

  puts "Your account has $ #{@new_account.balance}"

  account_overview_menu
end

welcome_home_page
