if defined?(::Rails::Railtie)
  class EnumColumnRailtie < Rails::Railtie
    ActiveSupport.on_load :active_record do
      require 'enum/mysql_adapter'
      require 'enum/enum_adapter'
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