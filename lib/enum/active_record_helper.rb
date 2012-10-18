if defined?(Rails::Generator)
  module Rails
    module Generator
      class GeneratedAttribute
        def field_type_with_enumerated_attribute
          return (@field_type = :enum_select) if type == :enum
          field_type_without_enumerated_attribute
        end
        alias_method_chain :field_type, :enumerated_attribute
      end
    end
  end
end

if defined?(ActionView::Base)
	module ActionView
		module Helpers

	#form_options_helper.rb
	module FormOptionsHelper
		#def select
		def enum_select(object, method, options={}, html_options={})
			InstanceTag.new(object, method, self, options.delete(:object)).to_enum_select_tag(options, html_options)
		end
	end
	
	class InstanceTag
		def to_enum_select_tag(options, html_options={})
			if self.object.respond_to?(method_name.to_sym)
			  column = self.object.column_for_attribute(method_name)
			  if (value = self.object.__send__(method_name.to_sym))
			    options[:selected] ||= value.to_s
			  else
			    options[:include_blank] = column.null if options[:include_blank].nil?
			  end
			end
			to_select_tag(column.limit.select{|o| !o.blank?}.map{|v|[v.to_s.humanize,v]}, options, html_options)
		end
	end
	
	class FormBuilder
		def enum_select(method, options={}, html_options={})
			@template.enum_select(@object_name, method, objectify_options(options), @default_options.merge(html_options))
		end
	end

		end
	end
end