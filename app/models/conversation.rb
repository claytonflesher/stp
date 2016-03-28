class Conversation < ActiveRecord::Base
  belongs_to :patient_therapist_relationship
  has_many   :messages

  validates :patient_therapist_relationship_id,
            presence: true,
            uniqueness: true
end
