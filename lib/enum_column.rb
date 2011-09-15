class Railtie < Rails::Railtie
  initializer "enum_column.initialize" do |app|
    ActiveSupport.on_load :active_record do
      require 'enum/enum_adapter'
      #require 'enum/mysql_adapter' #if defined? ActiveRecord::ConnectionAdapters::Mysql2Adapter
      if defined? ActiveRecord::ConnectionAdapters::MysqlAdapter
        if defined? ActiveRecord::ConnectionAdapters::MySQLJdbcConnection
          #we are using JRuby
          require 'enum/jdbcmysql_adapter'
        else
          require 'enum/mysql_adapter'
        end
      end
      require 'enum/schema_statements'
      require 'enum/schema_definitions'
      require 'enum/quoting'
      require 'enum/validations'
    end

    ActiveSupport.on_load :action_view do
      require 'enum/active_record_helper'
    end
  end
end







