require('pg')
require_relative('./customer')
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
    @id  = SqlRunner.run(sql,values)[0]['id']
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
    WHERE film_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map {|customer| Customer.new(customer)}
  end

  def customer_count()
    return customers().length()
  end

  def self.all()
    sql = "SELECT * from films"
    return SqlRunner.run(sql).map {|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
