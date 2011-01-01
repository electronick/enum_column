module ActiveRecord
  module ConnectionAdapters
    class Mysql2Adapter
      alias __native_database_types_enum native_database_types

      def native_database_types #:nodoc
        types = __native_database_types_enum
        types[:enum] = { :name => "enum" }
        types
      end

    end
    
  end
end
