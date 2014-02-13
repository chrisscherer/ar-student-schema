require 'rake'
require 'rspec/core/rake_task'
require 'faker'
require_relative 'db/config'
require_relative 'lib/students_importer'
require_relative 'app/models/teacher'
require_relative 'app/models/student'

desc "console"
task "console" do
  exec "irb -r./app.rb"
end

desc "create the database"
task "db:create" do
  touch 'db/ar-students.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-students.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc "populate the test database with sample data"
task "db:populate" do
  StudentsImporter.import
  Student.all.each { |student|
     student.teachers << Teacher.all.sample
     }
end

desc "populate the test database with sample teachers"
task "db:populate_teachers" do
  # Teacher.create(name: "Sally Smith",
  #                phone: "123-123-1234",
  #                email: "sally@gmail.com",
  #                address: "123 sdlkaffhk")

  10.times do Teacher.create(:name => Faker::Name.name,
                             :phone => Faker::PhoneNumber.cell_phone,
                             :email => Faker::Internet.email,
                             :address => Faker::Address.street_address(include_secondary = false))
  end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
