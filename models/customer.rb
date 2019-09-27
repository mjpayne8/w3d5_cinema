require('pg')

class Customer

  attr_accessor(:name, :funds)
  attr_reader(:id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = 'INSERT INTO customers
      (name, funds)
      VALUES ($1, $2)'
    values = [@name, @funds]
    SqlRunner.run(sql,values)
  end

end
