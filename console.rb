require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

customer1 = Customer.new({'name' => 'Mark', 'funds' => 100})
customer1.save()

film1 = Film.new({'title' => 'Toy Story', 'price' => 5})
film1.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

binding.pry
nil
