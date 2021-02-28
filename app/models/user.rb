require 'bcrypt'

class User < ApplicationRecord
  before_create :set_encrypt_password
  before_create :set_role

  validates :fullname, presence: true, length: { in: 5..75 }
  validates :email, presence: true, length: { in: 5..50 }
  validates :username, presence: true, uniqueness: true, length: { in: 3..15 }
  validates :password, presence: true, length: { minimum: 5 }

  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :appointments, class_name: 'Appointment'

  def my_appointments
    Appointment
      .select(:id,
              :scheduled_for,
              'teachers.fullname as teacher_fullname',
              'teachers.course',
              'CASE WHEN scheduled_for > timezone(\'utc\', now()) THEN 1 ELSE 0 END as status')
      .joins(:teacher)
      .where(user_id: id)
      .order(scheduled_for: :asc)
  end

  def set_role
    self.admin = false if admin.nil?
  end

  def set_encrypt_password
    if password.nil?
      self.password = ''
    elsif password.length >= 5
      self.password = BCrypt::Password.create password
    end
  end

  def valid_password?(password)
    self.password == BCrypt::Engine.hash_secret(password, self.password)
  end
end
