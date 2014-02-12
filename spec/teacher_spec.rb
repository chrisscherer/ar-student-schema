require 'rspec'
require 'date'
require_relative '../app/models/teacher'

describe Teacher, "#name and #email" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:teachers).should be_true
    Teacher.delete_all

    @teacher = Teacher.new
    @teacher.assign_attributes(
      :name => "Happy Gilmore",
      :email => 'male@gmail.com',
      :address => '123 something Ln',
      :phone => '123-123-1234'
    )
  end

  it "should have name and email" do
    @teacher.name.should_not == nil
    @teacher.email.should_not == nil
  end
end
