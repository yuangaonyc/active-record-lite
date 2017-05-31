require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params.keys.map do |col|
      "#{col}= ?"
    end.join(" AND ")

    parse_all(DBConnection.execute(<<-SQL, *params.values))
      SELECT
        *
      FROM
        #{self.table_name}
      where
        #{where_line}
    SQL
  end
end

class SQLObject
  extend Searchable
end
