class Teacher < ApplicationRecord
  validates :fullname, presence: true, length: { in: 5..75 }
  validates :email, presence: true, length: { in: 5..50 }
  validates :course, presence: true, length: { in: 4..50 }
  validates :description, presence: true, length: { in: 5..150 }

  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :appointments, class_name: 'Appointment'
end
