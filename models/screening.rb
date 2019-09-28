require('pg')

class Screening

attr_accessor(:screening_time, :tickets_sold, :max_capacity, :film_id)
attr_reader(:id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @screening_time = options['screening_time']
    @max_capacity = options['max_capacity'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings
    (screening_time, ticket_sold, max_capacity, film_id)
    VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@screening_time, @tickets_sold, @max_capacity, @film_id]
    @id  = SqlRunner.run(sql,values)[0]['id']
  end

end
