class Message < ActiveRecord::Base
  belongs_to :conversation

  validates :topic,         presence: true
  validates :body,          presence: true
  validates :sender_type,   presence: true
  validates :sender_id,     presence: true
  validates :receiver_type, presence: true
  validates :receiver_id,   presence: true
end
