require('pg')
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

  def self.all()
    sql = "SELECT * from films"
    return SqlRunner.run(sql).map {|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
