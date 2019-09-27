require('pry')
require_relative('models/customer')
require_relative('models/film')

customer1 = Customer.new({'name' => 'Mark', 'funds' => 100})

film1 = Film.new({'title' => 'Toy Story', 'price' => 5})

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})

binding.pry
nil
