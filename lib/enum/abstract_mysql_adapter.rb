adapter_class = if defined? ActiveRecord::ConnectionAdapters::MysqlAdapter
  ActiveRecord::ConnectionAdapters::MysqlAdapter
end

if adapter_class
  adapter_class.module_eval do
    protected
  
    def initialize_type_map(m) # :nodoc:
      super
      # m.register_type(%r(enum)i) do |sql_type|
      #   limit = sql_type[/^enum\((.+)\)/i, 1]
      #     .split(',').map{|enum| enum.strip.length - 2}.max
      #   Type::String.new(limit: limit)
      # end
  
      m.register_type %r(tinytext)i,   Type::Text.new(limit: 255)
      m.register_type %r(tinyblob)i,   Type::Binary.new(limit: 255)
      m.register_type %r(mediumtext)i, Type::Text.new(limit: 16777215)
      m.register_type %r(mediumblob)i, Type::Binary.new(limit: 16777215)
      m.register_type %r(longtext)i,   Type::Text.new(limit: 2147483647)
      m.register_type %r(longblob)i,   Type::Binary.new(limit: 2147483647)
      m.register_type %r(^bigint)i,    Type::Integer.new(limit: 8)
      m.register_type %r(^int)i,       Type::Integer.new(limit: 4)
      m.register_type %r(^mediumint)i, Type::Integer.new(limit: 3)
      m.register_type %r(^smallint)i,  Type::Integer.new(limit: 2)
      m.register_type %r(^tinyint)i,   Type::Integer.new(limit: 1)
      m.register_type %r(^float)i,     Type::Float.new(limit: 24)
      m.register_type %r(^double)i,    Type::Float.new(limit: 53)
  
      m.alias_type %r(tinyint\(1\))i,  'boolean' if emulate_booleans
      m.alias_type %r(set)i,           'varchar'
      m.alias_type %r(year)i,          'integer'
      m.alias_type %r(bit)i,           'binary'
    end
  end
end
