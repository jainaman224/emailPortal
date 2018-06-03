class Account < ApplicationRecord
  belongs_to :user
  has_many :email

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  validates :email_id, presence: true, :uniqueness => true # , :format => EMAIL_REGEX
  validates :password, presence: true

  enum client: ["gmail", "outlook"]
end
