require('pg')

class Film

  attr_accessor(:title, :price)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = 'INSERT INTO films
      (title, price)
      VALUES ($1, $2)'
    values = [@title, @price]
    SqlRunner.run(sql,values)
  end

end
