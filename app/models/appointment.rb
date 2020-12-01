class Appointment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :teacher, class_name: 'Teacher'
end
