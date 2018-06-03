class User < ApplicationRecord
  has_many :account

  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create

  # before_save :encrypt_password
  #
  # def encrypt_password
  #   if password.present?
  #     self.salt = BCrypt::Engine.generate_salt
  #     self.password = BCrypt::Engine.hash_secret(password, salt)
  #   end
  # end

  def self.authenticate(username="", password="")
    user = User.find_by_username(username)

    if user && user.match_password(password)
      return user
    else
      return false
    end
  end

  def match_password(password="")
    # self.password == BCrypt::Engine.hash_secret(password, salt)
    self.password == password
  end
end
