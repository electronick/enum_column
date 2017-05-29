adapter_class = if defined? ActiveRecord::ConnectionAdapters::MySQLJdbcConnection
  ActiveRecord::ConnectionAdapters::MySQLJdbcConnection
# elsif defined? ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter
#   ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter
elsif defined? ActiveRecord::ConnectionAdapters::Mysql2Adapter
  ActiveRecord::ConnectionAdapters::Mysql2Adapter
elsif defined? ActiveRecord::ConnectionAdapters::MysqlAdapter
  ActiveRecord::ConnectionAdapters::MysqlAdapter
end

module EnumColumn
  module ConnectionAdapters
    module EnumAdapter

      def native_database_types #:nodoc
        types = super
        types[:enum] = { :name => "enum" }
        types
      end

      # Add enumeration support for schema statement creation. This
      # will have to be adapted for every adapter if the type requires
      # anything by a list of allowed values. The overrides the standard
      # type_to_sql method and chains back to the default. This could
      # be done on a per adapter basis, but is generalized here.
      #
      # will generate enum('a', 'b', 'c') for :limit => [:a, :b, :c]
      def type_to_sql(type, limit: nil, precision: nil, scale: nil, unsigned: nil, **) # :nodoc:
        if type.to_s == 'enum'
          native = native_database_types[type]
          column_type_sql = (native || {})[:name] || 'enum'

          column_type_sql << "(#{limit[:limit].map { |v| quote(v) }.join(',')})"

          column_type_sql
        else
          super(type, limit: limit, precision: precision, scale: scale, unsigned: unsigned)
        end
      end

      private
        def initialize_type_map(m)
          super

          m.register_type(%r(enum)i) do |sql_type|
            limit = sql_type.sub(/^enum\('(.+)'\)/i, '\1').split("','").map { |v| v.intern }
            ActiveRecord::Type::Enum.new(limit: limit)
          end
        end
    end
  end
end

adapter_class.prepend(EnumColumn::ConnectionAdapters::EnumAdapter)
