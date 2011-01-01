Overview

  This plugin is an ROR extension to support enumerations in the database schema using the enum type in MySQL. Currently only MySQL is implemented.
  Tested with Rails 3, for Rails 2 you should better use enum-column plugin (http://rubyforge.org/projects/enum-column/)

How to use it.

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
    @e.severity = :low

You can always use the column reflection to get the list of possible values from the database column.

    Enumeration.columns_hash['color'].limit
    or
    @enumeration.column_for_attribute(:question_type).limit
    
    Will yield: [:red, :blue, :green, :yellow]
   


