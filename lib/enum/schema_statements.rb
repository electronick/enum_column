module ActiveRecord
  module ConnectionAdapters # :nodoc:
    module SchemaStatements
      alias __type_to_sql_enum type_to_sql

      # Add enumeration support for schema statement creation. This
      # will have to be adapted for every adapter if the type requires
      # anything by a list of allowed values. The overrides the standard
      # type_to_sql method and chains back to the default. This could 
      # be done on a per adapter basis, but is generalized here.
      #
      # will generate enum('a', 'b', 'c') for :limit => [:a, :b, :c]
      def type_to_sql(type, limit = nil, precision = nil, scale = nil) #:nodoc:
        if type == :enum
          native = native_database_types[type]
          column_type_sql = (native || {})[:name] || 'enum'

          column_type_sql << "(#{limit.map { |v| quote(v) }.join(',')})"

          column_type_sql
        else
          __type_to_sql_enum(type, limit, precision, scale)
        end
      end
    end
  end
end
