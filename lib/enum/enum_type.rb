if defined? ActiveRecord::Type::Value
  module ActiveRecord
    module Type
      class Enum < Value # :nodoc:
        def type
          :enum
        end

        def type_cast_for_database(value)
          value.to_s
        end

        private

          def cast_value(value)
            if value == ''
              nil
            else
              value.to_sym
            end
          end
      end
    end
  end
end
