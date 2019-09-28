require('pg')
require_relative('./customer')
require_relative('./screening')
require_relative('../db/sql_runner')

class Film

  attr_accessor(:title, :price)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
      (title, price)
      VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    @id  = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def update()
    sql ="UPDATE films
    SET (title, price) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    INNER JOIN screenings
    ON screenings.id = tickets.screening_id
    WHERE screenings.film_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map {|customer| Customer.new(customer)}
  end

  def customer_count()
    return customers().length()
  end

  def popular_showing()
    sql = "SELECT screenings.*
    FROM screenings
    WHERE screenings.film_id = $1"
    values = [@id]
    film_screenings = SqlRunner.run(sql, values).map {|screening| Screening.new(screening)}
    count_hash = Hash.new(0)
    for item in film_screenings
      count_hash[item.screening_time] += item.count_tickets
    end
    return count_hash.max_by {|key, value| value}
  end

  def self.all()
    sql = "SELECT * FROM films"
    return SqlRunner.run(sql).map {|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
