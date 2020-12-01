class Teacher < ApplicationRecord
  has_many :appointments, class_name: 'Appointment'
end
