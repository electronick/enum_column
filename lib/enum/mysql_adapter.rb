adapter_class = if defined? ActiveRecord::ConnectionAdapters::MySQLJdbcConnection
  ActiveRecord::ConnectionAdapters::MySQLJdbcConnection
elsif defined? ActiveRecord::ConnectionAdapters::Mysql2Adapter
  ActiveRecord::ConnectionAdapters::Mysql2Adapter
elsif defined? ActiveRecord::ConnectionAdapters::MysqlAdapter
  ActiveRecord::ConnectionAdapters::MysqlAdapter
end

adapter_class.module_eval do
  alias __native_database_types_enum native_database_types

  def native_database_types #:nodoc
    types = __native_database_types_enum
    types[:enum] = { :name => "enum" }
    types
  end
end