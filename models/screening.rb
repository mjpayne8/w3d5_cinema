require('pg')

class Screening

attr_accessor(:screening_time,:max_capacity, :film_id)
attr_reader(:id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @screening_time = options['screening_time']
    @max_capacity = options['max_capacity'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings
    (screening_time, max_capacity, film_id)
    VALUES ($1, $2, $3) RETURNING id"
    values = [@screening_time, @max_capacity, @film_id]
    @id  = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def count_tickets()
    sql = "select tickets.*
    FROM tickets
    where tickets.screening_id = $1"
    values = [@id]
    results =  SqlRunner.run(sql, values).map {|ticket| Ticket.new(ticket)}
    return results.length()
  end

  def self.all()
    sql = "SELECT * from screenings"
    return SqlRunner.run(sql).map {|screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
