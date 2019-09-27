require('pg')

class Screening

attr_accessor(:screening_time, :@tickets_sold, :max_capacity, :film_id)
attr_reader(:id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @screening_time = options['screening_time']
    @tickets_sold = 0
    @max_capacity = options['max_capacity'].to_i
    @film_id = options['film_id'].to_i
  end

end
