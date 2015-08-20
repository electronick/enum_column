# This module provides all the column helper methods to deal with the
# values and adds the common type management code for the adapters.

adapter_class = if defined? ActiveRecord::ConnectionAdapters::Mysql2Adapter
  ActiveRecord::ConnectionAdapters::Mysql2Adapter
elsif defined? ActiveRecord::ConnectionAdapters::MysqlAdapter
  ActiveRecord::ConnectionAdapters::MysqlAdapter
end

if adapter_class
  adapter_class.class_eval do

    protected
      if instance_methods.include?(:initialize_type_map)
        def initialize_type_map_with_enum_types(m)
          initialize_type_map_without_enum_types(m)
          m.register_type(%r(enum)i) do |sql_type|
            limit = sql_type.sub(/^enum\('(.+)'\)/i, '\1').split("','").map { |v| v.intern }
            ActiveRecord::Type::Enum.new(limit: limit)
          end
        end
        alias_method_chain :initialize_type_map, :enum_types
      end
  end
end
