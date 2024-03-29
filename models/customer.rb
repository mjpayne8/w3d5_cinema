require('pg')
require_relative('../db/sql_runner')
require_relative('./film')
require_relative('./ticket')
require_relative('./screening')

class Customer

  attr_accessor(:name, :funds)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (name, funds)
    VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    @id  = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def update()
    sql ="UPDATE customers
    SET (name, funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN screenings
    ON films.id = screenings.film_id
    INNER JOIN tickets
    on tickets.screening_id = screenings.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map {|film| Film.new(film)}
  end

  def buy_ticket(film, screening)
    if film.price <= @funds && screening.film_id == film.id && screening.count_tickets < screening.max_capacity
      ticket = Ticket.new({'screening_id' => screening.id, 'customer_id' => @id})
      ticket.save()
      @funds -= film.price()
    end
  end

  def film_count()
    return films().length()
  end

  def self.all()
    sql = "SELECT * from customers"
    return SqlRunner.run(sql).map {|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
