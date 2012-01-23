# This module provides all the column helper methods to deal with the
# values and adds the common type management code for the adapters.


# try rails 3.1, then rails 3.2+, mysql column adapters
column_class = if defined? ActiveRecord::ConnectionAdapters::Mysql2Column
  ActiveRecord::ConnectionAdapters::Mysql2Column
elsif defined? ActiveRecord::ConnectionAdapters::MysqlColumn
  ActiveRecord::ConnectionAdapters::MysqlColumn
elsif defined? ActiveRecord::ConnectionAdapters::Mysql2Adapter::Column
  ActiveRecord::ConnectionAdapters::Mysql2Adapter::Column
elsif defined? ActiveRecord::ConnectionAdapters::MysqlAdapter::Column
  ActiveRecord::ConnectionAdapters::MysqlAdapter::Column
else
  ObviousHint::NoMysqlAdapterFound
end

column_class.module_eval do

  alias __klass_enum klass
  # The class for enum is Symbol.
  def klass
    if type == :enum
      Symbol
    else
      __klass_enum
    end
  end

  alias __type_cast_enum type_cast
  # Convert to a symbol.
  def type_cast(value)
    if type == :enum
      self.class.value_to_symbol(value)
    else
      __type_cast_enum(value)
    end
  end

  alias __type_cast_code_enum type_cast_code
  # Code to convert to a symbol.
  def type_cast_code(var_name)
    if type == :enum
      "#{self.class.name}.value_to_symbol(#{var_name})"
    else
      __type_cast_code_enum(var_name)
    end
  end

  class << self
    # Safely convert the value to a symbol.
    def value_to_symbol(value)
      case value
      when Symbol
        value
      when String
        value.empty? ? nil : value.intern
      else
        nil
      end
    end
  end

private
  alias __simplified_type_enum simplified_type
  # The enum simple type.
  def simplified_type(field_type)
    if field_type =~ /enum/i
      :enum
    else
      __simplified_type_enum(field_type)
    end
  end
  
  alias __extract_limit_enum extract_limit
  def extract_limit(sql_type)
    if sql_type =~ /^enum/i
      sql_type.sub(/^enum\('(.+)'\)/i, '\1').split("','").map { |v| v.intern }
    else
      __extract_limit_enum(sql_type)
    end
  end


end
