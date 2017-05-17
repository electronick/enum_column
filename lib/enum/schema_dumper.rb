module ActiveRecord
  module ConnectionAdapters
    module MySQL
      module ColumnDumper # :nodoc:
        private
          alias __schema_type_enum schema_type
          def schema_type(column)
            case column.sql_type
            when /enum/i
              :enum
            else
              __schema_type_enum(column)
            end
          end
      end
    end
  end
end
