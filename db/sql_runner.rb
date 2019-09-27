require("pg")

  class SqlRunner

    def run(sql, values = [])
      db = PG.connect({dbname: 'cinema', host: 'localhost'})
      db.prepare(sql)
      return db.exec_prepared(sql, values)
    end

  end
