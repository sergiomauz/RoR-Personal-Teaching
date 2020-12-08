require 'bcrypt'

class User < ApplicationRecord
  before_create :set_encrypt_password
  validates :username, presence: true, uniqueness: true, length: { in: 3..20 }

  has_many :appointments, class_name: 'Appointment'

  def set_encrypt_password
    self.password = BCrypt::Password.create password
  end

  def valid_password?(password)
    self.password == BCrypt::Engine.hash_secret(password, self.password)
  end
end
