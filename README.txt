Overview

  This gem is an extension to ActiveRecord which enables native support of enumerations in the database schema using the ENUM type in MySQL.
  Currently only MySQL is implemented.
  Tested with Rails 3. For Rails 2 the enum-column plugin serves the same functionality but is vulnerable to DOS attacks with typical use.
  Works with Scaffolding.

  Supported adapters:
    mysql
    mysql2
    jdbcmysql (by Nilesh Trivedi)

How to use it.

In your Gemfile:

  gem 'enum_column_strict'

In your schema:

  When you create your schema, specify the constraint as a limit:

    create_table :enumerations, :force => true do |t|
      t.column :severity, :enum, :limit => [:low, :medium, :high, :critical], :default => :medium
      t.column :color, :enum, :limit => [:red, :blue, :green, :yellow]
      ...
    end


In the model:

  You can then automatically validate this column using:

    validates_columns :severity, :color

  The rest will be handled for you. All enumerated values will be given as symbols.

    @e = Enumeration.new
    @e.severity = :medium

You can always use the column reflection to get the list of possible values from the database column.

    Enumeration.columns_hash['color'].limit
    or
    @enumeration.column_for_attribute(:color).limit

    Will yield: [:red, :blue, :green, :yellow]

If you assign a string to the column, it will be converted to a symbol if it's valid, and nil otherwise,
so if this is the only way you populate color, validates_presence_of may be the only validation you need.

    Enumeration.new(:color => "red") (color will be :red)
    Enumeration.new(:color => "infrared") (color will be nil)

In views:

  You can use the enum_select helper to generate input for enumerated attributes:

     <%= enum_select(@enumeration, 'severity')%>
     or
     <%= form_for @enumeration do |f| %>
        <%= f.label :severity %>
        <%= f.enum_select :severity %>
     <% end %>

