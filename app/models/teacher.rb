require_relative '../../db/config'

class Teacher < ActiveRecord::Base
  has_and_belongs_to_many :students

  validates :email, uniqueness: true ,:format => { :with => /\A[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})\z/,
                         :message => "Invalid Email" }
  validates :phone, :format => { :with => /\A\(?\d{3}\)?[\ \-]?\d{3}\-\d{4}(\ x\d{4})?\z/, :message => "Invalid Phone number"}
end

