require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all

# customer1 = Customer.new({'name' => 'Mark', 'funds' => 100})
# customer1.save()
#
# film1 = Film.new({'title' => 'Toy Story', 'price' => 5})
# film1.save()
#
# ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
# ticket1.save()
#
# customer2 = Customer.new({'name' => 'James', 'funds' => 110})
# customer2.save()
#
# film2 = Film.new({'title' => 'Toy Story 2', 'price' => 5})
# film2.save()
#
# film3 = Film.new({'title' => 'Toy Story 3', 'price' => 5})
# film3.save()
#
# ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
# ticket2.save()
#
# screening1 = Screening.new({'screening_time' => '20:00', 'max_capacity' => 1, 'film_id' => film3.id})
# screening2 = Screening.new({'screening_time' => '21:00', 'max_capacity' => 2, 'film_id' => film3.id})
#
# customer1.name = "Jane"
# customer1.update()
# film1.title = "The Exorcist"
# film1.update()
# ticket1.film_id = film2.id
# ticket1.update()
#
# ticket1.delete()
# customer1.delete()
# film1.delete()
#
# p customer2.films()
# p film2.customers()
#
# p Ticket.all
# p customer2
# customer2.buy_ticket(film3)
# p Ticket.all
# p customer2
#
# p customer2.film_count()
# p film3.customer_count()

#Testing for advanced extension

film1 = Film.new({'title' => 'Toy Story', 'price' => 5})
film1.save()
film2 = Film.new({'title' => 'Toy Story 2', 'price' => 5})
film2.save()

customer1 = Customer.new({'name' => 'Mark', 'funds' => 100})
customer1.save()
customer2 = Customer.new({'name' => 'Caleb', 'funds' => 120})
customer2.save()
customer3 = Customer.new({'name' => 'Newton', 'funds' => 120})
customer3.save()

screening1 = Screening.new({'screening_time' => '20:00', 'max_capacity' => 1, 'film_id' => film1.id})
screening2 = Screening.new({'screening_time' => '11:00', 'max_capacity' => 1, 'film_id' => film2.id})
screening3 = Screening.new({'screening_time' => '21:00', 'max_capacity' => 2, 'film_id' => film2.id})
screening1.save()
screening2.save()
screening3.save()

customer1.buy_ticket(film1, screening1)
customer2.buy_ticket(film1, screening1)

p screening1.count_tickets()
p Ticket.all()


binding.pry
nil
