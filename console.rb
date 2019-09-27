require('pry')
require_relative('models/customer')

customer1 = Customer.new({'name' => 'Mark', 'funds' => 100})



binding.pry
nil
