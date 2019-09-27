require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Mark', 'funds' => 100})
customer1.save()

film1 = Film.new({'title' => 'Toy Story', 'price' => 5})
film1.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

customer2 = Customer.new({'name' => 'James', 'funds' => 110})
customer2.save()

film2 = Film.new({'title' => 'Toy Story 2', 'price' => 5})
film2.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()

customer1.name = "Jane"
customer1.update()
film1.title = "The Exorcist"
film1.update()
ticket1.film_id = film2.id
ticket1.update()

binding.pry
nil
