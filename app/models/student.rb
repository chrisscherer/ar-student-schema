require_relative '../../db/config'

class Student < ActiveRecord::Base
  belongs_to :teacher

  validates :email, uniqueness: true ,:format => { :with => /\A[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})\z/,
                         :message => "Invalid Email" }
  validate :older_than_three

  validates :phone, :format => { :with => /\A\(?\d{3}\)?[\ \-]?\d{3}\-\d{4}(\ x\d{4})?\z/, :message => "Invalid Phone number"}
  def name
    "#{self.first_name} #{self.last_name}"
  end

  def age
    now = Time.now.utc.to_date
    now.year - self[:birthday].year - ((now.month > self[:birthday].month || (now.month == self[:birthday].month && now.day >= self[:birthday].day)) ? 0 : 1)
  end

  def older_than_three
    errors.add(:birthday, "Age must be greater than three.") if age <= 3
  end
end
