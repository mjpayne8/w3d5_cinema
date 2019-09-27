require('pry')
require_relative('models/customer')
require_relative('models/film')

customer1 = Customer.new({'name' => 'Mark', 'funds' => 100})

film1 = Film.new({'title' => 'Toy Story', 'price' => 5})


binding.pry
nil
