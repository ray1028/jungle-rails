class User < ActiveRecord::Base
  has_secure_password
  validates :password, :email, :name, :password_confirmation, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  validates :password, length: { :minimum => 6 }

  def self.authenticate_with_credentials(inputEmail, inputPassword)
    user = User.find_by_email(inputEmail.strip)
    if user && user.authenticate(inputPassword.strip)
      return user
    end
    return nil
  end
end

