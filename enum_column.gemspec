Gem::Specification.new do |s|
  s.name    = 'enum_column_strict'
  s.version = '0.0.2'
  s.authors = ['Nick Pohodnya', 'Aaron Weiner']
  s.email   = 'aweiner@mdsol.com'

  s.files = [
     "README.txt",
     "LICENSE",
     "init.rb",
     "lib/enum_column.rb",
     "lib/enum_column_strict.rb",
     "lib/enum/active_record_helper.rb",
     "lib/enum/enum_adapter.rb",
     "lib/enum/mysql_adapter.rb",
     "lib/enum/quoting.rb",
     "lib/enum/schema_definitions.rb",
     "lib/enum/schema_statements.rb",
     "lib/enum/validations.rb"
  ]
  s.homepage = %q{http://github.com/mdsol/enum_column}
  s.require_paths = ["lib"]
  s.summary = %q{Enum type for MySQL db, without the symbol DOS vulnerability.}
  s.description = %q{Allows your rails models and views to take advantage of MySQL's native enum type.
Forked from electronick's gem to address http://osvdb.org/show/osvdb/94679}
  s.test_files = [
     "test/test_helper.rb",
     "test/db/schema.rb",
     "test/fixtures/enumeration.rb",
     "test/fixtures/enum_controller.rb",
     "test/enum_controller_test.rb",
     "test/enum_mysql_test.rb"
  ]

end

