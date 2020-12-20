require 'bcrypt'

class User < ApplicationRecord
  before_create :set_encrypt_password  

  validates :fullname, presence: true, length: { in: 5..75 }
  validates :username, presence: true, uniqueness: true, length: { in: 3..15 }
  validates :email, presence: true, length: { in: 5..50 }
  validates :password, presence: true, length: { minimum: 5 }

  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :appointments, class_name: 'Appointment'

  def set_encrypt_password    
    if self.password.nil?
      self.password = ''
    else 
      if self.password.length >= 5
        self.password = BCrypt::Password.create password
      end      
    end    
  end

  def valid_password?(password)
    self.password == BCrypt::Engine.hash_secret(password, self.password)
  end
end
