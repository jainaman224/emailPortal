class Email < ApplicationRecord
  belongs_to :account

  validates :message_id, presence: true
  validates :from, presence: true
  validates :date, presence: true
end
